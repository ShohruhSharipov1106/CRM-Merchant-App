import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/make_proposal_page.dart';

class ListOfItem extends StatelessWidget {
  const ListOfItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kBlackTextColor,
            size: 24.0,
          ),
        ),
        title: Text(
          "Список заявок",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kWidth(30.0).w,
                    vertical: kHeight(15.0 / 2).h,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    child: SizedBox(
                      width: kWidth(368.0).w,
                      height: kHeight(81.0).h,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: kWidth(24.0).w,
                          right: kWidth(15.0).w,
                          top: kHeight(12.0).h,
                          bottom: kHeight(12.0).h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Лук\n40 000сум",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            InkWell(
                              child: SvgPicture.asset(
                                  "assets/icons/delete-icon.svg"),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                left: kWidth(30.0).w,
                top: kHeight(25.0).h,
              ),
              child: Text(
                "Итого-120 000сум",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: kHeight(50.0).h,
                left: kWidth(78.0).w,
              ),
              child: MainButton(
                "Продолжить",
                () {
                  Get.to(const MakeProposalPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
