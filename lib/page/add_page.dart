import 'package:flutter/material.dart';

import '../components/add_form.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPage();
}

class _AddPage extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une nouvelle tâche'),
      ),
      body: const NewItemForm(),
    );
  }
}
