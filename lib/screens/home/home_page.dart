import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/models/marketplace/home_request_model.dart';
import 'package:crm_merchant/screens/add_proposal/phone_number_page.dart';
import 'package:crm_merchant/screens/auth/sign_up_page.dart';
import 'package:crm_merchant/screens/home/components/full_information.dart';
import 'package:crm_merchant/screens/home/no_item_page.dart';
import 'package:crm_merchant/services/get_home_datas_service.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

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

  late bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    HomePageProvider ctxWatchHomeProvider = context.watch<HomePageProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ZoomIn(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 15),
              DefaultTabController(
                length: 6,
                initialIndex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _tabBar(context),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: kHeight(600.0).h,
                      width: 100.w,
                      child: TabBarView(
                        children: [
                        _stateInforms(ctxWatchHomeProvider, RequestState.all),
                        _stateInforms(
                            ctxWatchHomeProvider,
                            RequestState.confirmed,
                          ),
                          _stateInforms(
                            ctxWatchHomeProvider,
                            RequestState.considered,
                          ),
                          _stateInforms(
                            ctxWatchHomeProvider,
                            RequestState.declined
                          ),
                          _stateInforms(
                            ctxWatchHomeProvider,
                            RequestState.neww,
                          ),
                          _stateInforms(
                            ctxWatchHomeProvider,
                            RequestState.draft,
                          ),

                          // LiquidPullToRefresh(
                          //   color: kMainColor,
                          //   onRefresh: () {
                          //     setState(() {});
                          //     return Future.delayed(const Duration(seconds: 1));
                          //   },
                          //   child: ListView.builder(
                          //     physics: const BouncingScrollPhysics(),
                          //     itemCount: 4,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       return Column(
                          //         children:
                          //             ctxWatchHomeProvider.listOfAllInformation,
                          //       );
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              MainButton(
                context,
                "create_zayavka",
                () {
                  setState(() {
                    _showLoader = true;
                  });
                  ApiData()
                      .getToken(
                        username: clientMainData.read('username'),
                        passpord: clientMainData.read('password'),
                      )
                      .whenComplete(() => {
                            setState(
                              () {
                                _showLoader = false;
                              },
                            )
                          })
                      // ignore: invalid_return_type_for_catch_error
                      .catchError((err) => Get.offAll(const SignUpPage()))
                      .then((value) =>
                          Get.to(const AddProposalPhoneNumberPage()));
                },
                showLoader: _showLoader,
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<HomeRequestModel> _stateInforms(
      HomePageProvider ctxWatchHomeProvider, RequestState state) {
    return FutureBuilder(
      future: HomePageDataService.getStateRequest(state),
      builder: (context, AsyncSnapshot<HomeRequestModel> snap) {
        return snap.hasData
            ? _snapDataField(snap, ctxWatchHomeProvider, state)
            : (snap.hasError
                      ? const InternetErrorPage()
                      : Center(
                          child: Lottie.asset(
                            "assets/images/lottie/loading_indicator.json",
                            height: kHeight(160.0).h,
                            width: kWidth(160.0).w,
                          ),
                        ));
      },
    );
  }

  SingleChildScrollView _snapDataField(AsyncSnapshot<HomeRequestModel> snap,
      HomePageProvider ctxWatchHomeProvider, RequestState state) {
    return SingleChildScrollView(
      child: snap.data!.totalCount == 0
          ? const NoItemPage()
          : LiquidPullToRefresh(
              color: kYellowButtonColor,
              onRefresh: () {
                setState(() {});
                return Future.delayed(const Duration(microseconds: 1));
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snap.data!.totalCount,
                itemBuilder: (BuildContext context, int index) {
                  List<RequestModel> value = snap.data!.value!;
                  return state.name == value[index].state || state.name == " "
                      ? FullInformation(
                          value[index].state,
                          value[index].number!,
                          value[index]
                              .createdTime
                              .toString()
                              .replaceAll("T", " ")
                              .substring(20),
                          NumberFormat('###,###,###,###,###,###')
                              .format(value[index].amount)
                              .replaceAll(",", " "),
                          value[index].createdBy!,
                          value[index].reasonForCancellation!,
                          value[index].contractor!,
                        )
                      : const SizedBox();
                },
              ),
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
