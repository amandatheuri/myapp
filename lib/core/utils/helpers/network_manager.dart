import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:myapp/core/utils/loaders/TLoaders.dart';

class NetworkManager extends GetxController{
  static NetworkManager instance = Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

@override
void onInit(){
  super.onInit();
    _connectivitySubscription= _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
}
void _updateConnectionStatus(ConnectivityResult result) {
  _connectionStatus.value = result;
  if (_connectionStatus.value == ConnectivityResult.none) {
    TLoaders.warningSnackBar(title: 'Internet connection needed');
  }
}
Future<bool> isConnected() async{
    try {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  } catch (e) { 
    return false; 
  }
}
@override
  void onClose(){
    super.onClose();
    _connectivitySubscription.cancel();
  }
}