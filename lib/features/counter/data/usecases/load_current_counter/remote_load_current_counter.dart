import 'dart:async';

import '../../../../../core/core.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../../models/counter_model/remote_counter_model.dart';

class RemoteLoadCurrentCounter implements LoadCurrentCounter {
  final String url; // https://beeceptor.com/console/counter
  // ignore: prefer_typing_uninitialized_variables
  final /*HttpClient*/ httpClient;

  RemoteLoadCurrentCounter({required this.url, required this.httpClient});

  @override
  Future<CounterEntity?> load() async {
    CounterEntity? counterEntity;
    try {
      final json = await httpClient.request(url: url, method: 'get');
      final RemoteCounterModel remoteDataCounter =
          RemoteCounterModel.fromJson(json);
      counterEntity = remoteDataCounter.toEntity();
      return counterEntity;
    } on HttpStatus4xxErrorClient catch (error) {
      late DomainError domainException;

      switch (error) {
        case HttpStatus4xxErrorClient.unauthorized_401:
        case HttpStatus4xxErrorClient.forbidden_403:
          domainException = DomainError.accessDenied;
          break;

        case HttpStatus4xxErrorClient.badRequest_400:
        case HttpStatus4xxErrorClient.paymentRequired_402:
        case HttpStatus4xxErrorClient.fileNotFound_404:
        case HttpStatus4xxErrorClient.methodNotAllowed_405:
        case HttpStatus4xxErrorClient.notAcceptable_406:
        case HttpStatus4xxErrorClient.proxyAuthenticationRequired_407:
        case HttpStatus4xxErrorClient.requestTimeout_408:
        case HttpStatus4xxErrorClient.conflict_409:
        case HttpStatus4xxErrorClient.gone_410:
        case HttpStatus4xxErrorClient.lengthRequired_411:
        case HttpStatus4xxErrorClient.preconditionFailed_412:
        case HttpStatus4xxErrorClient.requestEntityTooLarge_413:
        case HttpStatus4xxErrorClient.requestUriTooLong_414:
        case HttpStatus4xxErrorClient.unsupportedMediaType_415:
        case HttpStatus4xxErrorClient.requestedRangeNotSatisfiable_416:
        case HttpStatus4xxErrorClient.expectationFailed_417:
        case HttpStatus4xxErrorClient.imATeapot_418:
        case HttpStatus4xxErrorClient.insufficientSpaceOnResource_419:
        case HttpStatus4xxErrorClient.methodFailure_420:
        case HttpStatus4xxErrorClient.misdirectedRequest_421:
        case HttpStatus4xxErrorClient.unprocessableEntity_422:
        case HttpStatus4xxErrorClient.locked_423:
        case HttpStatus4xxErrorClient.failedDependency_424:
        case HttpStatus4xxErrorClient.upgradeRequired_426:
        case HttpStatus4xxErrorClient.preconditionRequired_428:
        case HttpStatus4xxErrorClient.tooManyRequests_429:
        case HttpStatus4xxErrorClient.requestHeaderFieldsTooLarge_431:
        case HttpStatus4xxErrorClient.connectionClosedWithoutResponse_444:
        case HttpStatus4xxErrorClient.unavailableForLegalReasons_451:
        case HttpStatus4xxErrorClient.clientClosedRequest_499:
        default:
          domainException = DomainError.unexpected;
      }
      throw domainException;
    } on HttpStatus5xxErrorServer catch (error) {
      late DomainError domainException;

      switch (error) {
        case HttpStatus5xxErrorServer.internalServerError_500:
        case HttpStatus5xxErrorServer.notImplemented_501:
        case HttpStatus5xxErrorServer.badGateway_502:
        case HttpStatus5xxErrorServer.serviceUnavailable_503:
        case HttpStatus5xxErrorServer.gatewayTimeout_504:
        case HttpStatus5xxErrorServer.httpVersionNotSupported_505:
        case HttpStatus5xxErrorServer.insufficientStorage_507:
        case HttpStatus5xxErrorServer.networkAuthenticationRequired_511:
          domainException = DomainError.errorServer;
          break;
        default:
          domainException = DomainError.unexpected;
      }
      throw domainException;
    }
  }
}
