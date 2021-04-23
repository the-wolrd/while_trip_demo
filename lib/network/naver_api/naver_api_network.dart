
import 'dart:convert';

import 'package:http/http.dart' as http;

class NaverApiNetwork{

  final _API_KEY_ID = 'ldlqyh887n';
  final _API_KEY_SECRET = 'osYoPrfGfJEcMvXZNdeQEEMLmmUzIU3IZKUDxpsx';

  Future<Map<String, dynamic>> getAddressInfoFromQuery (String query) async {
    var url = Uri.parse('https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=$query');
    var response = await http.get(url, headers:{'X-NCP-APIGW-API-KEY-ID':_API_KEY_ID, 'X-NCP-APIGW-API-KEY':_API_KEY_SECRET});

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getAddressInfoFromPosition ({double latitude, double longitude}) async {
    var url = Uri.parse('https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=$longitude,$latitude&output=json');
    var response = await http.get(url, headers:{'X-NCP-APIGW-API-KEY-ID':_API_KEY_ID, 'X-NCP-APIGW-API-KEY':_API_KEY_SECRET});

    return jsonDecode(response.body);
  }

}

NaverApiNetwork naverApiNetwork = NaverApiNetwork();