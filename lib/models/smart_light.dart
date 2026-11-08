import 'connectable.dart';
import 'schedulable.dart';
import 'smart_device.dart';

/// A dimmable smart light.
/// extends SmartDevice (inheritance), uses Schedulable (mixin),
/// implements Connectable (interface).
class SmartLight extends SmartDevice with Schedulable implements Connectable {
  static const int defaultBrightness = 75;
  static const String connectionProtocol = 'Wi-Fi';

  int brightness;
  bool _connected = false;

  /// Default constructor: calls the parent constructor with `super`.
  SmartLight(
    String name, {
    this.brightness = defaultBrightness,
    bool isOn = true,
  }) : super(name, isOn: isOn);

  /// Named constructor: creates a light that is switched off.
  /// It redirects to the default constructor using `this`.
  SmartLight.off(String name) : this(name, brightness: 0, isOn: false);

  /// Sets the brightness (0-100). `this.brightness` refers to the field,
  /// while `brightness` refers to the parameter.
  void setBrightness(int brightness) {
    this.brightness = brightness.clamp(0, 100);
  }

  @override
  void turnOn() {
    super.turnOn();
    if (brightness == 0) {
      brightness = defaultBrightness;
    }
  }

  // ----- SmartDevice (abstract methods) -----

  @override
  String get typeName => 'Smart Light';

  @override
  String getStatus() => isOn ? 'ON' : 'OFF';

  @override
  String getPropertyInfo() => 'Brightness: ${isOn ? brightness : 0}%';

  @override
  void performAction() => toggle();

  @override
  String describe() => '${super.describe()} (${getPropertyInfo()})';

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
