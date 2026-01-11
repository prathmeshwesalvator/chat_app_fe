import 'package:retrofit/dio.dart';

class RequestAnnotations {
  static const String requestType = 'requestType';
  static const String typeA = 'TYPE_A'; // Auth + JSON
  static const String typeB = 'TYPE_B'; // Auth + Multipart
  static const String typeC = 'TYPE_C'; // JSON only
  static const String typeD = 'TYPE_D'; // Multipart only
  static const String typeE = 'TYPE_E'; // Token only

  static const requestTypeA = Extra(<String, Object>{requestType: typeA});

  static const requestTypeB = Extra(<String, Object>{requestType: typeB});

  static const requestTypeC = Extra(<String, Object>{requestType: typeC});

  static const requestTypeD = Extra(<String, Object>{requestType: typeD});

  static const requestTypeE = Extra(<String, Object>{requestType: typeE});
}
