import 'dart:html';

import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/tariff/tariff_main_page.dart';

class MakeProposalPage extends StatefulWidget {
  const MakeProposalPage({Key? key}) : super(key: key);

  @override
  State<MakeProposalPage> createState() => _MakeProposalPageState();
}

class _MakeProposalPageState extends State<MakeProposalPage> {
  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) final imageTemporary = File(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            StepsField(6),
            SizedBox(height: kHeight(20.0).h),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleOfPage("Создание заявки", kWidth(88.0).w),
                    SizedBox(height: kHeight(20.0).h),
                    _headlineText(context),
                    SizedBox(height: kHeight(20.0).h),
                    _naming(context),
                    _summ(context),
                    SizedBox(height: kHeight(22.0).h),
                    Padding(
                      padding: const EdgeInsets.only(left: kMainPadding),
                      child: Text(
                        "Загрузите фото ",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    SizedBox(height: kHeight(15.0).h),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: kWidth(34.0).w),
                      height: kHeight(60.0).h,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 15.0,
                        ),
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, __) => InkWell(
                          child: Container(
                            foregroundDecoration: BoxDecoration(
                              border: Border.all(
                                color: kBlackTextColor,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: __ == 0
                                  ? const Icon(
                                      Icons.add,
                                      size: 40.0,
                                    )
                                  : SvgPicture.asset(
                                      "assets/icons/camera.svg",
                                      height: kHeight(20.0).h,
                                      width: kWidth(26.0).w,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          onTap: () => pickImage(),
                        ),
                        itemCount: 5,
                      ),
                    ),
                    SizedBox(height: kHeight(90.0).h),
                    // ADD IF VALIDATE THEN NEXT PAGE
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

  InputField _summ(BuildContext context) {
    return InputField(
      context.watch<AddProposalProvider>().summThings,
      "Сумма",
      TextInputType.number,
      (v) {
        if (v!.length < 4) return "";
        return null;
      },
      29,
      "* * * * * * * * * * * * * * *",
      "* * * * * * * * * * * * * * *",
      {"*": RegExp(r'[0-9]')},
    );
  }

  InputField _naming(BuildContext context) {
    return InputField(
      context.watch<AddProposalProvider>().namingThings,
      "Наименование товара",
      TextInputType.text,
      (v) {
        if (v!.length < 2) return "";
        return null;
      },
      29,
      "* * * * * * * * * * * * * * *",
      "* * * * * * * * * * * * * * *",
      {"*": RegExp(r'[A-z]')},
    );
  }

  Padding _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kButHorPad),
      child: MainButton(
        "Продолжить",
        () {
          Get.to(const TariffMainPage());
        },
        true,
      ),
    );
  }

  Padding _headlineText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kMainPadding),
      child: Text(
        "Заполните заявку",
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
