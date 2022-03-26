import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/tariff/tariff_main_page.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'dart:async';

class MakeProposalPage extends StatefulWidget {
  const MakeProposalPage({Key? key}) : super(key: key);

  @override
  State<MakeProposalPage> createState() => _MakeProposalPageState();
}

class _MakeProposalPageState extends State<MakeProposalPage> {
  List<Asset> images = <Asset>[];

  String _error = 'No Error Dectected';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: const CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: const MaterialOptions(
          actionBarColor: "abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: kHeight(20.0).h),
            const StepsField(),
            SizedBox(height: kHeight(20.0).h),
            TitleOfPage("Создание заявки", kWidth(88.0).w),
            SizedBox(height: kHeight(20.0).h),
            _headlineText(context),
            SizedBox(height: kHeight(20.0).h),
            _cardNumber(context),
            _cardExpirationDate(context),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      child: buildGridView()
                      // Center(
                      //   child: __ == 0
                      //       ? const Icon(
                      //           Icons.add,
                      //           size: 40.0,
                      //         )
                      //       : SvgPicture.asset(
                      //           "assets/icons/camera.svg",
                      //           height: kHeight(20.0).h,
                      //           width: kWidth(26.0).w,
                      //           fit: BoxFit.cover,
                      //         ),
                      // ),
                      ),
                  onTap: loadAssets,
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
    );
  }

  InputField _cardExpirationDate(BuildContext context) {
    return InputField(
      context.watch<AddProposalProvider>().summThings,
      "Сумма",
      TextInputType.number,
      (v) {
        if (v!.length < 3) return "";
        return null;
      },
      10,
      "* * * * * * * * * * * * * * *",
      "* * * * * * * * * * * * * * *",
      {"*": RegExp(r'[0-9]')},
    );
  }

  InputField _cardNumber(BuildContext context) {
    return InputField(
      context.watch<AddProposalProvider>().namingThings,
      "Наименование товара",
      TextInputType.text,
      (v) {
        if (v!.length < 2) return "";
        return null;
      },
      32,
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
          context.read<StepsProvider>().incrementStep();
        },
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
