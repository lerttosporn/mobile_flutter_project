import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:myproject/themes/colors.dart';
import 'package:myproject/utils/app_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.login);
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 19.0,
      color: primaryText,
      fontFamily: 'NotoSansThai',
    );

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: primaryText,
        fontFamily: 'NotoSansThai',
      ),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: icons,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: icons,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      pages: [
        PageViewModel(
          title: "Fractional shares",
          body: "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('slide1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Learn as you go",
          body: "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('slide2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kids and teens",
          body: "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: _buildImage('slide3.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      showBackButton: false,
      skip: const Text(
        'ข้าม',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: primary,
          fontFamily: 'NotoSansThai',
        ),
      ),
      next: const Icon(Icons.arrow_forward, color: primary),
      done: const Text(
        'เสร็จสิ้น',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: primary,
          fontFamily: 'NotoSansThai',
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: divider,
        activeSize: Size(22.0, 10.0),
        activeColor: primary,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: primaryText,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
