import 'package:flutter/services.dart';

/// @author: niumenglin
/// @time: 2022/3/6-12:06 上午
/// @desc:语音识别插件
class AsrManager {
  static const MethodChannel _channel = MethodChannel('asr_plugin');

  ///开始录音
  static Future<String?> start({Map? params}) async {
    return _channel.invokeMethod('start', params ?? {});
  }

  ///停止录音
  static Future<String?> stop() async {
    return _channel.invokeMethod('stop');
  }

  ///取消录音
  static Future<String?> cancel() async {
    return _channel.invokeMethod('cancel');
  }
}
