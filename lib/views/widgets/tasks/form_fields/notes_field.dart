import 'package:flutter/material.dart';

class NotesField extends StatefulWidget {
  final TextEditingController notesController;

  const NotesField({
    super.key,
    required this.notesController,
  });

  @override
  State<NotesField> createState() => _NotesFieldState();
}

class _NotesFieldState extends State<NotesField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.notesController,
      decoration: InputDecoration(
        labelText: 'ملاحظات (اختياري)',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      maxLines: 3,
    );
  }
@override
  void dispose() {
    // TODO: implement dispose
  widget.notesController.dispose;
  widget.notesController.clear();
    super.dispose();
  }

}
