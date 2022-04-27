import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/phone_number_page.dart';
import 'package:crm_merchant/screens/home/no_item_page.dart';
import 'package:crm_merchant/screens/profile/profile_drawer_page.dart';

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
              SizedBox(height: kHeight(20.0).h),
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
                          SingleChildScrollView(
                            child: ctxWatchHomeProvider
                                    .listOfAllInformation.isEmpty
                                ? const NoItemPage()
                                : Column(
                                    children: ctxWatchHomeProvider
                                        .listOfAllInformation,
                                  ),
                            physics: const BouncingScrollPhysics(),
                          ),
                          SingleChildScrollView(
                            child: ctxWatchHomeProvider
                                    .listOfDoneInformation.isEmpty
                                ? const NoItemPage()
                                : Column(
                                    children: ctxWatchHomeProvider
                                        .listOfDoneInformation,
                                  ),
                            physics: const BouncingScrollPhysics(),
                          ),
                          SingleChildScrollView(
                            child: ctxWatchHomeProvider
                                    .listOfWaitingInformation.isEmpty
                                ? const NoItemPage()
                                : Column(
                                    children: ctxWatchHomeProvider
                                        .listOfWaitingInformation,
                                  ),
                            physics: const BouncingScrollPhysics(),
                          ),
                          SingleChildScrollView(
                            child: ctxWatchHomeProvider
                                    .listOfErrorInformation.isEmpty
                                ? const NoItemPage()
                                : Column(
                                    children: ctxWatchHomeProvider
                                        .listOfErrorInformation,
                                  ),
                            physics: const BouncingScrollPhysics(),
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
