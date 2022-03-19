import 'package:crm_merchant/constants/exports.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: kHeight(36.0)),
          TitleOfPage("Список заявок", kWidth(123.0)),
          SizedBox(height: kHeight(15.0)),
          DefaultTabController(
            length: 4,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(
                      text: "Все",
                      height: kHeight(20.0).h,
                    ),
                    Tab(
                      text: "Одобрено",
                      height: kHeight(20.0).h,
                    ),
                    Tab(
                      text: "Рассматривается",
                      height: kHeight(20.0).h,
                    ),
                    Tab(
                      text: "Отказано",
                      height: kHeight(20.0).h,
                    ),
                  ],
                ),
              TabBarView(children: [])],
            ),
          ),
        ],
      ),
    );
  }
}
