import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/make_proposal_page.dart';
import 'package:intl/intl.dart';

class ListOfItem extends StatefulWidget {
  const ListOfItem({Key? key}) : super(key: key);

  @override
  State<ListOfItem> createState() => _ListOfItemState();
}

class _ListOfItemState extends State<ListOfItem> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: ((context) => const MakeProposalPage())),
        ).then(
          (value) => setState(() {}),
        );
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: ((context) => const MakeProposalPage()),
              ),
            ).then(
              (value) => setState(() {}),
            ),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kBlackTextColor,
              size: 24.0,
            ),
          ),
          title: LocaleText(
            "list_of_zayavka",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          height: 100.h,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: kHeight(620.0).h,
                  child: ListView.builder(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${itemList[index].productName}\n${itemList[index].price} ??????",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  GestureDetector(
                                    child: SvgPicture.asset(
                                        "assets/icons/delete-icon.svg"),
                                    onTap: () {
                                      summ.removeAt(index);
                                      itemList.removeAt(index);

                                      context
                                          .read<AddProposalProvider>()
                                          .itemListLength = itemList.length;
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: itemList.length,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: kWidth(30.0).w,
                    top: kHeight(25.0).h,
                  ),
                  child: Row(
                    children: [
                      LocaleText(
                        "sum_of_price",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        " - ${NumberFormat('###,###,###,###,###,###').format(summ.isEmpty ? 0 : summ.reduce((value, element) => value + element)).replaceAll(",", " ")}  ",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      LocaleText(
                        "valyuta",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: kHeight(50.0).h,
                    left: kWidth(78.0).w,
                  ),
                  child: MainButton(
                    context,
                    "continue",
                    () {
                      Get.to(const MakeProposalPage());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
