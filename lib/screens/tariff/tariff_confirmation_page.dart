import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/tariff/components/parametrs_lists.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TariffConfirmationPage extends StatefulWidget {
  int tarifCount;
  TariffConfirmationPage(this.tarifCount, {Key? key}) : super(key: key);

  @override
  State<TariffConfirmationPage> createState() => _TariffConfirmationPageState();
}

class _TariffConfirmationPageState extends State<TariffConfirmationPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final ItemScrollController _itemScrollController = ItemScrollController();

  int _currentCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            StepsField(context, 8),
            SizedBox(height: kHeight(20.0).h),
            TitleOfPage("Подтверджение ", kWidth(123.0).w),
            SizedBox(height: kHeight(50.0).h),
            SizedBox(
              height: kHeight(207.0).h,
              child: Row(
                children: [
                  Container(
                    height: kHeight(206.79).h,
                    width: kWidth(172.0).w,
                    margin: EdgeInsets.only(
                      left: kWidth(42.0).w,
                      right: kWidth(30.0).w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: kWhiteColor,
                      border: Border.all(
                        color: kBlackTextColor,
                        width: 1.0,
                      ),
                      image: const DecorationImage(
                        image: AssetImage(
                          "assets/icons/camera.png",
                        ),
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 18.0),
                      children: [
                        _informationTitle(context, "Номер паспорта"),
                        const TextSpan(text: "АА1564457\n\n"),
                        _informationTitle(context, "Дата рождения"),
                        const TextSpan(text: "11.04.2020\n\n"),
                        _informationTitle(context,
                            "Первоначальный взнос\n(будет списан с карты)"),
                        const TextSpan(text: "16 000 сум\n\n"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: kHeight(20.0).h),
            _graficPayment(context),
            SizedBox(height: kHeight(47.0).h),
            _showModalBottom(),
          ],
        ),
      ),
    );
  }

  Padding _graficPayment(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kWidth(44.0).w),
      child: SizedBox(
        width: kWidth(340.0).w,
        child: Column(
          children: [
            _graficPaymentTitleBody(context),
            _graficPaymentMainBody(context),
          ],
        ),
      ),
    );
  }

  Container _graficPaymentTitleBody(BuildContext context) {
    return Container(
      height: kHeight(43.0).h,
      width: kWidth(340.0).w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
        color: kMainColor,
      ),
      child: Center(
        child: Text(
          "График платежей",
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: kWhiteColor),
        ),
      ),
    );
  }

  Container _graficPaymentMainBody(BuildContext context) {
    return Container(
      width: kWidth(340.0).w,
      height: kHeight(220.0).h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
        color: kWhiteColor,
      ),
      padding: EdgeInsets.only(
        top: kHeight(8.0).h,
      ),
      child: Column(
        children: [
          SizedBox(
            width: kWidth(340.0).w,
            height: kHeight(175.0).h,
            child: ScrollablePositionedList.builder(
              itemScrollController: _itemScrollController,
              itemBuilder: (_, __) => _paymentSchedule(context, __ + 1),
              itemCount: widget.tarifCount,
              physics: _currentCount < widget.tarifCount - 5
                  ? const BouncingScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
            ),
          ),
          SizedBox(height: kHeight(10.0).h),
          GestureDetector(
            child: Visibility(
              visible: widget.tarifCount > 6 ? true : false,
              child: Image.asset(
                _currentCount < widget.tarifCount - 5
                    ? "assets/icons/down.png"
                    : "assets/icons/up.png",
                width: kWidth(25.0).w,
                height: kHeight(25.0).h,
                fit: BoxFit.cover,
              ),
            ),
            onTap: () {
              setState(() {
                _currentCount < widget.tarifCount - 5
                    ? _currentCount += 1
                    : _currentCount = 0;
              });
              _itemScrollController.scrollTo(
                index: _currentCount == 0 ? 0 : _currentCount,
                duration: const Duration(milliseconds: 300),
              );
            },
          ),
        ],
      ),
    );
  }

  Padding _showModalBottom() {
    return Padding(
      padding: const EdgeInsets.only(left: kButHorPad),
      child: MainButton(
        "Подтвердить",
        () => _scaffoldKey.currentState!.showBottomSheet(
          (context) => Container(
            padding: EdgeInsets.symmetric(
              horizontal: kWidth(40.0).w,
              vertical: kHeight(30.0).h,
            ),
            height: kHeight(382.0).h,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
              color: kWhiteColor,
            ),
            child: Column(
              children: [
                Text(
                  "Ваша заявка принята",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 24.0),
                ),
                SizedBox(height: kHeight(10.0).h),
                Text(
                  "Результат будет оправлен через SMS",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(height: kHeight(20.0).h),
                MainButton(
                  "Завершить",
                  () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _paymentSchedule(BuildContext context, int month) {
    return SizedBox(
      height: kHeight(31.0).h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: kWidth(12.0).w),
          Text(
            month.toString(),
            style: TextStyle(
              color: kBlackTextColor.withOpacity(0.5),
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: kWidth(17.0).w),
          Text(
            "10.04.2020",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(width: kWidth(72.0).w),
          Text(
            "175 000 UZS",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }

  TextSpan _informationTitle(BuildContext context, String title) {
    return TextSpan(
      text: title + "\n",
      style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 10.0),
    );
  }
}
