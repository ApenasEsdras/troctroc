import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getProjectName() async {
  // Supondo que o nome do projeto está armazenado em um documento no Firestore
  // com o caminho 'projects/currentProject'
  final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      .collection('projects')
      .doc('currentProject')
      .get();

  if (documentSnapshot.exists) {
    return documentSnapshot['projectName']; // substitua 'projectName' pelo campo correto
  } else {
    throw Exception('Projeto não encontrado');
  }
}
