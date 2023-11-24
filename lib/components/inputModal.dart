import 'package:flutter/material.dart';

Future<void> showInputModal(
    BuildContext context, String title, Function(String) onSave) async {
  final TextEditingController controller = TextEditingController();

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextFormField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Enter your $title'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              onSave(controller.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
