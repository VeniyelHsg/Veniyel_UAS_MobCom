import 'package:flutter/material.dart';
import 'package:todoapp/screens/note_detail.dart';
import '../database_helper.dart';
import '../note.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  late List<Note> noteList;
  int count = 0;

  @override
  void initState() {
    super.initState();
    noteList = [];
    updateListView();
  }

  Future<void> navigateToDetail(Note note, String title) async {
    final result = await Navigator.push<bool?>(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetail(note, title),
      ),
    );

    if (result != null && result) {
      updateListView();
    }
  }

  Future<bool> _onBackPressed() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Do You Really Want To Exit?"),
        actions: <Widget>[
          ElevatedButton(
            child: Text(
              "No",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            child: Text(
              "Yes",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  Future<void> updateListView() async {
    final List<Note> fetchedNoteList = await databaseHelper.getNoteList();
    setState(() {
      noteList = fetchedNoteList;
      count = fetchedNoteList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Todo App"),
          backgroundColor: Colors.deepPurple,
        ),
        body: getNoteListView(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Icon(Icons.add),
          onPressed: () {
            navigateToDetail(Note("", "", 2), "Add Note");
          },
        ),
      ),
    );
  }

  Widget getNoteListView() {
    if (count == 0) {
      return Center(
        child: Text("No Notes to Show"),
      );
    }

    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, position) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.deepPurple,
          elevation: 4.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage("https://learncodeonline.in/mascot.png"),
            ),
            title: Text(
              noteList[position].title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            subtitle: Text(
              noteList[position].date,
              style: TextStyle(color: Colors.white),
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.open_in_new,
                color: Colors.white,
              ),
              onTap: () {
                navigateToDetail(noteList[position], "Edit Todo");
              },
            ),
          ),
        );
      },
    );
  }
}
