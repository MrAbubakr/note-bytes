// ignore_for_file: prefer_const_constructors


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_byte/appconstant.dart';
import 'package:notes_byte/common/customtextfield.dart';
import 'package:notes_byte/services/auth/authservice.dart';
import 'package:notes_byte/services/crud.dart/firestore.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final FirestoreService firestoreService = FirestoreService();
  TextEditingController SearchController = TextEditingController();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descController = TextEditingController();
  void openNoteBox(String? docID, {String? currentTitle, String? currentDescription}){
     if (currentTitle != null && currentDescription != null) {
    titlecontroller.text = currentTitle;
    descController.text = currentDescription;
  }
    showDialog(context: context, 
    builder: (context)=> AlertDialog(
      backgroundColor: AppConstant.textbutton,
      content: Column(children:  [
        TextField( decoration: InputDecoration( hintText: "title", hintStyle: TextStyle(color: AppConstant.Background)),
        controller: titlecontroller,),
        TextField(decoration: InputDecoration( 
           hintText: "Description", hintStyle: TextStyle(color: AppConstant.Background)),
        controller: descController, 
        keyboardType: TextInputType.multiline,
        maxLines: null,
        ),
      ],),
      actions: [ElevatedButton(onPressed: (){
        // add note
        if(docID==null){
           firestoreService.addNotes(titlecontroller.text, descController.text);
        } 
        // update existing note
        else{
          firestoreService.updateNote(docID, titlecontroller.text, descController.text);
        }
        // clear feilds after pressing button
        titlecontroller.clear();  descController.clear();
        // disappear dialoge
        Navigator.pop(context);

        setState(() { });
      }, child: Text("Save", ))],
    ));
  }
  void signOut() async{
    final authservice = Provider.of<Authservice>(context, listen: false);
    authservice.signOut();
    }
  @override
 
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold( 
        
        floatingActionButton: FloatingActionButton( elevation: 30,
        focusElevation: 40,
         backgroundColor: Colors.blueAccent,
         shape: CircleBorder(),
          child:  Icon(Icons.add, color: Colors.white, size: 28, ),
          onPressed: (){
            openNoteBox(null);
          },
          ),
        backgroundColor: AppConstant.Background,
        appBar: null,
        body: 
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.all(10.0),
                  child: Text("Notes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, ),),
                ),
                IconButton(onPressed: signOut, icon: Icon(Icons.logout_outlined))
              ],
            ),
            
            CustomTextField(controller: SearchController, hintText: "Search", obscureText: false),
            SizedBox(height: 10,),
            // Container(child: ,),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestoreService.getNotes(), 
              builder: (context, snapshot){
                if(snapshot.hasData){
                  List notesList = snapshot.data!.docs;
                  // display as list
                  return ListView.builder(
                    itemCount: notesList.length,
                    itemBuilder: (context, Index){
                      // get each doc
                      DocumentSnapshot document = notesList[Index];
                      String docID = document.id;
                      //get note from each doc
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      String noteTitle = data['title'] ??  'no Data';
                      String noteDescription = data['description'] ?? '';
                      // display as list tile
                      return ListTile(
                        title: Text(noteTitle),
                        subtitle: Text(noteDescription, maxLines: 1, ),
                        trailing: Row( mainAxisSize: MainAxisSize.min,
                          children: [
                          //update
                          IconButton(onPressed: ()=>openNoteBox(
                          docID,
                          currentTitle: noteTitle,
                          currentDescription: noteDescription,
                        ), icon: Icon(Icons.edit)),
                        // delete
                        IconButton(onPressed: ()=> firestoreService.deleteNote(docID),
                        icon: Icon(Icons.delete))

                        ],)
                        );
                    });
                } else{
                  return Text("No data flound");
                }
              }  
              ),

            )
            
            
        
            ],),
     
//         ),
      ),
    ) );
  }
}