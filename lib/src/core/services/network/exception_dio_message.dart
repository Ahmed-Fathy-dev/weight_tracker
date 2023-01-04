// ignore_for_file: constant_identifier_names

import 'package:weight_tracker/src/core/utils/logger_util.dart';

class Failure implements Exception {
  const Failure([
    this.message = ResponseMessage.DEFAULT,
  ]);
  factory Failure.fromCode(dynamic error) {
    // '$error'.logV();
    switch (error) {
      case "operation-not-allowed":
        logger.logE("Anonymous auth hasn't been enabled for this project.");
        return const Failure(ResponseMessage.NOTALLOWED);
      default:
        logger.logE("Unknown error.");
    }
    ResponseMessage.DEFAULT.logE('Network Exeption');
    return const Failure();
  }

  final String message;
}

class ResponseMessage {
  static const String SUCCESS = 'success'; // success with data
  static const String NOTALLOWED =
      "Anonymous auth hasn't been enabled for this project."; // success with data
  static const String DEFAULT = 'Some thing went wrong, Try again later';
}
