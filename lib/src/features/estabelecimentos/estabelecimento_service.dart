// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'estabelecimento_model.dart';

/// EstabelecimentoService está sendo usado no processo de listar produtos.
/// A ideia era deixar este como sendo global, somente ele, porém não deu certo.
/// Posteriormente, cabe refatoração para utilizar apenas um, ao invés de dois
/// services para estabelecimentos.

class EstabelecimentoService {
  final List<Estabelecimento> _estabelecimentos = [];

  List<Estabelecimento> get estabelecimentos => _estabelecimentos;

  Future<void> getEstabelecimentos(BuildContext context) async {
    final collection =
        FirebaseFirestore.instance.collection('estabelecimentos');
    final querySnapshot = await collection.get();

    for (final document in querySnapshot.docs) {
      final data = document.data();
      final nomeDoEstabelecimento =
          data.containsKey('empresa') ? data['empresa'] : '';
      final chaveDoEstabelecimento =
          data.containsKey('chave') ? data['chave'] : 0;
      final codigoEstabelecimento =
          data.containsKey('codigo') ? data['codigo'] : '';

      estabelecimentos.add(
        Estabelecimento(
          nome: nomeDoEstabelecimento ?? codigoEstabelecimento ?? '',
          chave: chaveDoEstabelecimento ?? 0,
          codigo: codigoEstabelecimento ?? '',
        ),
      );
    }

    for (var estabelecimento in _estabelecimentos) {
      print(
        ' - nome do estabelecimento: ${estabelecimento.nome}',
      );

      print(
        ' - chave do estabelecimento: ${estabelecimento.chave}',
      );
    }
  }
}

class EstabelecimentoServiceHeader {
  Future<List<Estabelecimento>> getEstabelecimentos(
    BuildContext context,
  ) async {
    final collection =
        FirebaseFirestore.instance.collection('estabelecimentos');
    final querySnapshot = await collection.get();

    final List<Estabelecimento> estabelecimentos = [];

    for (final document in querySnapshot.docs) {
      final data = document.data();
      final nomeDoEstabelecimento =
          data.containsKey('empresa') ? data['empresa'] : '';
      final chaveDoEstabelecimento =
          data.containsKey('chave') ? data['chave'] : 0;
      final codigoEstabelecimento =
          data.containsKey('codigo') ? data['codigo'] : '';
      final enderecoEstabelecimento =
          data.containsKey('endereco') ? data['endereco'] : '';
      final ufEstabelecimento = data.containsKey('uf') ? data['uf'] : '';
      final cidadeEstabelecimento =
          data.containsKey('cidade') ? data['cidade'] : '';
      final emailEstabelecimento =
          data.containsKey('email') ? data['email'] : '';
      final bairroEstabelecimento =
          data.containsKey('bairro') ? data['bairro'] : '';
      final cnpjEstabelecimento = data.containsKey('cnpj') ? data['cnpj'] : '';
      final foneEstabelecimento = data.containsKey('fone') ? data['fone'] : '';
      final imgEmpresa = data.containsKey('imagem') ? data['imagem'] : '';

      estabelecimentos.add(
        Estabelecimento(
          nome: nomeDoEstabelecimento ?? codigoEstabelecimento ?? '',
          chave: chaveDoEstabelecimento,
          codigo: codigoEstabelecimento,
          endereco: enderecoEstabelecimento,
          uf: ufEstabelecimento,
          email: emailEstabelecimento,
          cidade: cidadeEstabelecimento,
          fone: foneEstabelecimento,
          cnpj: cnpjEstabelecimento,
          bairro: bairroEstabelecimento,
          imgEmpresa: imgEmpresa,
        ),
      );
    }

    // for (var estabelecimento in estabelecimentos) {
    //   print(
    //     ' - Nome do Estabelecimento: ${estabelecimento.nome}',
    //   );
    //   print(
    //     ' - Chave do Estabelecimento: ${estabelecimento.chave}',
    //   );
    // }

    return estabelecimentos;
  }
}
