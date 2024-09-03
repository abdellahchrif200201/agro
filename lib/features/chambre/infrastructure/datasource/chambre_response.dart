// import 'package:devti_agro/features/chambre/application/models/chambre_model.dart';

// class ChambreResponse {
//   final List<ChambreModel> chambres;
//   final int lastPage;

//   ChambreResponse({
//     required this.chambres,
//     required this.lastPage,
//   });

//   factory ChambreResponse.fromJson(Map<String, dynamic> json) {
//     final List<dynamic> data = json['data'] as List<dynamic>;
//     final List<ChambreModel> chambres = data.map<ChambreModel>((jsonChambreModel) => ChambreModel.fromJson(jsonChambreModel)).toList();

//     final int lastPage = json['meta']['last_page'] as int;

//     return ChambreResponse(
//       chambres: chambres,
//       lastPage: lastPage,
//     );
//   }
// }
