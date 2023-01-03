import 'package:flutter/material.dart';

class appexception implements Exception {
  final _message;
  final _prefix;

  appexception([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class Fetchdataexception extends appexception {
  Fetchdataexception([String? message])
      : super(message, "Error During communication");
}

class BadrequestDataexception extends appexception {
  BadrequestDataexception([String? message])
      : super(message, 'Invalid Request');
}

class UserauthorizedException extends appexception {
  UserauthorizedException([String? message])
      : super(message, 'Userauthorized Request');
}

class InavalidInputException extends appexception {
  InavalidInputException([String? message])
      : super(message, 'InavalidInput Request');
}
