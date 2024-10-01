import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  // get collection of notes
  final CollectionReference notes = 
  FirebaseFirestore.instance.collection("notes");

  // create :
  Future<void> addNotes(String title, String description){
    return notes.add({
      'title' : title,
      'description' : description,
      'time' : Timestamp.now(),

    });
  }
  // read
  Stream<QuerySnapshot> getNotes(){
    final noteStream = notes.orderBy('time', descending: true).snapshots();
    return noteStream; 
  }
  // update
  Future<void> updateNote(String docID, String newTitle, String newDescription) {
  return FirebaseFirestore.instance
      .collection('notes')
      .doc(docID) // Use the correct doc ID
      .update({
        'title': newTitle,
        'description': newDescription,
        'time': Timestamp.now(),
      });
}

  // delete
  Future<void> deleteNote(String docID){
    return notes.doc(docID).delete();

  }
}