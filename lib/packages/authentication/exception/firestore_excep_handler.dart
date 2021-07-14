import 'package:geeklibrary/packages/authentication/err/firestore_excep_dialog.dart';

class FirestoreExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "OK":
        status = UserOptionStatus.ok;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "ABORTED":
        status = UserOptionStatus.aborted;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "ALREADY_EXISTS":
        status = UserOptionStatus.alreadyExist;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "CANCELLED":
        status = UserOptionStatus.cancelled;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "DATA_LOSS":
        status = UserOptionStatus.dataLoss;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "DEADLINE_EXCEEDED":
        status = UserOptionStatus.deadlineExceeded;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "FAILED_PRECONDITION":
        status = UserOptionStatus.faildedPreCondition;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "INTERNAL":
        status = UserOptionStatus.internal;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "INVALID_ARGUMENT":
        status = UserOptionStatus.invalidArgument;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "NOT_FOUND":
        status = UserOptionStatus.notFound;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "OUT_OF_RANGE":
        status = UserOptionStatus.outOfRange;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "PERMISSION_DENIED":
        status = UserOptionStatus.permissionDenied;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "RESOURCE_EXHAUSTED":
        status = UserOptionStatus.resourceExhausted;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "UNAUTHENTICATED":
        status = UserOptionStatus.unauthenticated;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "UNAVAILABLE":
        status = UserOptionStatus.unavailable;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      case "UNIMPLEMENTED":
        status = UserOptionStatus.unimplemented;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
        break;
      default:
        status = UserOptionStatus.unknown;
        var msg = generateExceptionMessage(e);
        FirestoreDialog.showDialog(e.code, msg);
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static String generateExceptionMessage(exceptionCode) {
    switch (exceptionCode) {
      case UserOptionStatus.ok:
        return "The operation completed successfully.";

      case UserOptionStatus.aborted:
        return "The operation was aborted.";

      case UserOptionStatus.alreadyExist:
        return "Some document that we attempted to create already exists.";

      case UserOptionStatus.cancelled:
        return "The operation was cancelled.";

      case UserOptionStatus.dataLoss:
        return "Unrecoverable data loss or corruption.";

      case UserOptionStatus.deadlineExceeded:
        return "Deadline expired before operation could complete.";

      case UserOptionStatus.faildedPreCondition:
        return "Operation was rejected because the system is not in a state required for the operation's execution.";

      case UserOptionStatus.internal:
        return "Internal errors. Some invariants expected by underlying system has been broken. If you see one of these errors, something is very broken.";

      case UserOptionStatus.invalidArgument:
        return "Client specified an invalid argument.";

      case UserOptionStatus.notFound:
        return "Some requested document was not found.";

      case UserOptionStatus.outOfRange:
        return "Operation was attempted past the valid range.";

      case UserOptionStatus.permissionDenied:
        return "The caller does not have permission to execute the specified operation.";

      case UserOptionStatus.resourceExhausted:
        return "Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.";

      case UserOptionStatus.unauthenticated:
        return "The request does not have valid authentication credentials for the operation.";

      case UserOptionStatus.unavailable:
        return "The service is currently unavailable.";

      case UserOptionStatus.unimplemented:
        return "Operation is not implemented or not supported/enabled.";

      default:
        return "Unknown error or an error from a different error domain.";
    }
  }
}

enum UserOptionStatus {
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
