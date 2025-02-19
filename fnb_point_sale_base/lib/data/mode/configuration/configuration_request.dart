class ConfigurationRequest {
  ConfigurationRequest({
    String? accessToken,
    String? counterIDP,
  }) {
    _accessToken = accessToken;
    _counterIDP = counterIDP;
  }

  ConfigurationRequest.fromJson(dynamic json) {
    _accessToken = json['AccessToken'];
    _counterIDP = json['CounterIDP'];
  }

  String? _accessToken;
  String? _counterIDP;

  String? get accessToken => _accessToken;
  String? get counterIDP => _counterIDP;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AccessToken'] = _accessToken;
    if(_counterIDP!=null){
      map['CounterIDP'] = _counterIDP;
    }
    return map;
  }
}
