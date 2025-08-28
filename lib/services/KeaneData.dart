import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class KeaneData with ChangeNotifier {
  BluetoothCharacteristic? writeCharacteristic;

  void changeWriteChracteristic({required BluetoothCharacteristic characteristic}) {
    writeCharacteristic = characteristic;
    notifyListeners();
  }
}