import 'package:hive_flutter/hive_flutter.dart';

class NoteDataBase{
  List notes = [];

  // reference my box
  final _mybox = Hive.box('myBox');

  // first time running this
  void createInitialData(){
    notes = ["Luffy Gear 5"];
    updateDataBase();
  }

  // load the data from the db
  void loadData(){
    notes = _mybox.get("NOTESAPP");
  }

  // update the db
  void updateDataBase(){
    _mybox.put("NOTESAPP", notes);
  }
}