
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../repository/repository.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String projectName = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProjectName();
  }

  Future<void> fetchProjectName() async {
    try {
      final String name = await getProjectName();
      setState(() {
        projectName = name;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        projectName = 'Erro ao obter o nome do projeto';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Text('Você está logado no projeto $projectName'),
      ),
    );
  }
}
