import 'package:flutter/material.dart';
import '../config/emergency_config.dart';

class TravelCardFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Column(
        children: travelTips.map((tip) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6),
            child: Card(
              color: const Color.fromARGB(255, 99, 100, 100).withOpacity(0.7),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: ListTile(
                leading: Icon(Icons.info, color: Colors.white),
                title: Text('Travel Tip', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text(tip, style: TextStyle(color: Colors.white70, fontSize: 12)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
