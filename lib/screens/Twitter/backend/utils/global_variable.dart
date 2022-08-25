import 'package:dart_twitter_api/twitter_api.dart';

import 'package:sn_progress_dialog/sn_progress_dialog.dart';
class GlobalVariable {
  static String accessToken = "";
  static String accessTokenSecret = "";
  static String twittedUid = "";
  static TwitterApi? twitterApi;
  static bool isProfileEdit = false;
  static ProgressDialog? progressDialog;
  static String uid = "";
}