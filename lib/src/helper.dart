import 'package:flutter/services.dart';

class Helper {
  static const MethodChannel _channel =
      MethodChannel('com.example.pip_flutter');
  const Helper._();

  // checks if this device supports PIP.
  static Future<bool> get isPipAvaiable async {
    final bool? isAvaiable = await _channel.invokeMethod('isPipAvailable');
    return isAvaiable ?? false;
  }

  // checks if this device support auto PIP mode.
  static Future<bool> get isAutoPipAvaible async {
    final bool? isAvaiable = await _channel.invokeMethod('isAutoPipAvailable');
    return isAvaiable ?? false;
  }

  // checks if app is currently on pip mode
  static Future<bool> get isPipActivated async {
    final bool? isActivated = await _channel.invokeMethod('isPipActivated');
    return isActivated ?? false;
  }

  static Future<bool> enterPipMode({
    aspectRatio = const [16, 9],
    autoEnter = false,
    seamlessResize = false,
  }) async {
    Map params = {
      'aspectRatio': aspectRatio,
      'autoEnter': autoEnter,
      'seamlessResize': seamlessResize,
    };

    final bool? eneteredSuccessfully =
        await _channel.invokeMethod('enterPipMode', params);
    return eneteredSuccessfully ?? false;
  }

  static Future<bool> setAutoPipMode({
    aspectRatio = const [16, 9],
    seamlessResize = false,
  }) async {
    Map params = {
      'aspectRatio': aspectRatio,
      'autoEnter': true,
      'seamlessResize': seamlessResize,
    };
    final bool? setSuccessfully =
        await _channel.invokeMethod('setAutoPipMode', params);
    return setSuccessfully ?? false;
  }
}
