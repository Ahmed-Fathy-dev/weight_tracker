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
      case "provider-already-linked":
        logger.logE("The provider has already been linked to the user.");
        return const Failure(ResponseMessage.providerNotAllowed);
      case "invalid-credential":
        logger.logE("The provider's credential is not valid.");
        return const Failure(ResponseMessage.invalidCredential);
      case "credential-already-in-use":
        logger
            .logE("The account corresponding to the credential already exists, "
                "or is already linked to a Firebase User.");
        return const Failure(ResponseMessage.alreadyInUse);
      default:
        logger.logE("$error Unknown error.");
    }
    ResponseMessage.DEFAULT.logE('Network Exeption');
    return const Failure();
  }

  final String message;
}

class ResponseMessage {
  static const String SUCCESS = 'success'; // success with data
  static const String providerNotAllowed = 'Provider not Allowed'; //
  static const String invalidCredential = 'Invalid Credential'; //
  static const String alreadyInUse = 'Already In Use'; // success with data
  static const String NOTALLOWED =
      "Anonymous auth hasn't been enabled for this project."; // success with data
  static const String DEFAULT = 'Some thing went wrong, Try again later';
}
