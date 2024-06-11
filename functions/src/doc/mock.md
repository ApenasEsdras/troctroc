# Passo a passo inicialização das cloudfunctions  

- node 
- npm install -g firebase-tools
- Java 17 + 


## como rodar
```bash
npm run serve
```

```typescript 
const pedidoDevInn: PedidoData = {
  nome: "Universidade Federal do Ceará",
  frete: 0,
  emissao: "2023-12-20 11:44:01",
  cliente: "487035",
  apelido: "pederas",
  vendedor: "Alberto Parente",
  desconto: 0,
  dataPedido: "2023-12-20 11:44:01",
  observacao: "",
  pagamentos: [
    {
      codigo: "Boleto",
      chave: 568089,
      descricao: "pederas",
      tipoParcelamento: "BO",
      tipoDeDocumento: [],
      qtdParcelas: 1,
      tipo: "BO",
      bandeira: [],
      rede: "",
      nossoNumero: null,
      idTransacao: 123,
      autorizacaoTransacao: 123456,
      valor: 10.5
    }
  ],
  emissaoHora: "11:44:01",
  dataEntrega: "2024-03-25 11:44:01",
  chaveEstabelecimento: "435526",
  itens: [
    {
      desconto: 0,
      recurso: "Dipirona 1g - Controle Especial",
      valor: 31.5,
      quantidade: 3,
      unitario: 10,
      chave: 900000000240387,
      codigo: "Dipirona 1g",
      total: 10.5
    }
  ],
  valorTotal: 31.5,
  totalProdutos: 31.5,
  chcriacao: 1703083441,
  status: 1
};


const clienteMock: ClienteData = {
  "codigo": "00.349.443/0001-92",
  "nome": "Multimoveis Industria de Moveis Ltda",
  "classe": "Varejo",
  "cgccpf": "00.349.443/0001-92",
  "pais": "BR",
  "uf": "RS",
  "cidade": "Bento Goncalves",
  "bairro": "Industrial",
  "tipologradouro": "R",
  "logradouro": "Beatriz Dall Onder",
  "cep": "95706-350",
  "numero": "266",
  "complemento": "casa",
  "fone": "(54)2102-4000"
}



const pedidoMock: PedidoData = {
  cliente: "900000001332151",
  vendedor: "Patrícia Poeta",
  valorTotal: "15946.78",
  emissao: "2024-10-06",
  emissaohora: "14:55",
  dataEntrega: "2024-11-29 14:55:00",
  totalProdutos: "15946.78",
  chaveEstabelecimento: "1120748",
  frete: 0,
  desconto: 0,
  acrescimo: 0,
  observacao: "",
  itens: [
    {
      unitario: 20.00,
      idProduto: 435551,
      quantidade: 1,
      unitarioVenda: 20.00,
      total: 20,
      desconto: 0,
      acresitem: 0,
      observacao: ""
    }
  ],
  pagamentos: [
    {
      valor: "20",
      bandeira: "",
      rede: "",
      qtdParcelas: "",
      nossoNumero: "",
      idTransacao: "",
      tipo: "DP"
    }
  ],
  nome: "",
  chcriacao: 0,
  status: undefined,
  dataPedido: ""
};



const pedidoPederasGM : PedidoData = {
  nome: "Akin",
  cliente: "211936",
  chcriacao: 1709925407,
  frete: 0,
  desconto: 0,
  valorTotal: "40",
  acrescimo: 0,
  itens: [
      {
          idProduto: 170110,
          unitario: 10,
          quantidade: 4,
          unitarioVenda: 10,
          total: 40,
          desconto: 0,
          acresitem: 0,
          observacao: "FORMA PAPEL N.06 BRANCA 10X100",
      }
  ],
  emissao: "2024-03-08 16:16:47",
  
  pagamentos: [
      {
          qtdParcelas: "1",
          tipo: "Dinheiro",
          valor: "40",
          bandeira: "",
          rede: "",
          nossoNumero: "",
          idTransacao: "123123"
      }
  ],
  status: 1,
  totalProdutos: "40",
  dataPedido: "",
  chaveEstabelecimento: "131011",
  emissaohora: "16:16:47",
  vendedor: "testeAPP",
  dataEntrega: "2024-04-07 16:16:47"
};

const clienteGM: ClienteData = {
  codigo: "00.349.443/0001-92",
  nome: "Multimoveis Industria de Moveis Ltda",
  classe: "Varejo",
  cgccpf: "00.349.443/0001-92",
  pais: "BR",
  uf: "RS",
  cidade: "Bento Goncalves",
  tipologradouro: "R",
  logradouro: "Beatriz Dall Onder",
  cep: "95706-350",
  numero: "266",
  complemento: "sem complemento",
  bairro: "sem bairro",
  fone: "(54) 2102-4000"
};

```