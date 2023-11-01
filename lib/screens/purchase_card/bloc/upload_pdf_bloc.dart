import 'package:card_club/resources/repoitory.dart';

class UploadPdfBloc{

  final _repository=Repository();

  var _uploadPdfAPI;

  dynamic get uploadPdfModel => _uploadPdfAPI;

  uploadPdfApi(String pdfPath) async {
    dynamic uploadPdfModel=await _repository.uploadPdfAPI(pdfPath);
    _uploadPdfAPI=uploadPdfModel;
  }

  dispose(){
    _uploadPdfAPI.close();
  }

}

final uploadPdfBloc=UploadPdfBloc();