import 'dart:async';
import 'package:flutter/material.dart';

/// Debouncer utility to prevent excessive API calls
/// Used to delay execution until user stops typing or moving the map
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer(this.milliseconds);

  /// Execute the action after the debounce delay
  /// Cancels any previous pending execution
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  /// Cancel any pending execution
  void cancel() {
    _timer?.cancel();
  }

  /// Dispose of the timer
  void dispose() {
    _timer?.cancel();
  }
}
