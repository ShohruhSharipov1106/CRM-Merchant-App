import 'dart:async';

import 'package:crm_merchant/constants/exports.dart';
import 'package:crm_merchant/screens/auth/sign_up_page.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  SequenceAnimation? _sequenceAnimation;

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
          to: const Duration(seconds: 3),
          tag: 'heightSzb',
        )
        .addAnimatable(
          animatable: Tween(
            begin: kWidth(2755.7).w,
            end: kWidth(275.57).w,
          ),
          from: Duration.zero,
          to: const Duration(seconds: 3),
          tag: 'widthSzb',
        )
        .addAnimatable(
          animatable: Tween(
            begin: kHeight(241.13).h,
            end: kHeight(87.0).h,
          ),
          from: const Duration(seconds: 5),
          to: const Duration(seconds: 8),
          tag: 'heightSzb',
        )
        .addAnimatable(
          animatable: Tween(
            begin: kWidth(275.57).w,
            end: kWidth(95.71).w,
          ),
          from: const Duration(seconds: 5),
          to: const Duration(seconds: 8),
          tag: 'widthSzb',
        )
        .addAnimatable(
          animatable: Tween(
            begin: kHeight(382.47).h,
            end: kHeight(435.0).h,
          ),
          from: const Duration(seconds: 5),
          to: const Duration(seconds: 8),
          tag: 'positionSzbHeight',
        )
        .addAnimatable(
          animatable: Tween(
            begin: kWidth(76.43).w,
            end: kWidth(90.0).w,
          ),
          from: const Duration(seconds: 5),
          to: const Duration(seconds: 8),
          tag: 'positionSzbWidth',
        )
        .addAnimatable(
          animatable: Tween(
            begin: kHeight(427.0).h,
            end: kHeight(427.0).h,
          ),
          from: const Duration(seconds: 5),
          to: const Duration(seconds: 8),
          tag: 'positionTextHeight',
        )
        .addAnimatable(
          animatable: Tween(
            begin: -kWidth(150.0).w,
            end: kWidth(102.0).w,
          ),
          from: const Duration(seconds: 5),
          to: const Duration(seconds: 8),
          tag: 'positionTextWidth',
        )
        .animate(_animationController!);

    _animationController!.forward();

    Timer(const Duration(seconds: 10), () {
      GetStorage().write("splashDone", "splashDone");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const SignUpPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
