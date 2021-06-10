# Debouncer

Simple dart package to help debounce.

## Usage

### Constructor:

```dart
main() {
  final debouncer = Debouncer(milliseconds: 300, maxWait: 1000);  
}
```

### A simple _.collect()_ example:

```dart
import 'package:debouncer/debouncer.dart';

main() {
  final dir = Directory('current/directory');
  final watcher = dir.watch(events: FileSystemEvent.all);
  final debouncer = Debouncer();
  final wStream = watchPath.watch(events: FileSystemEvent.all, recursive: true);
  wStream.listen(debouncer.collect<FileSystemEvent>(handler));
}
```

### A simple _.run()_ example:

```dart
import 'package:debouncer/debouncer.dart';

main() {
  final dir = Directory('current/directory');
  final watcher = dir.watch(events: FileSystemEvent.all);
  final debouncer = Debouncer();
  final wStream = watchPath.watch(events: FileSystemEvent.all, recursive: true);
  wStream.listen(debouncer.run<FileSystemEvent>(handler));
}
```
