export interface Cliente {
  codigo: string;
  classe?: string;
  sublocalidade?: string;
  numero?: string;
  complemento?: string;
  representante?: {
    codigo: string,
    chave: number,
    nome: string
  } | null ;
  tipologradouro?: string;
  pais?: string;
  fone?: string;
  chave: string;
  nome: string;
  uf?: string;
  logradouro?: string;
  localidade?: string;
  cgccpf?: string;
  cep?: string;
  sugestaoPagamento?: {
    tipoParcelamento: string | null;
    tipoDeDocumento: string[];
    numParcelas: Record<string, unknown>;
    bandeira: string[];
    rede: string | null;
  } | null;
}
