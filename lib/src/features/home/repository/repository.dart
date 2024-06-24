
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getProjectName() async {
  try {
    final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('projects')
        .doc('currentProject')
        .get();

    if (documentSnapshot.exists) {
      final projectName = documentSnapshot.get('projectName'); 
      print('Project name retrieved: $projectName');
      return projectName;
    } else {
      throw Exception('Projeto não encontrado');
    }
  } catch (e) {
    print('Erro ao obter o nome do projeto: $e');
    rethrow;
  }
}