import 'package:dart_twitter_api/twitter_api.dart';

class GlobalVariable {
  static String accessToken = "";
  static String accessTokenSecret = "";
  static String twittedUid = "";
  static TwitterApi? twitterApi;
  static bool isProfileEdit = false;
}