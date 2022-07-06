import 'package:crm_merchant/constants/exports.dart';

class PassportConverterHelper {
  PassportData convertByLine(String text) {
    if (text.isEmpty) return PassportData();
    var lines = text.split("\n");
    var data = PassportData();

    try {
      int wordIndex = 1;
      int calcIndex(String word) {
        wordIndex = lines.indexWhere((element) => element.contains(word));
        return wordIndex != 1 ? wordIndex : 1;
      }

      data.familiyasi = lines[calcIndex("FAMIL") + 1];
      data.ismi = lines[calcIndex("ISMI") + 1];
      data.otaIsmi = lines[calcIndex("OTAS") + 1];
      data.millat = lines[calcIndex("TOMON") - 1];
      data.jinsi = lines[calcIndex("SEX") + 1];
      data.kimBergan =
          lines[calcIndex("KIM") + 1] + " " + lines[calcIndex("SHAXSIY") - 1];
      data.tugilganJoy = lines[calcIndex("IIB") - 1];
      data.amalMuddati = lines[calcIndex("AMAL") + 1];
      data.berilganSana = lines[calcIndex("PERSONAL") - 1];
      data.pinfl = lines[calcIndex("<<") + 1].substring(28, 42);
      print("""Kim Bergan: ${data.kimBergan}
      Tugilgan joy => ${data.tugilganJoy}
      Amal Muddati: ${data.amalMuddati}
      Berilgan Sana => ${data.berilganSana}
      "PINFL: ${data.pinfl}
      "Familya: ${data.familiyasi}
      "Ism: ${data.ismi}
      "Otasining Ismi: ${data.otaIsmi}
      "Millat: ${data.millat}
      "Jinsi: ${data.jinsi}""");
    } catch (error) {
      debugPrint(error.toString());
    }
    return data;
  }
}

class PassportData {
  String ismi = "";
  String familiyasi = "";
  String otaIsmi = "";
  String millat = "";
  String kimBergan = "";
  String jinsi = "";
  String tugilganJoy = "";
  String berilganSana = "";
  String amalMuddati = "";
  String pinfl = "";
}
