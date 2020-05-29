import 'package:flutter/services.dart';
import 'package:mileo/widgets/alert_dialog.dart';

class ExceptionAlertDialog extends CustomAlertDialog{
  ExceptionAlertDialog({String title, PlatformException exception})
    : super(
      title: title,
      content: message(exception),
      defaultActionText: 'OK'
    );

  static String message(PlatformException exception){
    if(exception.message == 'FIRFirestoreErrorDomain'){
      if(exception.code == 'Code 7'){
        return 'This operation could not be completed due to a server error';
      }
      return exception.details;
    }
    return errors[exception.code] ?? exception.message;
  }

  static Map<String, String> errors = {
    'ERROR_WEAK_PASSWORD': 'The password must be 8 characters long or more.',
    'ERROR_INVALID_CREDENTIAL': 'The email address is badly formatted.',
    'ERROR_EMAIL_ALREADY_IN_USE': 'The email address is already registered. Sign in instead?',
    'ERROR_INVALID_EMAIL': 'The email address is badly formatted.',
    'ERROR_WRONG_PASSWORD': 'The password is incorrect. Please try again.',
    'ERROR_USER_NOT_FOUND': 'The email address is not registered. Need an account?',
    'ERROR_TOO_MANY_REQUESTS': 'We have blocked all requests from this device due to unusual activity. Try again later.',
    'ERROR_OPERATION_NOT_ALLOWED': 'This sign in method is not allowed. Please contact support.',
  };
}