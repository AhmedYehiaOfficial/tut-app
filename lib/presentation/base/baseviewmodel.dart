abstract class BaseViewModel extends BaseViewModelInputes
    with BaseViewModelOutputs {
  //shred variable and function that will be be use throug any view model.

}

abstract class BaseViewModelInputes {
  void start(); //start view model job

  void dispose(); //will be call when view model dies
}

abstract class BaseViewModelOutputs {
  // will be implemented later
}
