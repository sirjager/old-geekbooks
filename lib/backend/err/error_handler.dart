import 'package:geeklibrary/backend/dialog/dialog.dart';
import 'package:geeklibrary/backend/exception/exceptions.dart';

class ErrorHandler {
  void handleError(error) {
    if (error is BadRequestException) {
      var msg = error.message;
      UiDialog.showExceptionDialog(desc: msg);
    } else if (error is UnAuthorizedException) {
      var msg = error.message;
      UiDialog.showExceptionDialog(desc: msg);
    } else if (error is NotFoundException) {
      var msg = error.message;
      UiDialog.showExceptionDialog(desc: msg);
    } else if (error is TooManyRequestException) {
      var msg = error.message;
      UiDialog.showExceptionDialog(desc: msg);
    } else if (error is ServerErrorException) {
      var msg = error.message;
      UiDialog.showExceptionDialog(desc: msg);
    } else if (error is FetchDataException) {
      UiDialog.showExceptionDialog(desc: 'Oops! It took too long to respond');
    }
  }
}
