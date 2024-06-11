export class ClienteData {
    codigo?: string;
    chave?: number;
    nome?: string;
    classe?: string;
    numero?: string;
    complemento?: string;
    bairro?: string;
    cidade?: string;
    tipologradouro?: string;
    pais?: string;
    fone?: string;  
    uf?: string;
    logradouro?: string;
    cgccpf?: string;
    cep?: string;
    email?: string;

}

export class NovoCliente {
    codigo?: string;
    nome?: string;
    chave?: number;
    classe?: string;
    numero?: string;
    complemento?: string;
    bairro?: string;
    cidade?: string;
    tipologradouro?: string;
    pais?: string;
    fone?: string;
    uf?: string;
    logradouro?: string;
    cgccpf?: string;
    cep?: string;
    email?: string;


    
    constructor(data: ClienteData) {
        this.codigo = data.codigo || '';
        this.nome = data.nome || '';
        this.classe = data.classe || '';
        this.numero = data.numero || '';
        this.complemento = data.complemento || '';
        this.bairro = data.bairro || '';
        this.cidade = data.cidade || '';
        this.tipologradouro = data.tipologradouro || '';
        this.pais = data.pais || '';
        this.fone = data.fone || '';
        this.uf = data.uf || '';
        this.logradouro = data.logradouro;
        this.cgccpf = data.cgccpf;
        this.cep = data.cep
        this. email = data.email



    }




  }