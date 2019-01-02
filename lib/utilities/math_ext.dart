import 'dart:math' as BaseMath;

export 'dart:math';

double lerp(num a, num b, double delta) => a * (1 - delta) + b * delta;