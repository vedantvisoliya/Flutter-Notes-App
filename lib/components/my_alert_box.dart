import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAlertBox extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final String buttonTitle;
  final void Function(String txt)? addNote;
  const MyAlertBox({
    super.key,
    required this.title,
    required this.content,
    required this.buttonTitle,
    required this.addNote,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide(
        color: Colors.black
      )
    );

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: title,
      content: content,
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  enabledBorder: border,
                  focusedBorder: border,
                  hintText: "Add a Note",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.montserrat(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    addNote!(textEditingController.text);
                    Navigator.pop(context);
                  },
                  child: Text(
                    buttonTitle,
                    style: GoogleFonts.montserrat(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}