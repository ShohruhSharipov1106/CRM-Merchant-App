import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/models/marketplace/home_request_model.dart'
    as home_model;
import 'package:crm_merchant/screens/add_proposal/phone_number_page.dart';
import 'package:crm_merchant/screens/auth/sign_up_page.dart';
import 'package:crm_merchant/screens/home/components/full_information.dart';
import 'package:crm_merchant/screens/home/no_item_page.dart';
import 'package:crm_merchant/services/get_home_datas_service.dart';
import 'package:flutter/cupertino.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
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
                        _stateInforms(RequestState.all),
                        _stateInforms(
                          RequestState.confirmed,
                        ),
                        _stateInforms(
                          RequestState.considered,
                        ),
                        _stateInforms(
                          RequestState.declined,
                        ),
                        _stateInforms(
                          RequestState.neww,
                        ),
                        _stateInforms(
                          RequestState.draft,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  Hero(
                    tag: "home_button",
                    child: MainButton(
                      context,
                      "create_zayavka",
                      () {
                        ApiData()
                            .getToken(
                              username: clientMainData.read('username'),
                              passpord: clientMainData.read('password'),
                            )
                            .whenComplete(() => {
                                  setState(
                                    () {
                                    },
                                  )
                                })
                            .catchError(
                                // ignore: invalid_return_type_for_catch_error
                                (err) => Get.offAll(const SignUpPage()))
                            .then((value) =>
                                Get.to(const AddProposalPhoneNumberPage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<home_model.HomeRequestModel> _stateInforms(RequestState state) {
    List<bool> createdList = [];
    Future<home_model.HomeRequestModel> future =
        HomePageDataService.getStateRequest(state);
    future.then((value) =>
        {createdList = List.generate(value.totalCount ?? 0, (index) => false)});

    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<home_model.HomeRequestModel> snap) {
        return snap.connectionState == ConnectionState.done
            ? snap.hasData
                ? SizedBox(
                    height: kHeight(620.0).h,
                    child: snap.data!.totalCount == 0
                        ? const NoItemPage()
                        : LiquidPullToRefresh(
                            color: kYellowButtonColor,
                            onRefresh: () {
                              future.then((value) => {
                                    createdList = List.generate(
                                        value.totalCount ?? 0, (index) => false)
                                  });
                              return future =
                                  HomePageDataService.getStateRequest(state);
                            },
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snap.data!.totalCount,
                              itemBuilder: (BuildContext context, int index) {
                                List<home_model.Value> value =
                                    snap.data!.value!;

                                return state.name == value[index].state ||
                                        state.name == ''
                                    ? FullInformation(
                                        value[index].state,
                                        value[index].number!,
                                        value[index]
                                            .createdTime
                                            .toString()
                                            .replaceAll("T", " ")
                                            .substring(0, 20),
                                        NumberFormat('###,###,###,###,###,###')
                                            .format(value[index].amount)
                                            .replaceAll(",", " "),
                                        value[index].createdBy!,
                                        value[index].reasonForCancellation!,
                                        value[index].contractor!,
                                        createdList.isEmpty
                                            ? false
                                            : createdList[index],
                                      )
                                    : const SizedBox();
                              },
                            ),
                          ),
                  )
                : const InternetErrorPage()
            : Center(
                child: CupertinoActivityIndicator(radius: kHeight(25.0).h));
      },
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

  bool generateList(int length, int currrentIndex) {
    final generatedList = List.generate(length, (index) => true);
    return generatedList[currrentIndex];
  }
}
