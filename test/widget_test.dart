import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:smart_home_controller/main.dart';
import 'package:smart_home_controller/models/smart_device.dart';
import 'package:smart_home_controller/widgets/device_card.dart';

void main() {
  testWidgets('Shows devices, total count and reacts to controls',
      (WidgetTester tester) async {
    SmartDevice.totalDevices = 0;
    await tester.pumpWidget(const SmartHomeApp());

    expect(find.byType(DeviceCard), findsNWidgets(5));
    expect(find.text('Total Devices: 5'), findsOneWidget);
    expect(find.text('Smart Light: Living Room'), findsOneWidget);
    expect(find.text('Thermostat: Bedroom'), findsOneWidget);
    expect(find.text('Smart Speaker: Kitchen'), findsOneWidget);

    // Light switch: Living Room light OFF -> ON
    expect(find.text('Status: OFF'), findsOneWidget);
    await tester.tap(find.byType(Switch).first);
    await tester.pump();
    expect(find.text('Status: OFF'), findsNothing);
    expect(find.text('Brightness: 75%'), findsOneWidget);

    // Thermostat: 24 -> 25
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('Temperature: 25°C'), findsOneWidget);

    // Speaker: Office speaker Paused -> Playing
    expect(find.text('Status: Paused'), findsOneWidget);
    await tester.ensureVisible(find.byIcon(Icons.play_arrow));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();
    expect(find.text('Status: Paused'), findsNothing);

    // Rebuilds must not change the static device count.
    expect(find.text('Total Devices: 5'), findsOneWidget);
  });
}
