import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_adv/presentation/resources/color_manger.dart';
import 'package:flutter_adv/presentation/resources/values_manger.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../domain/models.dart';
import '../../resources/assets_manger.dart';
import '../../resources/constants.dart';
import '../../resources/routes_manger.dart';
import '../../resources/strings_manger.dart';
import '../viewmodel/onboarding_viewmodel.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();

  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
      stream: _viewModel.outputSliderViewObject,
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
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
            return OnBoardingPage(sliderViewObject.sliderObject);
          },
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
          itemCount: sliderViewObject.numberOfSlides,
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
              _getBottomSheetWidget(sliderViewObject),
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
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
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
            ),
          ),

          //page controller
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numberOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
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
                _pageController.animateToPage(_viewModel.goNext(),
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

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
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
