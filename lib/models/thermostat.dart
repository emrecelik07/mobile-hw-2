import 'connectable.dart';
import 'schedulable.dart';
import 'smart_device.dart';

/// A smart thermostat that heats or cools a room to a target temperature.
/// extends SmartDevice (inheritance), uses Schedulable (mixin),
/// implements Connectable (interface).
class Thermostat extends SmartDevice with Schedulable implements Connectable {
  static const int minTemperature = 16;
  static const int maxTemperature = 30;
  static const int ecoTemperature = 18;
  static const String connectionProtocol = 'Zigbee';

  int targetTemperature;
  int roomTemperature;
  bool _connected = false;

  /// Default constructor: calls the parent constructor with `super`.
  Thermostat(
    String name, {
    this.targetTemperature = 22,
    this.roomTemperature = 20,
  }) : super(name, isOn: true);

  /// Named constructor: creates a thermostat in energy-saving mode.
  Thermostat.eco(String name) : this(name, targetTemperature: ecoTemperature);

  /// Sets the target temperature within the allowed range.
  void setTemperature(int targetTemperature) {
    this.targetTemperature =
        targetTemperature.clamp(minTemperature, maxTemperature);
  }

  void increaseTemperature() => setTemperature(targetTemperature + 1);

  void decreaseTemperature() => setTemperature(targetTemperature - 1);

  bool get canIncrease => targetTemperature < maxTemperature;

  bool get canDecrease => targetTemperature > minTemperature;

  /// Active only when it is on AND heating or cooling.
  @override
  bool get isActive => super.isActive && targetTemperature != roomTemperature;

  // ----- SmartDevice (abstract methods) -----

  @override
  String get typeName => 'Thermostat';

  @override
  String getStatus() {
    if (!isOn) return 'Off';
    if (targetTemperature > roomTemperature) return 'Heating';
    if (targetTemperature < roomTemperature) return 'Cooling';
    return 'Idle';
  }

  @override
  String getPropertyInfo() => 'Temperature: $targetTemperature°C';

  @override
  void performAction() => toggle();

  @override
  String describe() =>
      '${super.describe()} (target $targetTemperature°C, room $roomTemperature°C)';

  // ----- Connectable (interface) -----

  @override
  String get protocol => connectionProtocol;

  @override
  bool get isConnected => _connected;

  @override
  void connect() {
    _connected = true;
  }

  @override
  void disconnect() {
    _connected = false;
  }
}
