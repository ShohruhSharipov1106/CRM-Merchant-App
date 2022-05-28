import 'package:collection/collection.dart';
import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/list_of_item_page.dart';
import 'package:crm_merchant/screens/tariff/tariff_main_page.dart';

class MakeProposalPage extends StatefulWidget {
  const MakeProposalPage({Key? key}) : super(key: key);

  @override
  State<MakeProposalPage> createState() => _MakeProposalPageState();
}

class _MakeProposalPageState extends State<MakeProposalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            StepsField(context, 6),
            SizedBox(height: kHeight(20.0).h),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TitleOfPage("make_proposal", kWidth(120.0).w),
                        SizedBox(width: kWidth(80.0).w),
                        InkWell(
                          child: Stack(
                            children: [
                              SizedBox(
                                height: kHeight(42.0).h,
                                width: kWidth(42.0).w,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: kHeight(10.0).h,
                                    right: kWidth(14.0).w,
                                    top: kHeight(2.0).h,
                                  ),
                                  child: SvgPicture.asset(
                                    "assets/icons/job-description-icon.svg",
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: itemList.isEmpty ? false : true,
                                child: Positioned(
                                  child: CircleAvatar(
                                    radius: kHeight(11.5).h,
                                    backgroundColor: kMainColor,
                                    child: Text(
                                      "${itemList.length}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: kWhiteColor,
                                            fontSize: 14.0,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  right: kWidth(8.0).w,
                                  bottom: 0,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Get.to(const ListOfItem());
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: kHeight(20.0).h),
                    _headlineText(context),
                    SizedBox(height: kHeight(20.0).h),
                    _listOfInputField(context),
                    SizedBox(height: kHeight(22.0).h),
                    Padding(
                      padding: EdgeInsets.only(left: kWidth(182.0).w),
                      child: InkWell(
                        child: Material(
                          elevation: 4.0,
                          color: kYellowButtonColor,
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(kHeight(5.0).h),
                            child: Icon(
                              Icons.add,
                              size: kHeight(47.0).h,
                              color: kWhiteColor,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {});
                          summ.add(
                            int.parse(
                              context
                                  .read<AddProposalProvider>()
                                  .summThings
                                  .text
                                  .removeAllWhitespace,
                            ),
                          );
                          itemList.add(
                            [
                              context
                                  .read<AddProposalProvider>()
                                  .namingThings
                                  .text,
                              context
                                  .read<AddProposalProvider>()
                                  .summThings
                                  .text
                            ],
                          );
                          summValue = summ.sum;

                          context
                              .read<AddProposalProvider>()
                              .namingThings
                              .clear();
                          context
                              .read<AddProposalProvider>()
                              .summThings
                              .clear();
                        },
                      ),
                    ),
                    SizedBox(height: kHeight(15.0).h),
                    SizedBox(height: kHeight(90.0).h),
                    _button(context),
                    SizedBox(height: kHeight(53.0).h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _listOfInputField(BuildContext context) {
    return Column(
      children: [
        _naming(context),
        _summ(context),
      ],
    );
  }

  InputField _summ(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().summThings,
      "price",
      "error_price",
      TextInputType.number,
      29,
      "* * * * * * * * * * * * * * *",
      "# * * * * * * * * * * * * * *",
      {
        "#": RegExp(r'[1-9]'),
        "*": RegExp(r'[0-9]'),
      },
    );
  }

  InputField _naming(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().namingThings,
      "rename",
      "error_rename",
      TextInputType.text,
      29,
      "* * * * * * * * * * * * * * *",
      "* * * * * * * * * * * * * * *",
      {"*": RegExp(r'[A-zЁёА-я]')},
    );
  }

  Padding _button(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(kButHorPad).w),
      child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: context.watch<AddProposalProvider>().namingThings,
          builder: (context, v, child) {
            return ListenableButton(
              context,
              'continue',
              () {
                if (context
                                .read<AddProposalProvider>()
                                .namingThings
                                .text
                                .length >=
                            8 &&
                        context
                                .read<AddProposalProvider>()
                                .summThings
                                .text
                                .length >=
                            7 ||
                    itemList.isNotEmpty) {
                  Get.to(const TariffMainPage());
                  context.read<AddProposalProvider>().hasnotError();
                } else {
                  context.read<AddProposalProvider>().hasError();
                }
              },
              context.watch<AddProposalProvider>().summThings,
              v.text.length >= 3 ? 4 : 20,
            );
          }),
    );
  }

  Padding _headlineText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kWidth(kMainPadding).w),
      child: LocaleText(
        "fullfill_proposal",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: context.watch<AddProposalProvider>().isError
                  ? kMainColor
                  : kBlackTextColor,
            ),
      ),
    );
  }
}
