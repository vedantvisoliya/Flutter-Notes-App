import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/database/data.dart';

class MyNoteTile extends StatelessWidget {
  final int index;
  final String txt;
  final void Function(int index) removeNote;
  final void Function(NoteDataBase db, int index, String text) editNote; 
  final NoteDataBase db;
  const MyNoteTile({
    super.key,
    required this.index,
    required this.txt, 
    required this.removeNote,
    required this.db,
    required this.editNote,
  });


  void editAlertBox(BuildContext context, TextEditingController textEditingController, final border, NoteDataBase db){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(backgroundColor: Theme.of(context).colorScheme.secondary,
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
                  hintText: "Edit Note",
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
                    editNote(db, index, textEditingController.text) ;
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Save",
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
      )
    );
  }


  @override
  Widget build(BuildContext context) {

    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = db.notes[index];

    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: Colors.black
      )
    );

    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              txt,
              style: GoogleFonts.montserrat(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.w600
              ),
              maxLines: 2,
            ),
          ),
          Row(
            children: [
              // edit button
              IconButton(
                onPressed: () => editAlertBox(
                  context, 
                  textEditingController, 
                  border, 
                  db,
                ), 
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              // delete button
              IconButton(
                onPressed: () => removeNote(index), 
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}