import 'package:flutter/services.dart';

class BatteryService {
  static const batteryChannel = MethodChannel('com.example/battery');

  // Получение текущего уровня заряда батареи
  Future<int> getBatteryLevel() async {
    try {
      final int batteryLevel = await batteryChannel.invokeMethod('getBatteryLevel');
      return batteryLevel;
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'.");
      return -1;
    }
  }

  // Подписка на изменения уровня заряда батареи
  void observeBatteryLevel() {
    batteryChannel.invokeMethod('observeBatteryLevel').then((batteryPercentage) {
      print('Battery Level: $batteryPercentage%');
    }).catchError((e) {
      print("Failed to observe battery level: ${e.message}");
    });
  }
}
