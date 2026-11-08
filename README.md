# Smart Home Controller (BIM493 – Assignment #2)

A Flutter app that lists smart home devices (lights, thermostat, speakers),
shows each device's property and status, and lets the user control them.

## Run

```bash
flutter pub get
flutter run
```

## Where each requirement is implemented

| Requirement | Location |
|---|---|
| Base class `SmartDevice` (abstract) | `lib/models/smart_device.dart` |
| Abstract methods `getStatus()`, `performAction()`, `getPropertyInfo()`, `typeName` | `lib/models/smart_device.dart` |
| Subclasses `SmartLight`, `Thermostat`, `SmartSpeaker` (`extends SmartDevice`) | `lib/models/smart_light.dart`, `thermostat.dart`, `smart_speaker.dart` |
| Interface `Connectable` (`implements` in all three devices) | `lib/models/connectable.dart` |
| Mixin `Schedulable` (`with` in `SmartLight` and `Thermostat`) | `lib/models/schedulable.dart` |
| Default + named constructors (`SmartLight` / `SmartLight.off`, `Thermostat` / `Thermostat.eco`, `SmartSpeaker` / `SmartSpeaker.playing`) | model files, used in `lib/data/sample_devices.dart` |
| Multiple objects (5 devices, at least one of each subclass) | `lib/data/sample_devices.dart` |
| `static` | `SmartDevice.totalDevices` counter, `static const` limits (e.g. `Thermostat.maxTemperature`) |
| `super` | `: super(name, ...)` in constructors, `super.turnOn()`, `super.describe()`, `super.isActive` |
| `this` | `this.name` field initializers, `this.brightness = brightness`, redirecting constructors `: this(...)` |
| Device cards (name, property, status, control) | `lib/widgets/device_card.dart` |
| Bottom text "Total Devices" from static variable | `lib/screens/home_screen.dart` |

## Controls

- **Smart Light** – switch turns the light on/off.
- **Thermostat** – `−` / `+` buttons change the target temperature (16–30 °C).
- **Smart Speaker** – play/pause button.
