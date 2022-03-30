import 'dart:io';

import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/tariff/components/parametrs_lists.dart';
import 'package:crm_merchant/screens/tariff/tariff_confirmation_page.dart';

class TariffMainPage extends StatefulWidget {
  const TariffMainPage({Key? key}) : super(key: key);

  @override
  State<TariffMainPage> createState() => _TariffMainPageState();
}

class _TariffMainPageState extends State<TariffMainPage> {
  int? _whichTariff;
  bool _oneTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            StepsField(7),
            SizedBox(height: kHeight(20.0).h),
            TitleOfPage("Выбрать тариф", kWidth(117.0).w),
            Stack(
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
                                    text:
                                        "${summs[__].toString().replaceRange(3, 4, " 0")}\t",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                  TextSpan(
                                    text: "UZS в месяц\n\n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(fontSize: 13.0),
                                  ),
                                  TextSpan(
                                    text: "Предоплата ${prepayments[__]}%\t\t",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  TextSpan(
                                    text: "Без переплат",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Positioned(
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
                            right: 40,
                          ),
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
                            top: 25,
                            right: 40,
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
                          TariffConfirmationPage(months[_whichTariff!]),
                        );
                      },
                      _oneTapped,
                    ),
                    visible: _oneTapped,
                  ),
                  bottom: kHeight(30.0).h,
                  left: kWidth(80.0).w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
