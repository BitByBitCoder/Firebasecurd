// import 'package:firebasecrud/firestore_service.dart';
// import 'package:firebasecrud/homepage.dart';
// import 'package:firebasecrud/model.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final controllerProvider =
//     StateNotifierProvider<FControllerNotifier, AsyncValue<List<Note>>>((ref) {
//   return FControllerNotifier();
// });

// class FControllerNotifier extends StateNotifier<AsyncValue<List<Note>>> {
//   FControllerNotifier() : super(AsyncValue.loading()) {
//     getNote();
//   }

//   FirestoreService firestoreService = FirestoreService();
//   Future getNote() async {
//     final data = await firestoreService.getNotes();

//     state = AsyncValue.data(data);
//   }

//   Future updateNote(String docID, String newNote) async {
//     final data = await firestoreService.updateNote(docID, newNote);
//     getNote();
//   }

//   Future addnoteNote(String newNote) async {
//     final data = await firestoreService.addNote(newNote);
//     getNote();
//   }
// }
