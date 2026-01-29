import 'package:chat_app_fe/app/global/error/failure.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/data/model/qr_model.dart';
import 'package:chat_app_fe/app/view/features/Qr%20Analysis/data/service/qr_analysis_service.dart';

abstract class QrDatasource {
  Future<QrModel> generateHash();
}

class QrDatasourceImpl implements QrDatasource {
  final QrAnalysisService qrAnalysisService;

  QrDatasourceImpl({required this.qrAnalysisService});

  @override
  Future<QrModel> generateHash() async {
    try {
      final response = await qrAnalysisService.generateHash();

      return response;
    } catch (e) {
      throw Exception(Failure(errorMessage: e.toString()));
    }
  }
}
