import 'smart_device.dart';

/// Mixin: adds scheduling ability to a [SmartDevice].
///
/// `on SmartDevice` restricts the mixin so that it can only be used by
/// smart devices (e.g. SmartLight and Thermostat).
mixin Schedulable on SmartDevice {
  String? _scheduledTime;
  String _scheduledAction = '';

  /// Schedules an [action] to run at the given [time] (HH:mm).
  void schedule(String time, String action) {
    _scheduledTime = time;
    _scheduledAction = action;
  }

  /// Removes the current schedule.
  void cancelSchedule() {
    _scheduledTime = null;
    _scheduledAction = '';
  }

  bool get hasSchedule => _scheduledTime != null;

  String get scheduleInfo =>
      hasSchedule ? '$_scheduledAction at $_scheduledTime' : 'No schedule';
}
