import axios from "axios";
import { constantes } from "../config/constantes";
import { admin, auth, firestore } from "../firebaseInicializer";
import { Vendedores } from '../models/type-vendedores';

export class VendedoresService {
  db = admin.firestore();

  autenticarOuCriarUsuario = async (email: string, senha: string) => {
    let authVendedor;

    try {
      authVendedor = await auth.getUserByEmail(email);
      if (authVendedor.disabled) {
        await auth.updateUser(authVendedor.uid, { disabled: false });
      }
    } catch (erro) {
      console.log("Erro ao buscar usuário por email: ", erro);
    }

    if (!authVendedor) {
      authVendedor = await auth.createUser({
        email,
        password: senha,
      });
    } else {
      await auth.updateUser(authVendedor.uid, {
        email,
        password: senha,
      });
    }

    if (!authVendedor) {
      throw new Error("Falha ao autenticar ou criar usuário.");
    }

    return authVendedor.uid;
  }

  montaVendendor = async (vendedor: Vendedores, uid: string) => {
    const db = firestore;
    const vendedoresCollection = db.collection("vendedores");

    const docId = uid;
    const data = {
      uf: vendedor.uf,
      fone: vendedor.fone,
      pais: vendedor.pais,
      nome: vendedor.nome,
      chave: vendedor.chave,
      codigo: vendedor.codigo,
      classe: vendedor.classe,
      email: vendedor.email,
      nomeUsuario: vendedor.nomeUsuario,
      estabelecimentos: vendedor.estabelecimentos,
      uid,
    };

    await vendedoresCollection.doc(docId).set(data);
  }

  apagaColecaoVendedores = async () => {
    const vendedoresCollection = this.db.collection("vendedores");
    const snapshot = await vendedoresCollection.get();
    const batch = this.db.batch();

    snapshot.docs.forEach((doc) => {
      batch.delete(doc.ref);
    });

    await batch.commit();
    console.log("Coleção de vendedores apagada com sucesso.");
  };

  gravarVendedores = async () => {
    try {
      // Obter a quantidade de vendedores permitidos
      const numeroDeVendedores = await this.getNumeroDeVendedoresPermitidos();

      if (numeroDeVendedores === undefined) {
        throw new Error('Quantidade de vendedores permitida não encontrada.');
      }

      // Apagar a coleção de vendedores antes de gravar os novos dados
      await this.apagaColecaoVendedores();

      const apiResponse = await axios.get(constantes.apiUrl + constantes.rotaVendedores, {
        headers: {
          Authorization: constantes.token,
        },
      });
      const responseData = apiResponse.data;

      if (!responseData.vendedores) {
        throw new Error("Dados de vendedores não encontrados na resposta da API.");
      }

      const vendedores: Vendedores[] = responseData.vendedores || [];

      // Limitar o número de vendedores à quantidade permitida
      const vendedoresLimitados = vendedores.slice(0, numeroDeVendedores);

      for (const vendedor of vendedoresLimitados) {
        console.log("Sincronizando vendedor:", vendedor);
        try {
          if (vendedor.email && vendedor.senha) {
            const uid = await this.autenticarOuCriarUsuario(vendedor.email, vendedor.senha);
            await this.montaVendendor(vendedor, uid);
          }
        } catch (error: any) {
          console.error("Erro ao sincronizar vendedor:", error);
          vendedor.msgError = (error instanceof Error) ? error.message : "Erro desconhecido ao sincronizar vendedor.";
        }
      }

      // Desativar ou apagar vendedores não presentes na lista da API
      await this.verificarVendedoresNaoSincronizados(vendedoresLimitados);

      console.log("Vendedores sincronizados com sucesso.");
    } catch (error) {
      console.error("Erro ao sincronizar vendedores:", (error instanceof Error) ? error.message : error);
      throw new Error("Erro ao sincronizar vendedores.");
    }
  }

  verificarVendedoresNaoSincronizados = async (vendedoresApi: Vendedores[]) => {
    try {
      // Obter a lista de usuários autenticados
      const listUsersResult = await auth.listUsers();
      const vendedoresApiEmails = vendedoresApi.map(v => v.email);

      for (const user of listUsersResult.users) {
        if (!vendedoresApiEmails.includes(user.email)) {
          console.log(`Usuário desativado: ${user.email}`);
          await auth.updateUser(user.uid, { disabled: true });
        }
      }

      console.log("Vendedores não presentes na API foram desativados.");
    } catch (error) {
      console.error("Erro ao verificar vendedores não sincronizados:", (error instanceof Error) ? error.message : error);
      throw new Error("Erro ao verificar vendedores não sincronizados.");
    }
  }

  getNumeroDeVendedoresPermitidos = async () => {
    try {
      const docRef = admin.firestore().collection('licenciamento').doc('licenciamentoconfig');
      const doc = await docRef.get();
      const access = doc.data()?.access;

      if (!access || access.numeroDeVendedores === undefined) {
        console.log('Campo numeroDeVendedores não encontrado no mapa access.');
        return undefined;
      }

      const numeroDeVendedores = access.numeroDeVendedores;

      console.log(`Campo numeroDeVendedores: ${numeroDeVendedores}`);

      return numeroDeVendedores;
    } catch (error) {
      console.error('Erro ao acessar o Firestore:', (error instanceof Error) ? error.message : error);
      throw new Error('Erro ao acessar o Firestore.');
    }
  }
}

export default VendedoresService;
