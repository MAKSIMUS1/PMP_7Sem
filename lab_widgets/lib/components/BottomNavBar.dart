import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

void openEmailApp(String subject) async {
  const platform = MethodChannel('com.example/geolocation');
  try {
    await platform.invokeMethod('openEmailApp', {'subject': subject});
  } on PlatformException catch (e) {
    print("Failed to open email app: '${e.message}'");
  }
}

Future<int> getBatteryLevel() async {
  const platform = MethodChannel('com.example/battery');
  try {
    final int batteryLevel = await platform.invokeMethod('getBatteryLevel');
    return batteryLevel;
  } on PlatformException catch (e) {
    print("Failed to get battery level: '${e.message}'");
    return -1;
  }
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  String _locationMessage = 'Tap location icon to get position';

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    // Если выбрана кнопка местоположения
    if (index == 1) {
      Position position = await _getCurrentPosition();
      print('Lat: ${position.latitude}, Lon: ${position.longitude}');
    } else if (index == 2) {
      openEmailApp("Your subject");
    } else if (index == 3) {
      // Получение уровня заряда батареи
      int batteryLevel = await getBatteryLevel();
      print('Battery Level: $batteryLevel%');
    }
  }

  // Метод для получения текущей геопозиции
  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Проверяем, включена ли служба местоположения
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Если служба недоступна, возвращаем ошибку
      return Future.error('Location services are disabled.');
    }

    // Проверяем разрешение на доступ к местоположению
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Возвращаем текущую геопозицию
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Основной цвет фона
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 16.0), // Отступ снизу
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home, color: _selectedIndex == 0 ? Colors.red : Colors.grey),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.location_on, color: _selectedIndex == 1 ? Colors.red : Colors.grey),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.grid_view, color: _selectedIndex == 2 ? Colors.red : Colors.grey),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person, color: _selectedIndex == 3 ? Colors.red : Colors.grey),
                      label: '',
                    ),
                  ],
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
