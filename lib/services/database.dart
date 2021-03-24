import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:healthai/services/global.dart';

import 'package:rxdart/rxdart.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;

  DocumentReference ref;
  CollectionReference colRef;

  DatabaseService({this.path}) {
    ref = _db.doc(path);
    // colRef = _db.collection(path);
  }

  DocumentReference createRef() {
    return ref;
  }
}

class SubCategory<T> {
  Future<List<T>> getSubSubData(List<DocumentReference> listRef) {
    print('INTERIEUR FUTURE');
    print(listRef);
    return Future.wait(listRef
        .map((ref) => ref.get().then((doc) {
              print('THE DATA');
              print(doc.data());
              return Global.models[T]({'id': doc.id, ...doc.data()}) as T;
            }))
        .toList());
  }
}

class Document<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;

  DocumentReference ref;

  Document({this.path}) {
    ref = _db.doc(path);
  }

  Future<T> getData() {
    return ref
        .get()
        .then((doc) => Global.models[T]({'id': doc.id, ...doc.data()}) as T);
  }

  Stream<T> streamData() {
    return ref
        .snapshots()
        .map((doc) => Global.models[T]({'id': doc.id, ...doc.data()}) as T);
  }

  Future<void> upsert(Map data) {
    return ref.set(Map<String, dynamic>.from(data), SetOptions(merge: true));
  }
}

class Collection<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  CollectionReference ref;

  Collection({this.path}) {
    ref = _db.collection(path);
  }

  Stream<List<T>> streamData() {
    return ref.snapshots().map((event) => event.docs
        .map((doc) => Global.models[T]({'id': doc.id, ...doc.data()}) as T));
  }

  Future upsert(Map data) {
    return ref.add(data);
  }

  Future deleteById(String id) {
    return ref.doc(id).delete();
  }
}

class UserData<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String collection;

  UserData({this.collection});

  Stream<T> get documentStream {
    return _auth.authStateChanges().switchMap((user) {
      if (user != null) {
        Document<T> doc = Document<T>(path: '$collection/${user.uid}');
        return doc.streamData();
      } else {
        return Stream<T>.value(null);
      }
    });
  }

  Future<T> getDocument() async {
    User user = _auth.currentUser;
    if (user != null) {
      Document doc = Document<T>(path: '$collection/${user.uid}');
      return doc.getData();
    } else {
      return null;
    }
  }

  Future upsert(Map data) async {
    User user = _auth.currentUser;
    Document<T> ref = Document(path: '$collection/${user.uid}');
    return ref.upsert(data);
  }
}
