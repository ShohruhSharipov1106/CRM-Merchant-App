import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/phone_number_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageProvider ctxWatchHomeProvider = context.watch<HomePageProvider>();
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ZoomIn(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: kHeight(12.0).h),
              TitleOfPage("Список заявок", kWidth(20.0).w),
              SizedBox(height: kHeight(10.0).h),
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
                            child: Column(
                              children:
                                  ctxWatchHomeProvider.listOfAllInformation,
                            ),
                            physics: const BouncingScrollPhysics(),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children:
                                  ctxWatchHomeProvider.listOfDoneInformation,
                            ),
                            physics: const BouncingScrollPhysics(),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children:
                                  ctxWatchHomeProvider.listOfWaitingInformation,
                            ),
                            physics: const BouncingScrollPhysics(),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children:
                                  ctxWatchHomeProvider.listOfErrorInformation,
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
                "Создать заявку",
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
