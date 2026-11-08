import 'package:flutter/material.dart';

import '../data/sample_devices.dart';
import '../models/smart_device.dart';
import '../widgets/device_card.dart';

/// Main screen: device list + total device count at the bottom.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final List<SmartDevice> _devices;

  @override
  void initState() {
    super.initState();
    // Devices are created only once, so the static counter stays correct.
    _devices = createSampleDevices();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Smart Home Controller'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _devices.length,
        itemBuilder: (context, index) => DeviceCard(
          device: _devices[index],
          onChanged: () => setState(() {}),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          // Value comes from the static variable SmartDevice.totalDevices.
          child: Text(
            'Total Devices: ${SmartDevice.totalDevices}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
