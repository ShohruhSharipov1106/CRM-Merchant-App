import 'dart:io';
import 'package:crm_merchant/models/marketplace/get_my_tariffs_model.dart';
import 'package:http/http.dart' as http;

import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/tariff/tariff_confirmation_page.dart';
import 'package:intl/intl.dart';

class TariffMainPage extends StatefulWidget {
  const TariffMainPage({Key? key}) : super(key: key);

  @override
  State<TariffMainPage> createState() => _TariffMainPageState();
}

class _TariffMainPageState extends State<TariffMainPage> {
  int? _whichTariff;
  bool _oneTapped = false;
  List<int> months = [3, 6, 9, 12];
  List<num> prepayments = [10, 10, 10, 10];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            StepsField(context, 7),
            SizedBox(height: kHeight(20.0).h),
            TitleOfPage("Выбрать тариф", kWidth(117.0).w),
            SizedBox(
              height: kHeight(768).h,
              child: Stack(
                children: [
                  SizedBox(
                    height: kHeight(768).h,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, __) => InkWell(
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: kWidth(kInpHorPad).w,
                                vertical: kHeight(7.5).h,
                              ),
                              padding: EdgeInsets.only(
                                left: kWidth(25.0).w,
                                top: kHeight(10.0).h,
                              ),
                              height: kHeight(228.0).h,
                              width: kWidth(368.0).w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: kWhiteColor,
                              ),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Тариф (Выгодный)\n\n",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                    TextSpan(
                                      text: NumberFormat(
                                              '###,###,###,###,###,###')
                                          .format(summValue == 0
                                              ? 0
                                              : summValue / months[__])
                                          .replaceAll(",", " "),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                    TextSpan(
                                      text: "  UZS в месяц\n\n",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(fontSize: 13.0),
                                    ),
                                    TextSpan(
                                      text:
                                          "Предоплата ${prepayments[__]}%\t\t",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    TextSpan(
                                      text: "Без переплат",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            _ribbon(__),
                            Positioned(
                              child: _whichTariff == __ || !_oneTapped
                                  ? Text.rich(
                                      TextSpan(
                                        text: "${months[__]}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(
                                              color: kWhiteColor,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: months[__] < 4
                                                ? "\nмесяца"
                                                : "\nмесяцев",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                  color: kWhiteColor,
                                                  fontSize: 10.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : const Text(""),
                              top: kHeight(25.0).h,
                              right: kWidth(40.0).w,
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _whichTariff = __;
                            _oneTapped = true;
                          });
                        },
                      ),
                      itemCount: months.length,
                    ),
                  ),
                  Positioned(
                    child: Visibility(
                      child: MainButton(
                        "Перейти к оформлению",
                        () {
                          Get.to(
                            TariffConfirmationPage(
                              months[_whichTariff!],
                            ),
                          );
                        },
                      ),
                      visible: _oneTapped,
                    ),
                    bottom: kHeight(30.0).h,
                    left: kWidth(80.0).w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _ribbon(int __) {
    return Positioned(
      child: _whichTariff == __ || !_oneTapped
          ? SvgPicture.asset(
              "assets/icons/opened-ribbon.svg",
              width: kWidth(52.0).w,
              height: kHeight(91.0).h,
              fit: BoxFit.cover,
            )
          : SvgPicture.asset(
              "assets/icons/closed-ribbon.svg",
              width: kWidth(52.0).w,
              height: kHeight(16.0).h,
              fit: BoxFit.cover,
            ),
      top: 0,
      right: kWidth(40.0).w,
    );
  }

  Future<List<GetMyTariffs>> _getTarifffromApi() async {
    Uri url =
        Uri.parse("https://crm.creditexpress.uz:6262/api/partner/GetTariffs");
    var res = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "text/plain",
        HttpHeaders.authorizationHeader:
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoibWFya2V0cGxhY2UiLCJjb21wYW55X2lkIjoiMDAwMDAwMDAtMDAwMC0wMDAwLTAwMDAtMDAwMDAwMDAwMDAxIiwidXNlcl90eXBlIjoiMTAiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJhZ2dyZWdhdGlvbiIsIm5iZiI6MTY0OTMxOTI5MSwiZXhwIjoxNjQ5MzIyODkxLCJpc3MiOiJjcm0uY3JlZGl0ZXhwcmVzcyIsImF1ZCI6Imh0dHBzOi8vY3JtLmNyZWRpdGV4cHJlc3MudXovIn0.gZYvysRyXsjdc0hFqHJ16xfsxWf6fQ0jwZLN0OuA2t0",
      },
    );
    print("object 1");
    if (res.statusCode == 200) {
      print("object 2");
      return (json.decode(res.body) as List)
          .map((e) => GetMyTariffs.fromJson(e))
          .toList();
    } else {
      print("${res.statusCode}");
      throw Exception('Xato bor: ${res.statusCode}');
    }
  }
}
