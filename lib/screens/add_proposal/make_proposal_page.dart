import 'dart:io';

import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/tariff/tariff_main_page.dart';
import 'package:flutter/services.dart';

class MakeProposalPage extends StatefulWidget {
  const MakeProposalPage({Key? key}) : super(key: key);

  @override
  State<MakeProposalPage> createState() => _MakeProposalPageState();
}

class _MakeProposalPageState extends State<MakeProposalPage> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to pick image: $e");
    }
  }

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
                                  ? image != null
                                      ? Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(
                                          Icons.add,
                                          size: 40.0,
                                        )
                                  : image != null
                                      ? Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                        )
                                      : SvgPicture.asset(
                                          "assets/icons/camera.svg",
                                          height: kHeight(20.0).h,
                                          width: kWidth(26.0).w,
                                          fit: BoxFit.cover,
                                        ),
                            ),
                          ),
                          onTap: () => pickImage(ImageSource.gallery),
                        ),
                        itemCount: 5,
                      ),
                    ),
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

  InputField _summ(BuildContext context) {
    return InputField(
      context,
      context.watch<AddProposalProvider>().summThings,
      "Сумма",
      "Недопустимая сумма",
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
      "Наименование товара",
      "Недопустимые символы для товара",
      TextInputType.text,
      29,
      "* * * * * * * * * * * * * * *",
      "* * * * * * * * * * * * * * *",
      {"*": RegExp(r'[A-z]')},
    );
  }

  Padding _button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kButHorPad),
      child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: context.watch<AddProposalProvider>().namingThings,
          builder: (context, v, child) {
            return ListenableButton(
              "Продолжить",
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
                        7) {
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
      padding: const EdgeInsets.only(left: kMainPadding),
      child: Text(
        context.watch<AddProposalProvider>().isError
            ? "Недопустимые символы для товара"
            : "Заполните заявку",
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: context.watch<AddProposalProvider>().isError
                  ? kMainColor
                  : kBlackTextColor,
            ),
      ),
    );
  }
}
