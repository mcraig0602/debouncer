import 'dart:async';

typedef CollectCB<T> = void Function(List<T> arg);
typedef RunCB<T> = void Function(T arg);

//TODO: Add leading and trailing functionality.

class Debouncer {
  final int milliseconds;
  final int maxWait;
  Timer? _timer;

  Debouncer({this.milliseconds = 300, this.maxWait = 1000});

  void Function(T) run<T>(RunCB<T> action) {
    var _atMaxTime = false;
    Timer? _localTimer;

    return (T event) {
      if (_timer == null) {
        _localTimer = Timer(Duration(milliseconds: maxWait), () => _atMaxTime = true);
      }
      if (_timer != null) {
        _timer!.cancel();
      }
      final timeout = _atMaxTime ? 0 : milliseconds;

      _timer = Timer(Duration(milliseconds: timeout), () {
        _atMaxTime = false;
        action(event);
        _timer = null;
        if (_localTimer != null) {
          _localTimer!.cancel();
          _localTimer = null;
        }
      });
    };
  }

  void Function(T) collect<T>(CollectCB<T> action) {
    var _atMaxTime = false;
    Timer? _localTimer;

    var _events = <T>[];
    return (T event) {
      if (_timer == null) {
        _localTimer = Timer(Duration(milliseconds: maxWait), () {
          _atMaxTime = true;
        });
      }
      if (_timer != null) {
        _timer!.cancel();
      }
      _events.add(event);
      final timeout = _atMaxTime ? 0 : milliseconds;

      _timer = Timer(Duration(milliseconds: timeout), () {
        _atMaxTime = false;
        action(_events);
        _events = [];
        _timer = null;
        if (_localTimer != null) {
          _localTimer!.cancel();
          _localTimer = null;
        }
      });
    };
  }
}
