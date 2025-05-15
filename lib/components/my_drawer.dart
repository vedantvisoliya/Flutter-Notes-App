import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/pages/notes_page.dart';
import 'package:notes_app/pages/settings_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // image
          Padding(
            padding: const EdgeInsets.only(top: 70.0, bottom: 50.0),
            child: Image.asset(
              "assets/icons/pinned-notes.png",
              width: 70,
            ),
          ),
          // notes page tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => NotesPage(),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  "Notes",
                  style: GoogleFonts.montserrat(
                    fontSize: 19,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
          ),
          // setting 
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => SettingsPage()
                  ),
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  "Settings",
                  style: GoogleFonts.montserrat(
                    fontSize: 19,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}