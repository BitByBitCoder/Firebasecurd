import 'dart:developer';
import 'package:firebasecrud/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

FirestoreService firestoreService = FirestoreService();

final textController = TextEditingController();

class _MyHomePageState extends ConsumerState<MyHomePage> {
  void openBox({String? docId}) {
    log(docId.toString());
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      if (docId == null) {
                        firestoreService.addNote(textController.text.trim());
                      } else {
                        await firestoreService.updateNote(
                            docId, textController.text.trim());
                      }
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text('add'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: firestoreService.getNoteStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              List noteList = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: noteList.length,
                  itemBuilder: (context, index) {
                    final id = noteList[index].id;
                    final data = noteList[index];
                    return Text(data['note']);
                  });
            } else {
              return Text('no data');
            }
          }),
      floatingActionButton: FloatingActionButton(onPressed: openBox),
    );
  }
}
