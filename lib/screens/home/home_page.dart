import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/phone_number_page.dart';
import 'package:crm_merchant/screens/home/no_item_page.dart';
import 'package:crm_merchant/services/get_home_datas_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    value: -1.0,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  Widget build(BuildContext context) {
    HomePageProvider ctxWatchHomeProvider = context.watch<HomePageProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ZoomIn(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: kHeight(15.0).h),
              DefaultTabController(
                length: 6,
                initialIndex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _tabBar(context),
                    SizedBox(height: kHeight(19.0).h),
                    SizedBox(
                      height: kHeight(640.0).h,
                      width: 100.w,
                      child: TabBarView(
                        children: [
                          FutureBuilder(
                            future: HomePageDataService.getAllHomeDatas(),
                            builder: (context, AsyncSnapshot snap) {
                              return snap.hasData
                                  ? _snapDataField(snap, ctxWatchHomeProvider)
                                  : (snap.hasError
                                      ? _snapErrorField(context)
                                      : Center(
                                          child: Lottie.asset(
                                            "assets/images/lottie/loading_indicator.json",
                                            height: kHeight(200.0).h,
                                            width: kWidth(200.0).w,
                                          ),
                                        ));
                            },
                          ),
                          FutureBuilder(
                            future: HomePageDataService.getStateHomeDatas(
                                "Confirmed"),
                            builder: (context, AsyncSnapshot snap) {
                              return snap.hasData
                                  ? _snapDataField(snap, ctxWatchHomeProvider)
                                  : (snap.hasError
                                      ? _snapErrorField(context)
                                      : Center(
                                          child: Lottie.asset(
                                            "assets/images/lottie/loading_indicator.json",
                                            height: kHeight(200.0).h,
                                            width: kWidth(200.0).w,
                                          ),
                                        ));
                            },
                          ),
                          FutureBuilder(
                            future: HomePageDataService.getStateHomeDatas(
                                "Considered"),
                            builder: (context, AsyncSnapshot snap) {
                              return snap.hasData
                                  ? _snapDataField(snap, ctxWatchHomeProvider)
                                  : (snap.hasError
                                      ? _snapErrorField(context)
                                      : Center(
                                          child: Lottie.asset(
                                            "assets/images/lottie/loading_indicator.json",
                                            height: kHeight(200.0).h,
                                            width: kWidth(200.0).w,
                                          ),
                                        ));
                            },
                          ),
                          FutureBuilder(
                            future: HomePageDataService.getStateHomeDatas(
                                "Declined"),
                            builder: (context, AsyncSnapshot snap) {
                              return snap.hasData
                                  ? _snapDataField(snap, ctxWatchHomeProvider)
                                  : (snap.hasError
                                      ? _snapErrorField(context)
                                      : Center(
                                          child: Lottie.asset(
                                            "assets/images/lottie/loading_indicator.json",
                                            height: kHeight(200.0).h,
                                            width: kWidth(200.0).w,
                                          ),
                                        ));
                            },
                          ),
                          FutureBuilder(
                            future:
                                HomePageDataService.getStateHomeDatas("New"),
                            builder: (context, AsyncSnapshot snap) {
                              return snap.hasData
                                  ? _snapDataField(snap, ctxWatchHomeProvider)
                                  : (snap.hasError
                                      ? _snapErrorField(context)
                                      : Center(
                                          child: Lottie.asset(
                                            "assets/images/lottie/loading_indicator.json",
                                            height: kHeight(200.0).h,
                                            width: kWidth(200.0).w,
                                          ),
                                        ));
                            },
                          ),
                          FutureBuilder(
                            future:
                                HomePageDataService.getStateHomeDatas("Draft"),
                            builder: (context, AsyncSnapshot snap) {
                              return snap.hasData
                                  ? _snapDataField(snap, ctxWatchHomeProvider)
                                  : (snap.hasError
                                      ? _snapErrorField(context)
                                      : Center(
                                          child: Lottie.asset(
                                            "assets/images/lottie/loading_indicator.json",
                                            height: kHeight(200.0).h,
                                            width: kWidth(200.0).w,
                                          ),
                                        ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              MainButton(
                context,
                "create_zayavka",
                () {
                  Get.to(const AddProposalPhoneNumberPage());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  RefreshIndicator _snapErrorField(BuildContext context) {
    return RefreshIndicator(
      child: Column(
        children: [
          SizedBox(
            height: kHeight(50.0).h,
            child: ListView(),
          ),
          SizedBox(height: kHeight(50.0).h),
          TitleOfPage("no_internet_title", kWidth(0.0).w),
          SizedBox(height: kHeight(100.0).h),
          SvgPicture.asset(
            "assets/icons/error-internet.svg",
            height: kHeight(278.0).h,
            width: kWidth(278.0).w,
          ),
          SizedBox(height: kHeight(50.0).h),
          LocaleText(
            "internet_data_error",
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          )
        ],
      ),
      onRefresh: () async {
        HomePageDataService.getAllHomeDatas();
      },
    );
  }

  SingleChildScrollView _snapDataField(
      AsyncSnapshot<dynamic> snap, HomePageProvider ctxWatchHomeProvider) {
    return SingleChildScrollView(
      child: snap.data['totalCount'] == 0
          ? const NoItemPage()
          : ListView.builder(
              itemCount: snap.data['totalCount'],
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: ctxWatchHomeProvider.listOfAllInformation,
                );
              },
            ),
      physics: const BouncingScrollPhysics(),
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
        _aTab("all"),
        _aTab("approved"),
        _aTab("under_consideration"),
        _aTab("denied"),
        _aTab("new"),
        _aTab("draft"),
      ],
    );
  }

  Tab _aTab(String tabText) {
    return Tab(
      text: Locales.string(context, tabText),
      height: kHeight(28.0).h,
    );
  }
}
