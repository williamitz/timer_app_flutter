import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimerProvider with ChangeNotifier {

  Duration duration = const Duration( seconds: 75 );
  bool isRunning = false;

  int _minutes = 1;
  int _seconds = 15;

  String get minutes => _minutes.toString().padLeft(2,'0');
  String get seconds => _seconds.toString().padLeft(2,'0');

  String get currentTime {
    return '${ _minutes.toString().padLeft(2,'0') }:${ _seconds.toString().padLeft(2,'0') }';
  }

  bool get locked => _minutes == 0 && _seconds == 0 ? true : false;

  // subscription

  StreamSubscription<int>? _timerSubscription;

  void startStopTime() {

    if( !isRunning ){
      _startTimer( duration.inSeconds );
    } else {
      _stopTimer();
    }

    isRunning = !isRunning;

    notifyListeners();

  }

  void _startTimer( int seconds ) {

    _timerSubscription?.cancel();

    const periodicDuration = Duration( seconds: 1 );

    _timerSubscription = Stream<int>.periodic( periodicDuration, (val) => seconds - val - 1 )
    .take( seconds )
    .listen( (timeLefthInSeconds) {
      duration = Duration( seconds: timeLefthInSeconds );

      final newMinutes = duration.inMinutes;
      final newSeconds = duration.inSeconds;

      _minutes = newMinutes;
      _seconds = newMinutes > 0 ? newSeconds - ( 60 * newMinutes ) : newSeconds;

      if( _minutes == 0 && _seconds == 0 ){
        _timerSubscription?.pause();
        isRunning = false;
      }

      notifyListeners();
      
    });

  }

  void _stopTimer() {
    _timerSubscription?.pause();
  }

  void onReset() {
    duration = const Duration( seconds: 75 );

    _minutes = 1;
    _seconds = 15;

    notifyListeners();
  }

  
}