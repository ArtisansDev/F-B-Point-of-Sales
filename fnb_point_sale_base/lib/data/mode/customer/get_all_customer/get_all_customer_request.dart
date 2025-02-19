/// RestaurantIDF : "0D74BFA1-AF7D-4182-835B-B815C2972591"
/// RowsPerPage : 0
/// PageNumber : 1

class GetAllCustomerRequest {
  GetAllCustomerRequest({
    String? restaurantIDF,
    String? searchValue,
    int? rowsPerPage,
    int? pageNumber,}) {
    _restaurantIDF = restaurantIDF;
    _rowsPerPage = rowsPerPage;
    _pageNumber = pageNumber;
    _searchValue = searchValue;
  }

  GetAllCustomerRequest.fromJson(dynamic json) {
    _restaurantIDF = json['RestaurantIDF'];
    _rowsPerPage = json['RowsPerPage'];
    _pageNumber = json['PageNumber'];
    _searchValue = json['SearchValue'];
  }

  String? _restaurantIDF;
  String? _searchValue;
  int? _rowsPerPage;
  int? _pageNumber;

  String? get restaurantIDF => _restaurantIDF;

  int? get rowsPerPage => _rowsPerPage;

  int? get pageNumber => _pageNumber;

  String? get searchValue => _searchValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantIDF'] = _restaurantIDF;
    map['RowsPerPage'] = _rowsPerPage;
    map['PageNumber'] = _pageNumber;
    if (_searchValue != null) {
      map['SearchValue'] = _searchValue;
    } else {
      map['SearchValue'] = '';
    }
    return map;
  }

}