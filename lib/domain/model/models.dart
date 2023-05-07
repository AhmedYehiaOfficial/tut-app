//onboarding Models
class SliderObject {
  String? title;
  String? subtitle;
  String? image;

  SliderObject(this.image, this.title, this.subtitle);
}
class SliderViewObject {
  SliderObject sliderObject;
  int numberOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.currentIndex, this.numberOfSlides);
}

// login models
class Customer{
  String id;
  String name;
  int numOfNotifications;
  Customer(this.id, this.name, this.numOfNotifications);
}
class Contacts{
  String phone;
  String email;
  int link;
  Contacts(this.phone, this.email, this.link);
}

class Authentication{
  //any data type not primitive should be null (?)
  Customer? customer;
  Contacts? contacts;
  Authentication(this.customer, this.contacts);
}

