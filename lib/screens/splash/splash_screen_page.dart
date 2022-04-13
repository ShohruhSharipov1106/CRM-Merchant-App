import 'dart:async';

import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/auth/sign_up_page.dart';
import 'package:crm_merchant/screens/home/home_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  SequenceAnimation? _sequenceAnimation;
  int firstAnimate = 1;
  int secondAnimateBegin = 1200;
  int secondAnimateEnd = 2000;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    );
    _animationController!.addListener(() {
      setState(() {});
    });

    _sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
          animatable: Tween(
            begin: kHeight(2411.3).h,
            end: kHeight(241.13).h,
          ),
          from: Duration.zero,
          to: Duration(seconds: firstAnimate),
          tag: 'heightSzb',
        )
        .addAnimatable(
          animatable: Tween(
            begin: kWidth(2755.7).w,
            end: kWidth(275.57).w,
          ),
          from: Duration.zero,
          to: Duration(seconds: firstAnimate),
          tag: 'widthSzb',
        )
        .addAnimatable(
          animatable: Tween(
            begin: kHeight(241.13).h,
            end: kHeight(87.0).h,
          ),
          from: Duration(milliseconds: secondAnimateBegin),
          to: Duration(milliseconds: secondAnimateEnd),
          tag: 'heightSzb',
        )
        .addAnimatable(
          animatable: Tween(
            begin: kWidth(275.57).w,
            end: kWidth(95.71).w,
          ),
          from: Duration(milliseconds: secondAnimateBegin),
          to: Duration(milliseconds: secondAnimateEnd),
          tag: 'widthSzb',
        )
        .addAnimatable(
          animatable: Tween(
            begin: kHeight(382.47).h,
            end: kHeight(435.0).h,
          ),
          from: Duration(milliseconds: secondAnimateBegin),
          to: Duration(milliseconds: secondAnimateEnd),
          tag: 'positionSzbHeight',
        )
        .addAnimatable(
          animatable: Tween(
            begin: kWidth(76.43).w,
            end: kWidth(90.0).w,
          ),
          from: Duration(milliseconds: secondAnimateBegin),
          to: Duration(milliseconds: secondAnimateEnd),
          tag: 'positionSzbWidth',
        )
        .addAnimatable(
          animatable: Tween(
            begin: kHeight(427.0).h,
            end: kHeight(427.0).h,
          ),
          from: Duration(milliseconds: secondAnimateBegin),
          to: Duration(milliseconds: secondAnimateEnd),
          tag: 'positionTextHeight',
        )
        .addAnimatable(
          animatable: Tween(
            begin: -kWidth(150.0).w,
            end: kWidth(102.0).w,
          ),
          from: Duration(milliseconds: secondAnimateBegin),
          to: Duration(milliseconds: secondAnimateEnd),
          tag: 'positionTextWidth',
        )
        .animate(_animationController!);

    _animationController!.forward();

    Timer(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => GetStorage().read("signUpDone") == "signUpDone"
              ? const HomePage()
              : const SignUpPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: 100.h,
                width: 100.w,
              ),
            ),
            Positioned(
              child: Text(
                "Credit\nExpress",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 36.0),
              ),
              left: _sequenceAnimation!["positionTextWidth"].value,
              bottom: _sequenceAnimation!["positionTextHeight"].value,
            ),
            Positioned(
              child: SvgPicture.asset(
                "assets/icons/main_icon.svg",
                fit: BoxFit.cover,
                height: _sequenceAnimation!["heightSzb"].value,
                width: _sequenceAnimation!["widthSzb"].value,
              ),
              right: _sequenceAnimation!["positionSzbWidth"].value,
              bottom: _sequenceAnimation!["positionSzbHeight"].value,
            ),
          ],
        ),
      ),
    );
  }
}
