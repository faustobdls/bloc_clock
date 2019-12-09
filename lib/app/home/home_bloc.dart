import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_clock/app/models/clock.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  final _clockController = BehaviorSubject<Clock>();

  Observable<Clock> get clockFlux => _clockController.stream;
  Sink<Clock> get clockEvent => _clockController.sink;

  DateTime date = DateTime.now();
  Timer timer;

  double angle60 = (360 / 60);
  double angle12 = (360 / 12);

  void updateTime() {
    date = DateTime.now();
    clockEvent.add(Clock(
      hour: date.hour,
      minute: date.minute,
      second: date.second,
      hourAngle: date.hour * angle12 + (date.hour / 60) * angle12,
      minuteAngle: ((date.minute * angle60)),
      secondAngle: ((date.second * angle60)),
    ));
    this.timer = Timer(Duration(seconds: 1), updateTime);
  }

  @override
  void dispose() {
    _clockController.close();
    timer.cancel();
    super.dispose();
  }
}
