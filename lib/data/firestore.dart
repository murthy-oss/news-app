// ignore_for_file: depend_on_referenced_packages, camel_case_types, non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp1/models/notes_model.dart';


import 'package:uuid/uuid.dart';

 final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

class Firestore_Datasource{
 
  Future<bool>CreateUser(String  email) async {
    try {
      await _firestore 
    .collection('users')
    .doc(_auth.currentUser!.uid)
    .set({"id":_auth.currentUser!.uid,"email":email});
    return true;
    }
    catch(e){
      return true;
    }
  }
  Future<bool> AddNote(String subtitle,String title,int image) async {
  try{
    var uuid = const Uuid().v4();
  DateTime data= DateTime.now();
  await _firestore
  .collection('users')
  .doc(_auth.currentUser!.uid)
  .collection('notes').doc(uuid)
  .set({
    'id':uuid,
    'subtitle':subtitle,
    'isDon':false,
    'image':image,
    'time' :'${data.hour}:${data.minute}',
    'title':title,
  });
  return true;
  }
  catch(e){
    return true;
  }
}

List getNotes(AsyncSnapshot snapshot){
  try{
    final notesList=snapshot.data.docs.map((doc){
    
    final data=doc.data() as Map<String ,dynamic>;
    return Note(
      data['id'],
      data['subtitle'],
      data['time'],
      data['image'],
      data['title']);
  }).toList();
  return notesList;
  }
  catch(e){
    return [];
  }
}
Stream<QuerySnapshot> stream(){
  return _firestore.collection('users')
  .doc(_auth.currentUser!.uid)
  .collection('notes')
  .snapshots();
}
}