import 'package:flutter/material.dart';

class EditRecordPage extends StatelessWidget {
  final int recordId;

  const EditRecordPage({Key? key, required this.recordId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empresa: $recordId'),
      ),
      body: Center(
        child: Text('$recordId'),
      ),
    );
  }
}