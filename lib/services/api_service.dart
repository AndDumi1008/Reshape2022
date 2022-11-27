import 'package:http/http.dart' as http;
import 'package:reshape/models/avatar_info.dart';

import '../models/details.dart';

class ApiConstants {
  static String baseUrl = "http://unihack2022-env.eba-vzvrqqcj.eu-central-1.elasticbeanstalk.com";
  static String endpointForAvatar = "/api/";
}

class ApiService {
  static var client = http.Client();

  final uriForAvatar = Uri.parse(ApiConstants.baseUrl + ApiConstants.endpointForAvatar);

  Future<List<AvatarInfo>?> fetchAvatarInfo() async {
    final response = await client.get(uriForAvatar);

    if(response.statusCode == 200) {
      final responseString = response.body;

      List<AvatarInfo> avatarInfo = avatarInfoFromJson(responseString);

      return avatarInfo;
    } else {
      return null;
    }
  }

  Future<Details?> fetchDetails(String id) async {
    final uriForDetails = Uri.parse('${ApiConstants.baseUrl}/api/$id');

    final response = await client.get(uriForDetails);

    if(response.statusCode == 200) {
      final responseString = response.body;

      Details details = detailsFromJson(responseString);

      return details;
    } else {
      return null;
    }
  }
}

