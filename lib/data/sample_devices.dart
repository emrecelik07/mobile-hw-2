import '../models/connectable.dart';
import '../models/smart_device.dart';
import '../models/smart_light.dart';
import '../models/smart_speaker.dart';
import '../models/thermostat.dart';

/// Creates the device objects shown in the app.
/// Both default and named constructors are used.
List<SmartDevice> createSampleDevices() {
  // SmartLight: named constructor + default constructor
  final livingRoomLight = SmartLight.off('Living Room');
  final kitchenLight = SmartLight('Kitchen', brightness: 50);
  kitchenLight.schedule('23:00', 'Turn off'); // Schedulable mixin

  // Thermostat: default constructor
  final bedroomThermostat = Thermostat('Bedroom', targetTemperature: 24);
  bedroomThermostat.schedule('07:00', 'Warm up'); // Schedulable mixin

  // SmartSpeaker: named constructor + default constructor
  final kitchenSpeaker = SmartSpeaker.playing('Kitchen', volume: 40);
  final officeSpeaker = SmartSpeaker('Office', volume: 25);

  final devices = <SmartDevice>[
    livingRoomLight,
    kitchenLight,
    bedroomThermostat,
    kitchenSpeaker,
    officeSpeaker,
  ];

  // Connect every device that implements the Connectable interface.
  for (final device in devices) {
    if (device is Connectable) {
      (device as Connectable).connect();
    }
  }

  return devices;
}
