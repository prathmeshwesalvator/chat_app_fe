import 'package:flutter/material.dart';

Future<String?> showMailEntryDialog(BuildContext context) async {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return showDialog<String>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Enter Email"),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: "example@mail.com",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return "Enter email";
            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
              return "Enter valid email";
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              Navigator.pop(context, controller.text);
            }
          },
          child: const Text("Submit"),
        ),
      ],
    ),
  );
}
