import '../constants/exports.dart';
import 'package:http/http.dart' as http;

class SignUpService {
  static Future getTokenfromApi() async {
    Uri url = Uri.parse('https://crm.creditexpress.uz:6262/api/account/token');
    var res = await http.get(url);
    if (res.statusCode == 200) {      
      return res.body;
    } else {
      throw Exception('Xato bor: ${res.statusCode}');
    }
  }

  static Future<dynamic> postTokentoApi(
      String userName, String passWord) async {
    Uri url = Uri.parse('https://crm.creditexpress.uz:6262/api/account/token');
    var res = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
        "charset": "utf-8"
      },
      body: json.encode({"userName": userName, "password": passWord}),
    );

    if (res.statusCode == 200) {
      Map maps = jsonDecode(res.body);
      await clientMainData.write("token", maps["token"].toString());
      await clientMainData.write("expDate", maps["dateTime"]);
      
      print(clientMainData.read("expDate"));
      
      
      return res.body;
    } else {
      throw Exception('Xato bor: ${res.statusCode}');
    }
  }
}
