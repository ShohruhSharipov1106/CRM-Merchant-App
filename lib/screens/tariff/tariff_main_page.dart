import 'dart:io';

import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/tariff/components/parametrs_lists.dart';

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
      appBar: addProposalAppBar(context, "Выбрать тариф"),
      body: Stack(
        children: [
          SizedBox(
            height: 90.h,
            child: ListView.builder(
              itemBuilder: (_, __) => InkWell(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: kWidth(kInpHorPad).w,
                    vertical: kHeight(7.5).h,
                  ),
                  height: kHeight(228.0).h,
                  width: kWidth(368.0).w,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: _whichTariff != __ && _oneTapped
                        ? kBlackTextColor.withOpacity(0.2)
                        : Colors.transparent,
                    border: Border.all(
                      color: kMainColor,
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: kHeight(228.0).h,
                        width: kWidth(184.0).w,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30.0),
                          ),
                          color: kMainColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${months[__]}",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                "месяца",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: kWhiteColor,
                                    ),
                                overflow: TextOverflow.clip,
                                softWrap: false,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: kHeight(228.0).h,
                        width: kWidth(184.0).w,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(30.0),
                          ),
                          color: kWhiteColor,
                        ),
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Предоплата ${prepayments[__]}%\n\n",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                TextSpan(
                                  text: "Без переплат\n\n",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                TextSpan(
                                  text:
                                      "${summs[__].toString().replaceRange(3, 4, " 0")}\n",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(fontSize: 36.0),
                                ),
                                TextSpan(
                                  text: "UZS в месяц",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(fontSize: 14.0),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                () {},
              ),
              visible: _oneTapped,
            ),
            bottom: kHeight(30.0).h,
            left: kWidth(80.0).w,
          ),
        ],
      ),
    );
  }
}
