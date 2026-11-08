import 'package:flutter/material.dart';

import '../models/connectable.dart';
import '../models/schedulable.dart';
import '../models/smart_device.dart';
import '../models/smart_light.dart';
import '../models/smart_speaker.dart';
import '../models/thermostat.dart';

/// A card that shows a single [SmartDevice] and its control.
class DeviceCard extends StatelessWidget {
  const DeviceCard({super.key, required this.device, required this.onChanged});

  final SmartDevice device;

  /// Called after the device state changes so the parent can rebuild.
  final VoidCallback onChanged;

  void _run(VoidCallback action) {
    action();
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = _accentColor();

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Tooltip(
              message: device.describe(),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(_icon(), color: color),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device.title,
                    style: textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(device.getPropertyInfo(), style: textTheme.bodySmall),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: device.isActive ? Colors.green : Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Status: ${device.getStatus()}',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _extraInfo(),
                    style: textTheme.labelSmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            _buildControl(),
          ],
        ),
      ),
    );
  }

  /// Device-specific control (switch, +/- buttons, play/pause).
  Widget _buildControl() {
    return switch (device) {
      SmartLight light => Switch(
          value: light.isOn,
          onChanged: (_) => _run(light.performAction),
        ),
      Thermostat thermostat => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton.outlined(
              tooltip: 'Decrease temperature',
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.remove),
              onPressed: thermostat.canDecrease
                  ? () => _run(thermostat.decreaseTemperature)
                  : null,
            ),
            IconButton.outlined(
              tooltip: 'Increase temperature',
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.add),
              onPressed: thermostat.canIncrease
                  ? () => _run(thermostat.increaseTemperature)
                  : null,
            ),
          ],
        ),
      SmartSpeaker speaker => IconButton.filled(
          tooltip: speaker.isPlaying ? 'Pause' : 'Play',
          icon: Icon(speaker.isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () => _run(speaker.performAction),
        ),
      _ => const SizedBox.shrink(),
    };
  }

  /// Connection info (Connectable interface) and schedule (Schedulable mixin).
  String _extraInfo() {
    final parts = <String>[];
    final current = device;
    if (current is Connectable) {
      final connectable = current as Connectable;
      parts.add(
        '${connectable.protocol} • '
        '${connectable.isConnected ? 'Connected' : 'Disconnected'}',
      );
    }
    if (current is Schedulable && current.hasSchedule) {
      parts.add(current.scheduleInfo);
    }
    return parts.join(' • ');
  }

  IconData _icon() {
    return switch (device) {
      SmartLight() => Icons.lightbulb,
      Thermostat() => Icons.thermostat,
      SmartSpeaker() => Icons.speaker,
      _ => Icons.devices_other,
    };
  }

  Color _accentColor() {
    if (!device.isOn) return Colors.grey;
    return switch (device) {
      SmartLight() => Colors.amber.shade700,
      Thermostat() => Colors.deepOrange,
      SmartSpeaker() => Colors.blue.shade700,
      _ => Colors.grey,
    };
  }
}
