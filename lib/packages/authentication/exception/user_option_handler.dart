class FirestoreExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "OK":
        status = UserOptionStatus.ok;
        break;
      case "ABORTED":
        status = UserOptionStatus.aborted;
        break;
      case "ALREADY_EXISTS":
        status = UserOptionStatus.alreadyExist;
        break;
      case "CANCELLED":
        status = UserOptionStatus.cancelled;
        break;
      case "DATA_LOSS":
        status = UserOptionStatus.dataLoss;
        break;
      case "DEADLINE_EXCEEDED":
        status = UserOptionStatus.deadlineExceeded;
        break;
      case "FAILED_PRECONDITION":
        status = UserOptionStatus.faildedPreCondition;
        break;
      case "INTERNAL":
        status = UserOptionStatus.internal;
        break;
      case "INVALID_ARGUMENT":
        status = UserOptionStatus.invalidArgument;
        break;
      case "NOT_FOUND":
        status = UserOptionStatus.notFound;
        break;
      case "OUT_OF_RANGE":
        status = UserOptionStatus.outOfRange;
        break;
      case "PERMISSION_DENIED":
        status = UserOptionStatus.permissionDenied;
        break;
      case "RESOURCE_EXHAUSTED":
        status = UserOptionStatus.resourceExhausted;
        break;
      case "UNAUTHENTICATED":
        status = UserOptionStatus.unauthenticated;
        break;
      case "UNAVAILABLE":
        status = UserOptionStatus.unavailable;
        break;
      case "UNIMPLEMENTED":
        status = UserOptionStatus.unimplemented;
        break;
      default:
        status = UserOptionStatus.unknown;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    String msg;
    switch (exceptionCode) {
      case UserOptionStatus.ok:
        msg = "The operation completed successfully.";
        break;
      case UserOptionStatus.aborted:
        msg = "The operation was aborted.";
        break;
      case UserOptionStatus.alreadyExist:
        msg = "Some document that we attempted to create already exists.";
        break;
      case UserOptionStatus.cancelled:
        msg = "The operation was cancelled.";
        break;
      case UserOptionStatus.dataLoss:
        msg = "Unrecoverable data loss or corruption.";
        break;
      case UserOptionStatus.deadlineExceeded:
        msg = "Deadline expired before operation could complete.";
        break;
      case UserOptionStatus.faildedPreCondition:
        msg =
            "Operation was rejected because the system is not in a state required for the operation's execution.";
        break;
      case UserOptionStatus.internal:
        msg =
            "Internal errors. Some invariants expected by underlying system has been broken. If you see one of these errors, something is very broken.";
        break;
      case UserOptionStatus.invalidArgument:
        msg = "Client specified an invalid argument.";
        break;
      case UserOptionStatus.notFound:
        msg = "Some requested document was not found.";
        break;
      case UserOptionStatus.outOfRange:
        msg = "Operation was attempted past the valid range.";
        break;
      case UserOptionStatus.permissionDenied:
        msg =
            "The caller does not have permission to execute the specified operation.";
        break;
      case UserOptionStatus.resourceExhausted:
        msg =
            "Some resource has been exhausted, perhaps a per-user quota, or perhaps the entire file system is out of space.";
        break;
      case UserOptionStatus.unauthenticated:
        msg =
            "The request does not have valid authentication credentials for the operation.";
        break;
      case UserOptionStatus.unavailable:
        msg = "The service is currently unavailable.";
        break;
      case UserOptionStatus.unimplemented:
        msg = "Operation is not implemented or not supported/enabled.";
        break;
      default:
        msg = "Unknown error or an error from a different error domain.";
    }

    return msg;
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
