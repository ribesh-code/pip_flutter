import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
export 'src/helper.dart';
export 'src/pip_mode_widget.dart';

class PipFlutter {
  static const MethodChannel _channel =
      MethodChannel('com.example.pip_flutter');

  /// Called when the app enters PIP mode
  VoidCallback? onPipEntered;

  /// Called when the app exits PIP mode
  VoidCallback? onPipExited;

  PipFlutter({this.onPipEntered, this.onPipExited}) {
    if (onPipEntered != null || onPipExited != null) {
      _channel.setMethodCallHandler((call) async {
        if (call.method == 'onPipEntered') {
          onPipEntered?.call();
        } else if (call.method == 'onPipExited') {
          onPipExited?.call();
        }
      });
    }
  }
}
