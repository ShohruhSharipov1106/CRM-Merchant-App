import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/home/components/checkout_button.dart';

class FullInformation extends StatelessWidget {
  Color? situationColor;
  FullInformation(this.situationColor, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    HomePageProvider ctxWatchHomeProvider = context.watch<HomePageProvider>();
    HomePageProvider ctxReadHomeProvider = context.read<HomePageProvider>();

    return Stack(
      children: [
        SizedBox(
          height: ctxWatchHomeProvider.mainSzbHeight,
          width: ctxWatchHomeProvider.mainSzbWidth,
        ),
        Positioned(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: kWidth(kMainPadding).w),
            padding: EdgeInsets.only(
              left: kWidth(20.0).w,
              right: kWidth(20.0).w,
              top: kHeight(20.0).h,
            ),
            height: ctxWatchHomeProvider.mainContainerHeight,
            width: ctxWatchHomeProvider.mainContainerWidth,
            child: ctxWatchHomeProvider.isVisible
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: kHeight(176.0).h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _informations(
                              context,
                              "Дата подачи заявки",
                              "11.11.2012 11:15",
                            ),
                            _informations(
                              context,
                              "Сумма рассрочки",
                              "20 468 455",
                            ),
                            _informations(
                              context,
                              "Магазин",
                              "Tashkent",
                            ),
                            _informations(
                              context,
                              "Создал",
                              "Tashkent",
                            ),
                            _informations(
                              context,
                              "Причина",
                              "Tashkent",
                            ),
                            _informations(
                              context,
                              "Клиент",
                              "VIKTOR KAMAROV",
                            ),
                          ],
                        ),
                      ),
                      const CheckOutButton(),
                      _hideUnhideText(
                          ctxWatchHomeProvider, ctxReadHomeProvider),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: kHeight(53.0).h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _informations(
                              context,
                              "Дата подачи заявки",
                              "11.11.2012 11:15",
                            ),
                            _informations(
                              context,
                              "Сумма рассрочки",
                              "20 468 455",
                            ),
                          ],
                        ),
                      ),
                      _hideUnhideText(
                          ctxWatchHomeProvider, ctxReadHomeProvider),
                    ],
                  ),
            decoration: const BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
          ),
          top: kHeight(25.0).h,
          left: 0,
        ),
        _chipField(context),
      ],
    );
  }

  InkWell _hideUnhideText(HomePageProvider ctxWatchHomeProvider,
      HomePageProvider ctxReadHomeProvider) {
    return InkWell(
      child: Text(
        ctxWatchHomeProvider.hideText,
        style: const TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w400,
          color: kGreyLabelColor,
        ),
      ),
      splashColor: kGreenLabelColor,
      onTap: () => ctxWatchHomeProvider.mainContainerHeight == kHeight(98.0).h
          ? ctxReadHomeProvider.increaseSize()
          : ctxReadHomeProvider.decreaseSize(),
    );
  }

  Row _informations(
    BuildContext context,
    String title,
    String information,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        Text(
          information,
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.right,
          overflow: TextOverflow.fade,
        ),
      ],
    );
  }

  Positioned _chipField(BuildContext context) {
    return Positioned(
      child: Chip(
        label: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "№1  ",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
              TextSpan(
                text: situationColor == kGreenLabelColor
                    ? "Одобрено"
                    : situationColor == kGreyLabelColor
                        ? "Рассматривается"
                        : "Отказано",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: situationColor),
              ),
            ],
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 5.0,
        shadowColor: kBlackTextColor,
      ),
      top: -kHeight(2.0).h,
      left: kWidth(10.0).w,
    );
  }
}
