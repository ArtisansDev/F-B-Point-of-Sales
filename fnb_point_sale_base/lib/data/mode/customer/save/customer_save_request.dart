/// CustomerIDP : "00000000-0000-0000-0000-000000000000"
/// Name : "John Doe"
/// PhoneCountryCode : "+1"
/// PhoneNumber : "1234567890"
/// Email : "john.doe@example.com"
/// Address : "123 Main St, City, Country"
/// DateOfBirth : "1990-01-01T00:00:00"
/// UserIDF : "ab69c7c3-0b14-4361-a987-f7e2d28a505e"
/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"

class CustomerSaveRequest {
  CustomerSaveRequest({
      String? customerIDP, 
      String? name, 
      String? phoneCountryCode, 
      String? phoneNumber, 
      String? email, 
      String? address, 
      String? dateOfBirth, 
      String? userIDF, 
      String? restaurantIDF,}){
    _customerIDP = customerIDP;
    _name = name;
    _phoneCountryCode = phoneCountryCode;
    _phoneNumber = phoneNumber;
    _email = email;
    _address = address;
    _dateOfBirth = dateOfBirth;
    _userIDF = userIDF;
    _restaurantIDF = restaurantIDF;
}

  CustomerSaveRequest.fromJson(dynamic json) {
    _customerIDP = json['CustomerIDP'];
    _name = json['Name'];
    _phoneCountryCode = json['PhoneCountryCode'];
    _phoneNumber = json['PhoneNumber'];
    _email = json['Email'];
    _address = json['Address'];
    _dateOfBirth = json['DateOfBirth'];
    _userIDF = json['UserIDF'];
    _restaurantIDF = json['RestaurantIDF'];
  }
  String? _customerIDP;
  String? _name;
  String? _phoneCountryCode;
  String? _phoneNumber;
  String? _email;
  String? _address;
  String? _dateOfBirth;
  String? _userIDF;
  String? _restaurantIDF;

  String? get customerIDP => _customerIDP;
  String? get name => _name;
  String? get phoneCountryCode => _phoneCountryCode;
  String? get phoneNumber => _phoneNumber;
  String? get email => _email;
  String? get address => _address;
  String? get dateOfBirth => _dateOfBirth;
  String? get userIDF => _userIDF;
  String? get restaurantIDF => _restaurantIDF;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CustomerIDP'] = _customerIDP;
    map['Name'] = _name;
    map['PhoneCountryCode'] = _phoneCountryCode;
    map['PhoneNumber'] = _phoneNumber;
    map['Email'] = _email;
    map['Address'] = _address;
    map['DateOfBirth'] = _dateOfBirth;
    map['UserIDF'] = _userIDF;
    map['RestaurantIDF'] = _restaurantIDF;
    return map;
  }

}