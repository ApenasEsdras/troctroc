import axios from "axios";
import { constantes } from "../config/constantes";
import { Recurso, RecursoSaldo } from "../models";
import { admin } from "../firebaseInicializer";
import { FieldValue } from "firebase-admin/firestore";

export class RecursoService {
  apiUrl = constantes.apiUrl + constantes.rotaRecursos;
  recursoSaldo = this.apiUrl + constantes.rotaRecursoSaldo;
  versao = 0;
  gravadosQtd = 0;
  db = admin.firestore();

  async gravaRecursosRecursivo(pagina: number, porpagina: number): Promise<void> {
    const { recursos, totalPaginas } = await this.consultaRecursos(pagina, porpagina);
    if (recursos.length === 0) {
      return;
    }

    await this.gravaRecursos(recursos);
    if (pagina < totalPaginas) {
      const proximaPagina = pagina + 1;
      await this.gravaRecursosRecursivo(proximaPagina, porpagina);
    }
  }

  async gravaRecursos(recursos: Recurso[]): Promise<void> {
    const recursosCollection = this.db.collection("recursos");
    const batchSize = 1000;

    const batches = [];

    for (let i = 0; i < recursos.length; i += batchSize) {
      const batch = this.db.batch();
      const recursosSlice = recursos.slice(i, i + batchSize);
      for (const recurso of recursosSlice) {
        const docId = recurso.chave.toString();
        const data = await this.montaRecursos(recurso);
        batch.set(recursosCollection.doc(docId), { ...data });
      }
      batches.push(batch.commit());
      this.gravadosQtd += recursosSlice.length;
    }

    await Promise.all(batches);
  }

  async consultaRecursos(pagina: number, porpagina: number): Promise<{ recursos: Recurso[], totalPaginas: number }> {
    console.log(this.apiUrl + this.versao);
    const apiResponse = await axios.get(this.apiUrl + this.versao, {
      headers: {
        pagina: pagina,
        porpagina: porpagina,
        Authorization: constantes.token,
      },
    });

    if (apiResponse.status !== 200) {
      throw new Error("Erro ao obter dados da API: " + apiResponse.statusText);
    }

    const responseData = apiResponse.data;
    if (!responseData.paginacao || !responseData.paginacao.totalPaginas) {
      throw new Error("Dados de paginação não encontrados na resposta da API.");
    }

    return { recursos: responseData.recursos || [], totalPaginas: responseData.paginacao.totalPaginas };
  }


  async montaRecursos(recurso: Recurso): Promise<any> {
    const estoqueFormatted = recurso.estoque.map((item) => ({
      quantidade: item.quantidade ?? '',
      estabelecimento: item.estabelecimento.chave ?? '',
      nomeEstabelecimento: item.estabelecimento.nome ?? '',
      codigoEstabelecimento: item.estabelecimento.codigo ?? '',
    }));

    return {
      codigo: recurso.codigo?.toLocaleUpperCase() || '',
      codigoProprio: recurso.codigoProprio?.toLocaleUpperCase() || '',
      codigoAntigo: recurso.codigoAntigo?.toLocaleUpperCase() || '',
      classe: recurso.classe,
      preco: recurso.preco,
      estoque: estoqueFormatted,
      unidadeMedida: recurso.unidadeMedida || {},
      imgUrl: recurso.imgUrl,
      nome: recurso.nome?.toLocaleUpperCase() || '',
      marca: recurso.marca,
      ncm: recurso.ncm,
      ean: recurso.ean,
      chave: recurso.chave,
      erros: [],
    };
  }

  async gravaSaldo(): Promise<void> {
    const recursosCollection = this.db.collection("recursos");
    const consultaSaldoRecurso = await this.consultaSaldoRecurso();
    const saldosDeRecursos = consultaSaldoRecurso.recursos;

    const batchSize = 1000;
    const promises = [];

    for (let i = 0; i < saldosDeRecursos.length; i += batchSize) {
      const batch = this.db.batch();
      const recursosSlice = saldosDeRecursos.slice(i, i + batchSize);

      for (const saldo of recursosSlice) {
        const snapshot = await recursosCollection.where('chave', '==', saldo.recurso).get();

        if (!snapshot.empty) {
          snapshot.forEach((doc) => {
            const estoqueItem = {
              quantidade: saldo.quantidade ?? 0,
              nomeEstabelecimento: saldo.estabelecimento || 'não obtido',
              estabelecimento: saldo.chaveEstabelecimento ?? 0,
              codigoEstabelecimento: saldo.codigoEstabelecimento || 'não obtido',
            };

            batch.update(doc.ref, { estoque: FieldValue.arrayUnion(estoqueItem) });
          });
        } else {
          console.log(`Nenhum documento encontrado para chave do recurso: ${saldo.recurso}`);
        }
      }

      promises.push(batch.commit().then(() => {
        console.log(`Batch commit realizado para ${recursosSlice.length} recursos.`);
      }));
    }

    await Promise.all(promises);
  }

  async consultaSaldoRecurso(): Promise<{ recursos: RecursoSaldo[] }> {
    console.log(this.apiUrl + this.versao);
    const apiResponse = await axios.get(this.recursoSaldo, {
      headers: {
        Authorization: constantes.token,
      },
    });

    if (apiResponse.status !== 200) {
      throw new Error("Erro ao obter dados da API: " + apiResponse.statusText);
    }

    const responseData = apiResponse.data;
    if (!responseData.saldoRecurso) {
      throw new Error("Dados não encontrados na resposta da API.");
    }

    return { recursos: responseData.saldoRecurso };
  }

  //mesmo metodo usando transaction para melhorar a execução 
  //   async gravaSaldo2(): Promise<void> {
  //     const recursosCollection = this.db.collection("recursos");
  //     const consultaSaldoRecurso = await this.consultaSaldoRecurso();
  //     const saldosDeRecursos = consultaSaldoRecurso.recursos;

  //     const batchSize = 500;
  //     const promises = [];

  //     for (let i = 0; i < saldosDeRecursos.length; i += batchSize) {
  //       const recursosSlice = saldosDeRecursos.slice(i, i + batchSize);

  //       promises.push(
  //         this.db.runTransaction(async (transaction) => {
  //           for (const saldo of recursosSlice) {
  //             const snapshot = await recursosCollection.where('chave', '==', saldo.recurso).get();

  //             if (!snapshot.empty) {
  //               snapshot.forEach((doc) => {
  //                 const estoque = {
  //                   quantidade: saldo.quantidade ?? 0,
  //                   nomeEstabelecimento: saldo.estabelecimento || 'não obtido',
  //                   estabelecimento: saldo.chaveEstabelecimento ?? 0,
  //                   codigoEstabelecimento: saldo.codigoEstabelecimento || 'não obtido',
  //                 };
  //                 transaction.update(doc.ref, {
  //                   estoque: FieldValue.arrayUnion(estoque)
  //                 });
  //               });
  //             }
  //           }
  //         }).then(() => {
  //           console.log(`Batch commit realizado para ${recursosSlice.length} recursos.`);
  //         }).catch(error => {
  //           console.error('Erro ao realizar commit do batch:', error);
  //         })
  //       );
  //     }

  //   await Promise.all(promises).catch(error => {
  //     console.error('Erro ao processar todos os batches:', error);
  //   });
  // }

}  