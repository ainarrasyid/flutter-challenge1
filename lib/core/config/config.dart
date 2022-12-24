import 'package:flutter/foundation.dart';

class Config {
  static const baseUrl = 'https://api.nuryazid.com';
  static const apiKey = 'API_KEY';
  static const notificationChannelId = 'challenge1_channel_id';
  static const notificationChannelName = 'challenge1 notification';
  static const notificationChannelDesc = 'challenge1 notification';
  static const savedNotification = 'FCM_MESSAGE';
  static const timeout = kDebugMode ? 90 * 1000 : 10 * 1000;
}
