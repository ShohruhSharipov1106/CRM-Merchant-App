import 'dart:io';

import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/add_proposal/full_personal_information_page.dart';

class PassportIdentificationPage extends StatefulWidget {
  const PassportIdentificationPage({Key? key}) : super(key: key);

  @override
  State<PassportIdentificationPage> createState() =>
      _PassportIdentificationPageState();
}

class _PassportIdentificationPageState
    extends State<PassportIdentificationPage> {
  File? passportImage;
  File? registrationImage;
  File? selfieImage;
  Future getImage(int i) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);

      setState(() {
        switch (i) {
          case 1:
            passportImage = imageTemporary;
            break;
          case 2:
            registrationImage = imageTemporary;
            break;
          case 3:
            selfieImage = imageTemporary;
            break;
          default:
        }
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

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
        leadingWidth: 13.0,
        title: LocaleText(
          "identification_by_passport",
          style: Theme.of(context).textTheme.headlineLarge,
          overflow: TextOverflow.visible,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _imageTitle(context, "upload_passport"),
              _imageContainer(passportImage, 1),
              _imageTitle(context, "upload_address"),
              _imageContainer(registrationImage, 2),
              _imageTitle(context, "upload_selfie"),
              _imageContainer(selfieImage, 3),
              Padding(
                padding: EdgeInsets.only(
                  top: kHeight(50.0).h,
                  left: kWidth(78.0).w,
                  bottom:  kHeight(50.0).h,
                ),
                child: MainButton(context, "continue", () {
                  Get.to(const FullPersonalInformationPage());
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _imageTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: kMainPadding,
        top: kHeight(20.0).h,
        bottom: kHeight(15.0).h,
      ),
      child: LocaleText(
        title,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  InkWell _imageContainer(File? imageFile, int index) {
    return InkWell(
        child: Container(
          height: kHeight(367).h,
          width: kWidth(368.0).w,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: kWhiteColor,
            border: Border.all(
              color: kBlackTextColor,
              width: 1.0,
            ),
          ),
          alignment: Alignment.center,
          child: imageFile == null
              ? const Icon(
                  Icons.add,
                  size: 72.0,
                  color: kBlackTextColor,
                )
              : Image.file(
                  imageFile,
                  height: kHeight(367).h,
                  width: kWidth(368.0).w,
                  fit: BoxFit.cover,
                ),
        ),
        onTap: () {
          getImage(index);
        });
  }
}
