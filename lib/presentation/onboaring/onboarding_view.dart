import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_adv/presentation/resources/color_manger.dart';
import 'package:flutter_adv/presentation/resources/values_manger.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../resources/assets_manger.dart';
import '../resources/constants.dart';
import '../resources/routes_manger.dart';
import '../resources/strings_manger.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final List<SliderObject> _list = _getSliderData();
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  List<SliderObject> _getSliderData() => [
        SliderObject(ImageAssets.onBoarding1, AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1),
        SliderObject(ImageAssets.onBoarding2, AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2),
        SliderObject(ImageAssets.onBoarding3, AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3),
        SliderObject(ImageAssets.onBoarding4, AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: AppSize.s0,
        backgroundColor: ColorManger.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManger.white,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        itemBuilder: (context, index) {
          return OnBoardingPage(_list[index]);
        },
        onPageChanged: (index) {
          _currentIndex = index;
        },
        itemCount: _list.length,
        controller: _pageController,
      ),
      bottomSheet: Container(
        color: ColorManger.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                },
                child: Text(AppStrings.skip,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ),
            _getBottomSheetWidget(),
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget() {
    return Container(
      color: ColorManger.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
              onTap: () {
                //go to previous
                _pageController.animateToPage(_getPreviousIndex(),
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
            ),
          ),

          //page controller
          Row(
            children: [
              for (int i = 0; i < _list.length; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, 0),
                )
            ],
          ),

          //right arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
              onTap: () {
                //go to Next
                _pageController.animateToPage(_getNextIndex(),
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
            ),
          ),
        ],
      ),
    );
  }

  int _getPreviousIndex() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  int _getNextIndex() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == -1) {
      nextIndex = _list.length - 1;
    }
    return nextIndex;
  }
}

Widget _getProperCircle(int index, int currentIndex) {
  if (index == currentIndex) {
    return SvgPicture.asset(ImageAssets.hollowCircleIc);
  } else {
    return SvgPicture.asset(ImageAssets.solidCircleIc);
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.title!,
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.subtitle!,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center),
        ),
        const SizedBox(height: AppMargin.m60),
        SvgPicture.asset(_sliderObject.image!),
      ],
    );
  }
}

class SliderObject {
  String? title;
  String? subtitle;
  String? image;

  SliderObject(this.image, this.title, this.subtitle);
}
