import axios from 'axios';
import { admin } from './firebaseInicializer';
import { https } from 'firebase-functions/v2';
import { constantes } from './config/constantes';

import {
  FirestoreEvent,
  onDocumentCreated,
  QueryDocumentSnapshot
} from 'firebase-functions/v2/firestore';

import {
  ClientesService,
  RecursoService,
  VendedoresService,
  PagamentosService,
  EstabelecimentosService
} from "./services";

import {
  ClienteData,
  PedidoData,
  StatusPedido,
} from './models';


export const getClientes = https.onRequest(
  {
    timeoutSeconds: 3600,
    memory: '512MiB'
  },

  async (req, res) => {
    try {
      let clientesService = new ClientesService();

      await clientesService.gravaClientesRecursivo(1, 5000);

      let msg = clientesService.gravadosQtd + " clientes gravados com sucesso\nVersão: " + clientesService.versao;
      console.log(msg);
      res.send(msg);
    } catch (error) {
      console.error("Erro na requisição HTTP:", error);

      res
        .status(500)
        .send("Erro ao gravar os dados de clientes no Firestore.");
    }
  });

export const getRecursos = https.onRequest(
  {
    timeoutSeconds: 3600,
    memory: '512MiB'
  },

  async (req, res) => {
    try {
      let recursoService = new RecursoService();
      await recursoService.gravaRecursosRecursivo(1, 5000);
      let msg = `${recursoService.gravadosQtd} recursos gravados com sucesso`;
      console.log(msg);
      res.send(msg);
    } catch (error) {
      console.error("Erro na requisição HTTP:", error);
      res.status(500).send("Erro ao gravar os dados de Recursos no Firestore.");
    }
  });

export const getCondicoesDePagamento = https.onRequest(
  async (req, resp) => {
    try {
      let pagamentosService = new PagamentosService();

      await pagamentosService.gravaPagamentos();

      let msg = pagamentosService.gravadosQtd + " condições de pagamento gravados com sucesso\n ";
      console.log(msg);
      resp.send(msg);
    } catch (error) {
      console.error("Erro na requisição HTTP:", error);

      resp
        .status(500)
        .send("Erro ao gravar os dados de pagamentos no Firestore.");
    }
  }
);

export const getEstabelecimentos = https.onRequest(
  async (req, resp) => {
    try {
      let estabelecimentoService = new EstabelecimentosService();

      await estabelecimentoService.gravaEstabelecimentos();

      let msg = estabelecimentoService.gravadosQtd + " estabelecimentos gravados com sucesso\n ";
      console.log(msg);
      resp.send(msg);
    } catch (error) {
      console.error("Erro na requisição HTTP:", error);
      resp
        .status(500)
        .send("Erro ao gravar os dados de estabelecimentos no Firestore.");
    }
  }
);

export const getSaldoRecurso = https.onRequest(
  {
    timeoutSeconds: 3600,
    memory: '512MiB'
  },

  async (req, resp) => {
    try {
      let recursoService = new RecursoService();

      await recursoService.gravaSaldo();

      let msg = " saldo de recurso atualizado  com sucesso";
      console.log(msg);
      resp.send(msg);
    } catch (error) {
      console.error("Erro na requisição HTTP:", error);

      resp
        .status(500)
        .send("Erro ao atualizar os dados de Recursos no Firestore.");
    }
  }
);

export const getVendedores = https.onRequest(
  async (req, resp) => {
    try {
      let vendedores = new VendedoresService
      await vendedores.gravarVendedores();
      resp.send("Dados de vendedores gravados com sucesso");
    } catch (error) {
      console.error("Erro ao gravar vendedores:", error);
      resp.status(500).send("Erro ao gravar vendedores.");
    }
  }
);

export const cadastrarCliente = https.onRequest(async (req, res) => {
  try {
    const clienteData = req.body as ClienteData;

    const erpResponse = await axios.post(constantes.apiUrl + constantes.rotaCadastrarClientes, clienteData, {
      headers: {
        Authorization: constantes.token,
      },
    });

    const erpData = erpResponse.data;

    if (erpData.versao >= 0 && erpData.clientes && erpData.clientes.length > 0 && erpData.clientes[0].chave) {

      const chave = erpData.clientes[0].chave.toString();

      await admin.firestore().collection('/clientes').doc(chave).set(clienteData);
    }
    res.status(200).send('Cliente cadastrado com sucesso');
  } catch (error) {
    console.error('Erro ao cadastrar cliente:', error);
    res.status(500).send('Erro ao cadastrar cliente');
  }
});

export const notificaPedidoDeVenda = onDocumentCreated(
  '/pedidos/{pedidoId}',
  async (event: FirestoreEvent<QueryDocumentSnapshot | undefined, { pedidoId: string }>) => {
    const pedidoData = event.data?.data() as PedidoData || undefined;
    const pedidoId = event.params.pedidoId;
    try {
      const erpData = await axios.post(constantes.apiUrl + constantes.rotaPedidos, pedidoData, {
        headers: {
          Authorization: constantes.token,
        },
      });

      const dados = erpData.data;

      if (dados.name === 'Success') {
        pedidoData.status = StatusPedido.FINALIZADO;
        pedidoData.chcriacao = dados.id;
      } else {
        pedidoData.status = StatusPedido.ERRO;
        pedidoData.msgErro = dados.message || 'Erro desconhecido';
      }
    } catch (error: any) {
      if (error.code === 'ECONNABORTED') {
        pedidoData.status = StatusPedido.ERRO;
        pedidoData.msgErro = 'Erro de timeout na API';
      } else if (error.response && error.response.data && error.response.data.message) {
        pedidoData.status = StatusPedido.ERRO;
        pedidoData.msgErro = error.response.data.message || 'Erro desconhecido';
      } else {
        pedidoData.status = StatusPedido.ERRO;
        pedidoData.msgErro = 'Erro desconhecido';
      }
    } finally {
      await admin.firestore().collection('/pedidos').doc(pedidoId).set(pedidoData);
    }
  },
);