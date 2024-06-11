import axios from "axios";
import { constantes } from "../config/constantes";
import { Cliente } from "../models";
import { admin } from "../firebaseInicializer";

export class ClientesService {
  
  apiUrl = constantes.apiUrl + constantes.rotaClientes;
  versao = 0;
  gravadosQtd = 0;
  db = admin.firestore();

  async gravaClientesRecursivo(pagina: number, porpagina: number): Promise<void> {

    const { clientes, totalPaginas } = await this.consultaClientes(pagina, porpagina);
    if (clientes.length === 0) {
      return;
    }

    await this.gravaClientes(clientes);
    if (pagina < totalPaginas) {
      const proximaPagina = pagina + 1;
      await this.gravaClientesRecursivo(proximaPagina, porpagina);
    }
  }

  async gravaClientes(clientes: Cliente[]): Promise<void> {
    const clientesCollection = this.db.collection("clientes");
    const batchSize = 500;
    const batches = [];

    for (let i = 0; i < clientes.length; i += batchSize) {
      const batch = this.db.batch();

      const clientesSlice = clientes.slice(i, i + batchSize);
      for (const cliente of clientesSlice) {
        const docId = cliente.chave.toString();
        const clienteData = await this.montaClientes(cliente);
        batch.set(clientesCollection.doc(docId), clienteData);
      }

      batches.push(batch);
    }

    await Promise.all(batches.map(batch => batch.commit()));
    this.gravadosQtd += clientes.length;
  }

  async consultaClientes(pagina: number, porpagina: number): Promise<{ clientes: Cliente[], totalPaginas: number}> {
    // this.versao = await this.consultaVersao();
    // console.log(this.apiUrl + this.versao);
    const apiResponse = await axios.get(this.apiUrl + this.versao, {
      headers: {
        pagina: pagina,
        porpagina: porpagina,
        Authorization: constantes.token,
      },
    });

    const responseData = apiResponse.data;

    if (!responseData.clientes) {
      throw new Error("Dados de clientes não encontrados na resposta da API.");
    }

    if (apiResponse.status !== 200) {
      throw new Error("Erro ao obter dados da API: " + apiResponse.statusText);
    }

    // if (responseData.versao > 0) {
    //   this.gravaVersao(responseData.versao);
    // }

    if (!responseData.paginacao || !responseData.paginacao.totalPaginas) {
      throw new Error("Dados de paginação não encontrados na resposta da API.");
    }

    return {
      clientes: responseData.clientes || [],
      totalPaginas: responseData.paginacao.totalPaginas,
      // versao: responseData.versao,
    };

  }


  consultaVersao = async () => {
    const db = admin.firestore();
    try {
      let data = (await db.collection('versoes').doc("CLIENTES").get()).data()?.versao;
      return data || 0;
    } catch (e) {
      console.log(e);
    }
  }

  gravaVersao = (versao: number) => {
    const db = admin.firestore();

    db.collection('versoes')
      .doc("CLIENTES")
      .set({ versao: versao })
      .catch((error) => {
        console.error('Erro ao criar documento:', error);
      });
    this.versao = versao;
  }



    montaClientes = async (cliente: Cliente) => {
      return {
        codigo: cliente.codigo.toLocaleUpperCase(),
        representante: cliente.representante ? cliente.representante.codigo : null,
        classe: cliente.classe,
        sublocalidade: cliente.sublocalidade,
        numero: cliente.numero,
        complemento: cliente.complemento,
        tipologradouro: cliente.tipologradouro,
        pais: cliente.pais,
        fone: cliente.fone,
        chave: cliente.chave,
        nome: cliente.nome.toLocaleUpperCase(),
        uf: cliente.uf,
        logradouro: cliente.logradouro,
        localidade: cliente.localidade,
        cgccpf: cliente.cgccpf,
        cep: cliente.cep,
        sugestaoPagamento: cliente.sugestaoPagamento ? {
          tipoParcelamento: cliente.sugestaoPagamento.tipoParcelamento,
          tipoDeDocumento: cliente.sugestaoPagamento.tipoDeDocumento,
          numParcelas: cliente.sugestaoPagamento.numParcelas,
          bandeira: cliente.sugestaoPagamento.bandeira,
          rede: cliente.sugestaoPagamento.rede,
        } : null,
        erros: [],
      };
    }
  }
