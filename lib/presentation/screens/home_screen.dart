import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 2;

  final List<Map<String, dynamic>> safetyZones = [
    {
      'type': 'safe',
      'point': LatLng(28.6152, 77.2095),
      'radius': 500,
    },
    { 
      'type': 'danger',
      'point': LatLng(28.6135, 77.2150),
      'radius': 300,
    },
  ];

  List<Widget> get screens => [
        Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/northeast4.jpg',
              fit: BoxFit.cover,
            ),
            Container(color: const Color.fromARGB(255, 47, 47, 47).withOpacity(0.3)),
            Center(
              child: Text("Home Widget", style: TextStyle(color: Colors.white70, fontSize: 24)),
            ),
          ],
        ),
        FlutterMap(
          options: MapOptions(
            center: LatLng(28.6139, 77.2090),
            zoom: 13,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            CircleLayer(
              circles: safetyZones.map((zone) {
                return CircleMarker(
                  point: zone['point'],
                  color: zone['type'] == 'safe'
                      ? Colors.green.withOpacity(0.3)
                      : Colors.red.withOpacity(0.4),
                  borderStrokeWidth: 2,
                  borderColor:
                      zone['type'] == 'safe' ? Colors.green : Colors.red,
                  radius: zone['radius'] / 2,
                );
              }).toList(),
            ),
            MarkerLayer(
              markers: safetyZones.map((zone) {
                return Marker(
                  width: 40,
                  height: 40,
                  point: zone['point'],
                  child: Icon(
                    zone['type'] == 'safe'
                        ? Icons.check_circle
                        : Icons.warning,
                    color: zone['type'] == 'safe'
                        ? Colors.green
                        : Colors.red,
                    size: 32,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        Center(child: Text("SOS Widget", style: TextStyle(fontSize: 36, color: Colors.red, fontWeight: FontWeight.bold))),
        Center(child: Text("Safety Widget", style: TextStyle(fontSize: 24))),
        Center(child: Text("Account Widget", style: TextStyle(fontSize: 24))),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onTabSelected: (index) => setState(() => _selectedIndex = index),
      ),
      floatingActionButton: SizedBox(
        width: 84,
        height: 84,
        child: FloatingActionButton(
          elevation: 10,
          backgroundColor: Colors.red,
          child: Icon(Icons.sos, color: Colors.white, size: 50),
          onPressed: () => setState(() => _selectedIndex = 2),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  const CustomNavBar({super.key, required this.selectedIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black, // Change to any color you want for the nav bar
      shape: CircularNotchedRectangle(),
      notchMargin: 10.0,
      child: SizedBox(
        height: 68,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navIcon(Icons.home, "Home", 0, selectedIndex, onTabSelected),
            _navIcon(Icons.map, "Map", 1, selectedIndex, onTabSelected),
            SizedBox(width: 60),
            _navIcon(Icons.shield, "Safety", 3, selectedIndex, onTabSelected),
            _navIcon(Icons.account_circle, "Account", 4, selectedIndex, onTabSelected),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, String label, int index, int selIndex, ValueChanged<int> tapHandler) {
    final isSelected = (index == selIndex);
    return GestureDetector(
      onTap: () => tapHandler(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.blueAccent : Colors.grey, size: 30),
          SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: isSelected ? Colors.blueAccent : Colors.grey)),
        ],
      ),
    );
  }
}
