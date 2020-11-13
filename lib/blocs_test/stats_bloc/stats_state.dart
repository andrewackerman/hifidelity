import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class StatsState extends Equatable {
  StatsState([List props = const []]) : super(props);
}

class StatsLoading extends StatsState {
  @override
  String toString() => 'StatsLoading';
}

class StatsLoaded extends StatsState {
  final int totalTokens;

  int get currentLevel {
    if (totalTokens >= 77777) return 7;
    if (totalTokens >= 40001) return 6;
    if (totalTokens >= 20001) return 5;
    if (totalTokens >= 10001) return 4;
    if (totalTokens >=  5001) return 3;
    if (totalTokens >=  2501) return 2;
    return 1;
  }

  int get tokensUntilNextLevel {
    if (totalTokens >= 77777) return -1;
    if (totalTokens >= 40001) return 77777 - (totalTokens - 40001);
    if (totalTokens >= 20001) return 40001 - (totalTokens - 20001);
    if (totalTokens >= 10001) return 20001 - (totalTokens - 10001);
    if (totalTokens >=  5001) return 10001 - (totalTokens - 5001);
    if (totalTokens >=  2501) return 5001 - (totalTokens - 2501);
    return 2501 - totalTokens;
  }

  StatsLoaded(this.totalTokens) : super([totalTokens]);

  @override
  String toString() => "StatsLoaded { totalTokens: $totalTokens }";
}
