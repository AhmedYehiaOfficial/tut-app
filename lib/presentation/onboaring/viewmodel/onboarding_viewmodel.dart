import 'dart:async';

import '../../../domain/model/models.dart';
import '../../base/baseviewmodel.dart';
import '../../resources/assets_manger.dart';
import '../../resources/strings_manger.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //stream controller outputs
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  //OnBoarding view model inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
//view model start job
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == -1) {
      nextIndex = _list.length - 1;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //OnBoarding view model outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  //onboarding private func
  _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _currentIndex, _list.length));
  }

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
}

//orders that our view model will receive from view
abstract class OnBoardingViewModelInputs {
  int goNext(); //when user clicks on right arrow or swipe left
  int goPrevious(); //when user clicks on left arrow or swipe right
  void onPageChanged(int index);

  //stream controller inputs
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  //stream controller outputs
  Stream<SliderViewObject> get outputSliderViewObject;
}
