export interface Item {
    idProduto: number;
    total: number;
    desconto:number;
    unitario: number;
    desciperc:number;
    acresitem: number;
    observacao: string;
    quantidade: number;
    codigoAntigo: string;
    codigoProprio: string;
    unitarioVenda: number;
}

export interface Pagamento {
    tipo: string;
    rede: string;
    valor: string;
    bandeira:string;
    qtdParcelas: string;
    nossoNumero: string;
    idTransacao: string;
}

export interface PedidoData {
    status: any;
    nome: string;
    frete: number;
    itens: Item[];
    cliente: string;
    emissao: string;
    desconto: number;
    descperc: number;
    chcriacao: number;
    acrescimo: number;
    vendedor: string;
    msgErro?: string;
    valorTotal: string;
    emissaohora: string;
    dataEntrega: string;
    totalProdutos: string;
    pagamentos: Pagamento[];
    chaveEstabelecimento: string;
}

export const StatusPedido = {
    FINALIZADO: { finalizado: 0 },
    ERRO: { erro: 3 },
    AGUARDANDO: {emAndamento: 1}
};

export class Pedido {
    nome: string;
    cliente: string;
    chcriacao: number;
    descperc: number;
    frete: number;
    desconto: number;
    valorTotal: string;
    itens: Item[];
    emissao: string;
    pagamentos: Pagamento[];
    status: any
    totalProdutos: string;
    chaveEstabelecimento: string;
    emissaohora: string;
    vendedor: string;
    dataEntrega: string;
    acrescimo: number;

    constructor(data: PedidoData) {
        this.nome = data.nome || "";
        this.cliente = data.cliente || "";
        this.chcriacao = data.chcriacao || 0;
        this.frete = data.frete || 0;
        this.desconto = data.desconto || 0;
        this.valorTotal = data.valorTotal || "";
        this.acrescimo = data.acrescimo || 0;
        this.descperc = data.descperc || 0;
        this.itens = Array.isArray(data.itens) ? data.itens.map((item: Item) => ({
            idProduto: item.idProduto || 0 ,
            codigoAntigo: item.codigoAntigo || "" ,
            codigoProprio: item.codigoProprio || "",
            unitario: item.unitario || 0,
            quantidade: item.quantidade || 0,
            unitarioVenda: item.unitarioVenda || 0,
            total: item.total || 0,
            desciperc: item.desciperc || 0,
            desconto: item.desconto || 0,
            acresitem: item.acresitem || 0,
            observacao: item.observacao || ""
        })) : [];
        this.emissao = data.emissao || "";
        this.pagamentos = Array.isArray(data.pagamentos) ? data.pagamentos.map((pagamento: Pagamento) => ({
            qtdParcelas: pagamento.qtdParcelas || "",
            tipo: pagamento.tipo || "",
            valor: pagamento.valor || "",
            bandeira: pagamento.bandeira || "",
            rede: pagamento.rede || "",
            nossoNumero : pagamento.nossoNumero || "",
            idTransacao: pagamento.idTransacao || ""
        })) : [];
        this.status = this.status;
        this.totalProdutos = data.totalProdutos || "";
        this.chaveEstabelecimento = data.chaveEstabelecimento || "";
        this.emissaohora = data.emissaohora || "";
        this.vendedor = data.vendedor || "";
        this.dataEntrega = data.dataEntrega || "";
    }

    toJSON(): PedidoData {
        return {
            nome: this.nome,
            cliente: this.cliente,
            chcriacao: this.chcriacao,
            frete: this.frete,
            descperc: this.descperc,
            desconto: this.desconto,
            valorTotal: this.valorTotal,
            itens: this.itens,
            status: this.status,
            acrescimo: this.acrescimo,
            emissao: this.emissao,
            pagamentos: this.pagamentos,
            totalProdutos: this.totalProdutos,
            chaveEstabelecimento: this.chaveEstabelecimento,
            emissaohora: this.emissaohora,
            vendedor: this.vendedor,
            dataEntrega: this.dataEntrega,
        };
    }
}
