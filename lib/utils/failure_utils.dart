import '../core/error/failure.dart';

const String serverFailureMessage = 'Server Failure';
const String cashedFailureMessage = 'Cache Failure';

class FailureUtils {
  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cashedFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
