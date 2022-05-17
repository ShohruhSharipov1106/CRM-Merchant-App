
import 'package:http/http.dart' as http;

import '../constants/exports.dart';

class HomePageDataService {
  static Future getAllHomeDatas() async {
    Uri url = Uri.parse(
        "https://crm.creditexpress.uz:6262/api/request/GetRequests?State=Declined");
    http.Response res = await http.get(
      url,
      headers: {
        "Accept": " */*",
        "content-type": "application/json",
        'Authorization': 'Bearer ${clientMainData.read('token')}'
      },
    );
    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception("Xato: ${res.statusCode}");
    }
  }

  static Future getStateHomeDatas(String state) async {
    Uri url = Uri.parse(
        "https://crm.creditexpress.uz:6262/api/request/GetRequests?State=$state");
    http.Response res = await http.get(
      url,
      headers: {
        "Accept": " */*",
        "content-type": "application/json",
        'Authorization': 'Bearer ${clientMainData.read('token')}'
      },
    );
    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception("Xato: ${res.statusCode}");
    }
  }
}
