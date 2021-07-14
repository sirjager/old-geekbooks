import 'package:geeklibrary/packages/authentication/err/firestore_excep_dialog.dart';

class FirestoreExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "OK":
        status = FirestoreExceptionsStatus.ok;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return true;
      case "ABORTED":
        status = FirestoreExceptionsStatus.aborted;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "ALREADY_EXISTS":
        status = FirestoreExceptionsStatus.alreadyExist;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "CANCELLED":
        status = FirestoreExceptionsStatus.cancelled;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "DATA_LOSS":
        status = FirestoreExceptionsStatus.dataLoss;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "DEADLINE_EXCEEDED":
        status = FirestoreExceptionsStatus.deadlineExceeded;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "FAILED_PRECONDITION":
        status = FirestoreExceptionsStatus.faildedPreCondition;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "INTERNAL":
        status = FirestoreExceptionsStatus.internal;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "INVALID_ARGUMENT":
        status = FirestoreExceptionsStatus.invalidArgument;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "NOT_FOUND":
        status = FirestoreExceptionsStatus.notFound;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "OUT_OF_RANGE":
        status = FirestoreExceptionsStatus.outOfRange;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "PERMISSION_DENIED":
        status = FirestoreExceptionsStatus.permissionDenied;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "RESOURCE_EXHAUSTED":
        status = FirestoreExceptionsStatus.resourceExhausted;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "UNAUTHENTICATED":
        status = FirestoreExceptionsStatus.unauthenticated;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "UNAVAILABLE":
        status = FirestoreExceptionsStatus.unavailable;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      case "UNIMPLEMENTED":
        status = FirestoreExceptionsStatus.unimplemented;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
      default:
        status = FirestoreExceptionsStatus.unknown;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(status, msg);
        return false;
    }
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static String generateExceptionMessage(exceptionCode) {
    switch (exceptionCode) {
      case FirestoreExceptionsStatus.ok:
        return "The operation completed successfully.";

      case FirestoreExceptionsStatus.aborted:
        return "The operation was aborted.";

      case FirestoreExceptionsStatus.alreadyExist:
        return "Some document that we attempted to create already exists.";

      case FirestoreExceptionsStatus.cancelled:
        return "The operation was cancelled.";

      case FirestoreExceptionsStatus.dataLoss:
        return "Unrecoverable data loss or corruption.";

      case FirestoreExceptionsStatus.deadlineExceeded:
        return "Deadline expired before operation could complete.";

      case FirestoreExceptionsStatus.faildedPreCondition:
        return "Operation was rejected because the system is not in a state required for the operation's execution.";

      case FirestoreExceptionsStatus.internal:
        return "Internal errors. Some invariants expected by underlying system has been broken. If you see one of these errors, something is very broken.";

      case FirestoreExceptionsStatus.invalidArgument:
        return "Client specified an invalid argument.";

      case FirestoreExceptionsStatus.notFound:
        return "Some requested document was not found.";

      case FirestoreExceptionsStatus.outOfRange:
        return "Operation was attempted past the valid range.";

      case FirestoreExceptionsStatus.permissionDenied:
        return "The caller does not have permission to execute the specified operation.";

      case FirestoreExceptionsStatus.resourceExhausted:
        return "Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.";

      case FirestoreExceptionsStatus.unauthenticated:
        return "The request does not have valid authentication credentials for the operation.";

      case FirestoreExceptionsStatus.unavailable:
        return "The service is currently unavailable.";

      case FirestoreExceptionsStatus.unimplemented:
        return "Operation is not implemented or not supported/enabled.";

      default:
        return "Unknown error or an error from a different error domain.";
    }
  }
}

enum FirestoreExceptionsStatus {
  ok,
  aborted,
  alreadyExist,
  cancelled,
  dataLoss,
  deadlineExceeded,
  faildedPreCondition,
  internal,
  invalidArgument,
  notFound,
  outOfRange,
  permissionDenied,
  resourceExhausted,
  unauthenticated,
  unavailable,
  unimplemented,
  unknown,
}
