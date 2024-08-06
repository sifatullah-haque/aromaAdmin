import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference adminData =
      FirebaseFirestore.instance.collection("adminData");

  //create productlist collection
  final CollectionReference productList =
      FirebaseFirestore.instance.collection("productList");

  //create basic care collections
  final CollectionReference basicCareList =
      FirebaseFirestore.instance.collection("basicCareList");
  //create complete care collections
  final CollectionReference completeCareList =
      FirebaseFirestore.instance.collection("completeCareList");
  //create essential care collections
  final CollectionReference essentialCareList =
      FirebaseFirestore.instance.collection("essentialCareList");

  // Add code to adminData collection
  Future<void> addCode(String code) {
    return adminData.add({
      'name': code,
      'timestamp': Timestamp.now(),
    });
  }

  // Add product to productList collection
  Future<void> addProducts(String name, String EAN, String classifications) {
    return productList.add({
      'name': name,
      'Ean': EAN,
      'classifications': classifications,
      'timestamp': Timestamp.now(),
    });
  }

  // Add Basic Care collection
  Future<void> addBasicCare(
      String hName, String nName, String rName, String total) {
    return basicCareList.add({
      'hName': hName,
      'nName': nName,
      'rName': rName,
      'total': total,
      'timestamp': Timestamp.now(),
    });
  }

  // Add complete Care collection
  Future<void> addCompleteCare(
      String hName, String nName, String rName, String total) {
    return completeCareList.add({
      'hName': hName,
      'nName': nName,
      'rName': rName,
      'total': total,
      'timestamp': Timestamp.now(),
    });
  }

  // Add essential Care collection
  Future<void> addEssentialCare(
      String hName, String nName, String rName, String total) {
    return essentialCareList.add({
      'hName': hName,
      'nName': nName,
      'rName': rName,
      'total': total,
      'timestamp': Timestamp.now(),
    });
  }

  // Get codes stream
  Stream<QuerySnapshot> getCodes() {
    return adminData.orderBy('timestamp', descending: true).snapshots();
  }

  // Get products stream
  Stream<QuerySnapshot> getProduct() {
    return productList.orderBy('timestamp', descending: true).snapshots();
  }

  // Get basic care stream
  Stream<QuerySnapshot> getBasicCare() {
    return basicCareList.orderBy('timestamp', descending: true).snapshots();
  }

  // Get complete care stream
  Stream<QuerySnapshot> getCompleteCare() {
    return completeCareList.orderBy('timestamp', descending: true).snapshots();
  }

  // Get essential care stream
  Stream<QuerySnapshot> getEssentialCare() {
    return essentialCareList.orderBy('timestamp', descending: true).snapshots();
  }

  // Delete code by document ID
  Future<void> deleteCode(String docID) {
    return adminData.doc(docID).delete();
  }

  // Delete product by document ID
  Future<void> deleteProduct(String docID) {
    return productList.doc(docID).delete();
  }

  // Delete basicCare by document ID
  Future<void> deleteBasicCare(String docID) {
    return basicCareList.doc(docID).delete();
  }

  // Delete complete Care by document ID
  Future<void> deleteCompleteCare(String docID) {
    return completeCareList.doc(docID).delete();
  }

  // Delete essential Care by document ID
  Future<void> deleteEssentialCare(String docID) {
    return essentialCareList.doc(docID).delete();
  }
}
