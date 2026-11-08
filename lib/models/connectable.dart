/// Interface: every device that can join the home network implements it.
///
/// A class that `implements` Connectable must provide its own body for
/// every member declared here.
abstract interface class Connectable {
  /// Network protocol used by the device (e.g. Wi-Fi, Bluetooth).
  String get protocol;

  /// Whether the device is currently connected to the network.
  bool get isConnected;

  /// Connects the device to the home network.
  void connect();

  /// Disconnects the device from the home network.
  void disconnect();
}
