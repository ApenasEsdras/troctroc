export interface Vendedores {
  codigo?: string;
  classe?: string;
  chave?: number;
  nome: string;
  uf?: string;
  pais?: string;
  fone?: string;
  email?: string;
  senha?: string;
  uid:string;
  nomeUsuario?: string;
  estabelecimentos?: {
    chave: number;
    nome: string;
    codigo:string;
  }[];
  msgError: string;
}
