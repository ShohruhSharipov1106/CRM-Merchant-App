import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/providers/home_page_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageProvider ctxWatchHomeProvider = context.watch<HomePageProvider>();
    HomePageProvider ctxReadHomeProvider = context.read<HomePageProvider>();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: kHeight(36.0).h),
          TitleOfPage("Список заявок", kWidth(123.0)),
          SizedBox(height: kHeight(15.0).h),
          DefaultTabController(
            length: 4,
            initialIndex: 0,
            child: Column(
              children: [
                _tabBar(context),
                SizedBox(height: kHeight(19.0).h),
                SizedBox(
                  height: kHeight(680.0).h,
                  width: 100.w,
                  child: TabBarView(
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: ctxWatchHomeProvider.mainSzbHeight,
                                width: ctxWatchHomeProvider.mainSzbWidth,
                              ),
                              Positioned(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: kWidth(kMainPadding).w),
                                  padding: EdgeInsets.only(
                                    left: kWidth(20.0).w,
                                    right: kWidth(20.0).w,
                                    top: kHeight(20.0).h,
                                  ),
                                  height:
                                      ctxWatchHomeProvider.mainContainerHeight,
                                  width:
                                      ctxWatchHomeProvider.mainContainerWidth,
                                  child: ctxWatchHomeProvider.isVisible
                                      ? Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Дата подачи заявки\t\t",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                              ),
                                              // time
                                              TextSpan(
                                                text: "11.11.2012 11:15\n",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                              TextSpan(
                                                text:
                                                    "Сумма рассрочки\t\t\t\t\t\t",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                              ),
                                               WidgetSpan(
                                                child: SizedBox(width: kWidth(45.0).w,)
                                              ),
                                              // summ
                                              TextSpan(
                                                text: "20 468 455\n",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                              TextSpan(
                                                text: "Магазин\t\t",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                              ),
                                              WidgetSpan(
                                                child: SizedBox(width: kWidth(160.0).w,)
                                              ),
                                              // place
                                              TextSpan(
                                                text: "Tashkent\n",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                              TextSpan(
                                                text: "Создал\t\t",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                              ),
                                            WidgetSpan(
                                                child: SizedBox(width: kWidth(170.0).w,)
                                              ),
                                              // place
                                              TextSpan(
                                                text: "Tashkent\n",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                              TextSpan(
                                                text: "Причина\t\t",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                              ),
                                            WidgetSpan(
                                                child: SizedBox(width: kWidth(160.0).w,)
                                              ),
                                              // place
                                              TextSpan(
                                                text: "Tashkent\n",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                              TextSpan(
                                                text: "Клиент\t\t",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                              ),
                                              // client
                                              TextSpan(
                                                text:
                                                    "VIKTOR KAMAROV VIKTOROVICH",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: "Дата подачи заявки\t\t",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                              ),
                                              // add date
                                              TextSpan(
                                                text: "11.11.2012 11:15\n",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                              TextSpan(
                                                text:
                                                    "Сумма рассрочки\t\t\t\t\t\t",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                              ),
                                              // add sum
                                              TextSpan(
                                                text: "20 468 455\n",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                            ],
                                          ),
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
                              _hideUnhideText(
                                  ctxWatchHomeProvider, ctxReadHomeProvider),
                              _buttonInContainer(ctxWatchHomeProvider, context),
                              _chipField(context),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: kHeight(500.0).h,
                            width: 100.w,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: kHeight(500.0).h,
                            width: 100.w,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: kHeight(500.0).h,
                            width: 100.w,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MainButton("Создать заявку", () {}),
        ],
      ),
    );
  }

  Positioned _buttonInContainer(
      HomePageProvider ctxWatchHomeProvider, BuildContext context) {
    return Positioned(
      child: Visibility(
        visible: ctxWatchHomeProvider.isVisible,
        child: ElevatedButton(
          child: Text(
            "Оформить",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          style: ElevatedButton.styleFrom(
            primary: kYellowButtonColor,
            fixedSize: Size(
              kWidth(200.0).w,
              kHeight(40.0).h,
            ),
            minimumSize: Size(
              kWidth(200.0).w,
              kHeight(40.0).h,
            ),
            elevation: 0,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () {},
        ),
      ),
      bottom: kHeight(28.0).h,
      left: kWidth(98.0).w,
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
                text: "Одобрено",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: kGreenLabelColor),
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

  Positioned _hideUnhideText(HomePageProvider ctxWatchHomeProvider,
      HomePageProvider ctxReadHomeProvider) {
    return Positioned(
      child: InkWell(
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
      ),
      bottom: kHeight(15.0).h,
      left: kWidth(175.0).w,
    );
  }

  TabBar _tabBar(BuildContext context) {
    return TabBar(
      isScrollable: true,
      indicatorColor: kBlackTextColor,
      indicatorWeight: 2.0,
      labelColor: kBlackTextColor,
      unselectedLabelColor: kUnselectedLabelColor,
      padding: EdgeInsets.symmetric(
        vertical: kHeight(15.0).h,
        horizontal: kWidth(36.0).w,
      ),
      indicatorPadding: EdgeInsets.only(top: kHeight(2.0).h),
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: Theme.of(context).textTheme.labelMedium,
      unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
      tabs: [
        _aTab("Все"),
        _aTab("Одобрено"),
        _aTab("Рассматривается"),
        _aTab("Отказано"),
      ],
    );
  }

  Tab _aTab(String tabText) {
    return Tab(
      text: tabText,
      height: kHeight(28.0).h,
    );
  }
}
