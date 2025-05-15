import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/my_alert_box.dart';
import 'package:notes_app/components/my_drawer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/database/data.dart';
import 'package:notes_app/components/my_note_tile.dart';


class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  final _mybox = Hive.box("myBox");
  NoteDataBase db = NoteDataBase();

  // DB METHODS --------------------------->

  // add a note
  void addNote(String txt){
    setState(() {
      db.notes.add(txt);
      db.updateDataBase();
    });
  }

  void removeNote(int index){
    setState(() {
      db.notes.removeAt(index);
      db.updateDataBase();
    });
  }

  @override
  void initState() {
    super.initState();
    if(_mybox.get("NOTESAPP") == null){
      db.createInitialData();
    }
    else{
      db.loadData();
    }
  }
  // ---------------------------------------------------------

  void addDialogBox(){
    showDialog(
      context: context, 
      builder: (context) => MyAlertBox(
        title: null,
        content: null,
        buttonTitle: "Add",
        addNote: (txt) => addNote(txt),
      ),
    );
  }

  void editNote(NoteDataBase db, int index, String newTxt){
    setState(() {
      db.notes[index] = newTxt;
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
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
        padding: EdgeInsets.symmetric(horizontal: 25.0,),
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
            const SizedBox(height: 10.0,),
            db.notes.isEmpty ? Center(
                child: Text(
                  "No Notes Yet",
                  style: GoogleFonts.montserrat(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ) :
            Expanded(
              child: ListView.builder(
                itemCount: db.notes.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index){
                  final note = db.notes[index];
                  return MyNoteTile(
                    index: index, 
                    txt: note, 
                    removeNote: removeNote,
                    db: db,
                    editNote: editNote,
                  );
                }
              ),
            ) ,
          ],  
        ),
      )
    );
  }
}