import 'connectable.dart';
import 'smart_device.dart';

/// A smart speaker that can play or pause music.
/// extends SmartDevice (inheritance), implements Connectable (interface).
class SmartSpeaker extends SmartDevice implements Connectable {
  static const int defaultVolume = 40;
  static const String connectionProtocol = 'Bluetooth';

  int volume;
  bool _connected = false;

  /// Default constructor: calls the parent constructor with `super`.
  SmartSpeaker(
    String name, {
    this.volume = defaultVolume,
    bool isPlaying = false,
  }) : super(name, isOn: isPlaying);

  /// Named constructor: creates a speaker that is already playing.
  /// It redirects to the default constructor using `this`.
  SmartSpeaker.playing(String name, {int volume = defaultVolume})
      : this(name, volume: volume, isPlaying: true);

  bool get isPlaying => isOn;

  void play() => turnOn();

  void pause() => turnOff();

  /// Sets the volume (0-100).
  void setVolume(int volume) {
    this.volume = volume.clamp(0, 100);
  }

  // ----- SmartDevice (abstract methods) -----

  @override
  String get typeName => 'Smart Speaker';

  @override
  String getStatus() => isPlaying ? 'Playing' : 'Paused';

  @override
  String getPropertyInfo() => 'Volume: $volume%';

  @override
  void performAction() => isPlaying ? pause() : play();

  @override
  String describe() => '${super.describe()} via $protocol';

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
