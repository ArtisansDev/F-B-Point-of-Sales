class ConfigurationRequest {
  ConfigurationRequest({
    String? accessToken,
  }) {
    _accessToken = accessToken;
  }

  ConfigurationRequest.fromJson(dynamic json) {
    _accessToken = json['AccessToken'];
  }

  String? _accessToken;

  String? get accessToken => _accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AccessToken'] = _accessToken;
    return map;
  }
}
