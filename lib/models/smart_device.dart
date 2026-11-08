/// Abstract base class for every smart home device.
///
/// It cannot be instantiated directly; the concrete devices
/// (SmartLight, Thermostat, SmartSpeaker) extend it.
abstract class SmartDevice {
  /// Static variable shared by all devices: the number of created devices.
  /// It is increased every time any device object is constructed.
  static int totalDevices = 0;

  final int id;
  final String name;
  bool isOn;

  /// Default (generative) constructor.
  /// `this.name` and `this.isOn` initialize the fields directly.
  SmartDevice(this.name, {this.isOn = false}) : id = ++totalDevices;

  // ---------- Abstract members (must be implemented by subclasses) ----------

  /// Device type shown in the UI, e.g. "Smart Light".
  String get typeName;

  /// Current status text, e.g. "ON", "Heating", "Playing".
  String getStatus();

  /// Device-specific property, e.g. "Brightness: 75%".
  String getPropertyInfo();

  /// The main action of the device (toggle, play/pause, ...).
  void performAction();

  // ---------- Concrete members (shared by all subclasses) ----------

  /// Title of the device card, e.g. "Smart Light: Living Room".
  String get title => '$typeName: $name';

  /// Whether the device is actively working (used for the status dot).
  bool get isActive => isOn;

  void turnOn() {
    isOn = true;
  }

  void turnOff() {
    isOn = false;
  }

  void toggle() => isOn ? turnOff() : turnOn();

  /// Short description of the device.
  String describe() => '#$id $title';
}
