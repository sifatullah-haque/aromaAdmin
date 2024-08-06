import 'package:flutter/foundation.dart';
import 'package:test/services/firestore.dart';

class StateManager with ChangeNotifier {
  final FirestoreService firestoreService = FirestoreService();
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> submitCode(String code) async {
    _setLoading(true);
    _setErrorMessage(null);
    try {
      await firestoreService.addCode(code);
    } catch (e) {
      _setErrorMessage('Failed to submit code: $e');
    } finally {
      _setLoading(false);
    }
  }

  //to add product
  Future<void> submitProduct(
      String name, String EAN, String classifications) async {
    _setLoading(true);
    _setErrorMessage(null);
    try {
      await firestoreService.addProducts(name, EAN, classifications);
    } catch (e) {
      _setErrorMessage('Failed to submit code: $e');
    } finally {
      _setLoading(false);
    }
  }

  //to add basic care
  Future<void> submitBasicCare(
      String hName, String nName, String rname, String total) async {
    _setLoading(true);
    _setErrorMessage(null);
    try {
      await firestoreService.addBasicCare(hName, nName, rname, total);
    } catch (e) {
      _setErrorMessage('Failed to submit code: $e');
    } finally {
      _setLoading(false);
    }
  }

  //to add complete care
  Future<void> submitCompleteCare(
      String hName, String nName, String rname, String total) async {
    _setLoading(true);
    _setErrorMessage(null);
    try {
      await firestoreService.addCompleteCare(hName, nName, rname, total);
    } catch (e) {
      _setErrorMessage('Failed to submit code: $e');
    } finally {
      _setLoading(false);
    }
  }

  //to add essential care
  Future<void> submitEssentialCare(
      String hName, String nName, String rname, String total) async {
    _setLoading(true);
    _setErrorMessage(null);
    try {
      await firestoreService.addEssentialCare(hName, nName, rname, total);
    } catch (e) {
      _setErrorMessage('Failed to submit code: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}
