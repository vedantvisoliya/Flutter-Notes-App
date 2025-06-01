import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/my_alert_box.dart';
import 'package:notes_app/components/my_drawer.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/database/data.dart';
import 'package:notes_app/components/my_note_tile.dart';
import 'package:notes_app/database/firestore.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // firestore
  final FireStoreService fireStoreService = FireStoreService();

  // final _mybox = Hive.box("myBox");
  // NoteDataBase db = NoteDataBase();

  // DB METHODS --------------------------->

  // add a note
  // void addNote(String txt) {
  //   setState(() {
  //     db.notes.add(txt);
  //     db.updateDataBase();
  //   });
  // }

  // void removeNote(int index) {
  //   setState(() {
  //     db.notes.removeAt(index);
  //     db.updateDataBase();
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   if (_mybox.get("NOTESAPP") == null) {
  //     db.createInitialData();
  //   } else {
  //     db.loadData();
  //   }
  // }
  // ---------------------------------------------------------

  void addDialogBox() {
    showDialog(
      context: context,
      builder:
          (context) => MyAlertBox(
            title: null,
            content: null,
            buttonTitle: "Add",
            addNote: fireStoreService.addNote,
          ),
    );
  }

  void editNote(NoteDataBase db, int index, String newTxt) {
    setState(() {
      db.notes[index] = newTxt;
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addDialogBox(),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10.0),

            // db.notes.isEmpty
            //     ? Center(
            //       child: Text(
            //         "No Notes Yet",
            //         style: GoogleFonts.montserrat(
            //           color: Theme.of(context).colorScheme.inversePrimary,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     )
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: fireStoreService.getNotesStream(),
                builder: (context, snapshot) {
                  // if we have data, get all the docs
                  if (snapshot.hasData) {
                    List notesList = snapshot.data!.docs;
                    // display as a list
                    if (notesList.isNotEmpty) {
                      return ListView.builder(
                        itemCount: notesList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          // final note = db.notes[index];

                          // get each individual doc
                          DocumentSnapshot document = notesList[index];
                          String docID = document.id;

                          // get note from each doc
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          String noteText = data['note'];

                          // display as a note tile
                          return MyNoteTile(
                            // index: index,
                            txt: noteText,
                            removeNote: fireStoreService.deleteNote,
                            // db: db,
                            editNote: fireStoreService.updateNote,
                            docID: docID,
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          "No Notes Yet",
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  } else {
                    return const Text("");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
