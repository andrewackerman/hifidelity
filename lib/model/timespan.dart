class TimeSpan {
  static const TicksPerMillisecond = 10000;
  static const _MillisecondsPerTick = 1.0 / TicksPerMillisecond;

  static const TicksPerSecond = TicksPerMillisecond * 1000;
  static const _SecondsPerTick = 1.0 / TicksPerSecond;

  static const TicksPerMinute = TicksPerSecond * 60;
  static const _MinutesPerTick = 1.0 / TicksPerMinute;

  static const TicksPerHour = TicksPerMinute * 60;
  static const _HoursPerTick = 1.0 / TicksPerHour;
  
  static const TicksPerDay = TicksPerHour * 24;
  static const _DaysPerTick = 1.0 / TicksPerDay;

  static const _MillisPerSecond = 1000;
  static const _MillisPerMinute = _MillisPerSecond * 60;
  static const _MillisPerHour = _MillisPerMinute * 60;
  static const _MillisPerDay = _MillisPerHour * 24;

  static const TicksPerTenthSecond = TicksPerMillisecond * 10;

  static const TimeSpan Zero = TimeSpan(0);

  final int _ticks;

  const TimeSpan(int ticks) : 
    assert(ticks != null),
    this._ticks = ticks;

  factory TimeSpan.fromMilliseconds(double days) => TimeSpan((days * TicksPerMillisecond).toInt());
  factory TimeSpan.fromSeconds(double days) => TimeSpan((days * TicksPerSecond).toInt());
  factory TimeSpan.fromMinutes(double days) => TimeSpan((days * TicksPerMinute).toInt());
  factory TimeSpan.fromHours(double days) => TimeSpan((days * TicksPerHour).toInt());
  factory TimeSpan.fromDays(double days) => TimeSpan((days * TicksPerDay).toInt());

  factory TimeSpan.fromTime({int days = 0, int hours = 0, int minutes = 0, int seconds = 0, int milliseconds = 0}) {
    final totalMillis = (days * _MillisPerDay) + (hours * _MillisPerHour) + (minutes * _MillisPerMinute) + (seconds * _MillisPerSecond) + milliseconds;
    return TimeSpan(totalMillis * TicksPerMillisecond);
  }

  get ticks => _ticks % 10000;
  get milliseconds => (_ticks ~/ TicksPerMillisecond) % 1000;
  get seconds => (_ticks ~/ TicksPerSecond) % 60;
  get minutes => (_ticks ~/ TicksPerMinute) % 60;
  get hours => (_ticks ~/ TicksPerHour) % 24;
  get days => _ticks ~/ TicksPerDay;

  get totalTicks => _ticks;
  get totalMilliseconds => _ticks * _MillisecondsPerTick;
  get totalSeconds => _ticks * _SecondsPerTick;
  get totalMinutes => _ticks * _MinutesPerTick;
  get totalHours => _ticks * _HoursPerTick;
  get totalDays => _ticks * _DaysPerTick;

  clone() => TimeSpan(this._ticks);
  negate() => TimeSpan(-this._ticks);

  operator +(TimeSpan other) => other != null ? TimeSpan(this._ticks + other._ticks) : throw ArgumentError('Object instance set to null');
  operator -(TimeSpan other) => other != null ? TimeSpan(this._ticks - other._ticks) : throw ArgumentError('Object instance set to null');

  operator ==(dynamic other) {
    if (other == null) return false;
    if (other is TimeSpan) return this._ticks == other._ticks;
    return false;
  }
  operator <(TimeSpan other) => other == null ? false : this._ticks < other._ticks;
  operator <=(TimeSpan other) => other == null ? false : this._ticks <= other._ticks;
  operator >(TimeSpan other) => other == null ? false : this._ticks > other._ticks;
  operator >=(TimeSpan other) => other == null ? false : this._ticks >= other._ticks;

  @override
  int get hashCode => this._ticks.hashCode;

  @override
  String toString() => 'TimeSpan {days=$days, hours=$hours, minutes=$minutes, seconds=$seconds, milliseconds=$milliseconds, ticks=$ticks}';
}