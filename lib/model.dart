import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String? id;
  final String note;
  final DateTime timestamp;

  Note({
    this.id,
    required this.note,
    required this.timestamp,
  });

  // Factory constructor to create a Note from a Firestore document
  factory Note.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc.id,
      note: data['note'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Optional: Convert to Map (useful for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
