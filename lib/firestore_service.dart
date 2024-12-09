import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasecrud/model.dart';

class FirestoreService {
  final notes = FirebaseFirestore.instance.collection('notes');

  Future<bool> addNote(String note) async {
    try {
      notes.add({"note": "firest note", "timestamp": Timestamp.now()});
      return true;
    } catch (e) {
      // Handle any other unexpected errors
      log('Unexpected Error: $e');
      return false;
    }
  }

  // Future<List<Note>> getNotes() async {

  // }

  Stream<QuerySnapshot> getNoteStream() {
    final noteStream = notes.orderBy('timestamp', descending: true).snapshots();

    return noteStream;
  }

  Future<void> updateNote(String docID, String newNote) {
    return notes
        .doc(docID)
        .update({'note': newNote, 'timestamp': Timestamp.now()});
  }

  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}
