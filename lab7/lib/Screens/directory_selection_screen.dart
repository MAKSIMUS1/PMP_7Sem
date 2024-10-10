import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // Не забудьте импортировать

class DirectorySelectionScreen extends StatefulWidget {
  final String? selectedDirectory;

  DirectorySelectionScreen({this.selectedDirectory});

  @override
  _DirectorySelectionScreenState createState() => _DirectorySelectionScreenState();
}

class _DirectorySelectionScreenState extends State<DirectorySelectionScreen> {
  late List<String> _directories; // Список директорий

  @override
  void initState() {
    super.initState();
    _fetchDirectories();
  }

  Future<void> _fetchDirectories() async {

    final String fileName = 'example.txt';
    final String fileContent = 'This is an example file content.';

    List<Directory> directories = [
      await getTemporaryDirectory(),
      await getApplicationSupportDirectory(),
      await getApplicationDocumentsDirectory(),
      await getTemporaryDirectory(),
      await getExternalStorageDirectory() ?? Directory(''),
    ];

    for (var dir in directories) {
      try {
        final File file = File('${dir.path}/$fileName');
        await file.writeAsString(fileContent);
        print('File saved to: ${file.path}');
      } catch (e) {
        print('Error saving file to ${dir.path}: $e');
      }
    }

    final directoriess = [
      'DIRECTORIES',
    ];

    setState(() {
      _directories = directoriess;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Directory"),
      ),
      body: ListView.builder(
        itemCount: _directories.length,
        itemBuilder: (context, index) {
          final dir = _directories[index];
          return ListTile(
            title: Text(dir),
            onTap: () {
              Navigator.pop(context, dir); // Возвращаем выбранную директорию
            },
          );
        },
      ),
    );
  }
}
