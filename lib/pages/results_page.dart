import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resulados de busqueda"),
        centerTitle: true,
        leading: InkWell(
            child: const Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context);
            }),
      ),
    );
  }
}
