/// access_token : "eyJhbGciOiJIUzI1NiIsImtpZCI6Ik40UU5IL2pWTGFOMjkxY0UiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2xkY2xkbHlnY2x3eGVkeWdqdGVkLnN1cGFiYXNlLmNvL2F1dGgvdjEiLCJzdWIiOiJhZGQ1ZTI4NC05YTIyLTQ0NjktYmYyYS1iMjA4ODNkNjZhMTkiLCJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNzI5MzIzMDAzLCJpYXQiOjE3MjkzMTk0MDMsImVtYWlsIjoiYmFsYWppa2FubmE0NTZAZ21haWwuY29tIiwicGhvbmUiOiIiLCJhcHBfbWV0YWRhdGEiOnsicHJvdmlkZXIiOiJlbWFpbCIsInByb3ZpZGVycyI6WyJlbWFpbCJdfSwidXNlcl9tZXRhZGF0YSI6eyJlbWFpbCI6ImJhbGFqaWthbm5hNDU2QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwicGhvbmVfdmVyaWZpZWQiOmZhbHNlLCJzdWIiOiJhZGQ1ZTI4NC05YTIyLTQ0NjktYmYyYS1iMjA4ODNkNjZhMTkifSwicm9sZSI6ImF1dGhlbnRpY2F0ZWQiLCJhYWwiOiJhYWwxIiwiYW1yIjpbeyJtZXRob2QiOiJwYXNzd29yZCIsInRpbWVzdGFtcCI6MTcyOTMxOTQwM31dLCJzZXNzaW9uX2lkIjoiMTNjNjBhMDQtOWE2NC00NWI5LWIzZTgtMDYzZWQxZjdmN2I0IiwiaXNfYW5vbnltb3VzIjpmYWxzZX0.NJFvfBs4-6yTCQSKlBoZOSa24Fm7WFe8GMOzQf7t3gk"
/// token_type : "bearer"
/// expires_in : 3600
/// expires_at : 1729323003
/// refresh_token : "T75G0uEhUGdR8VyTF_eoBA"
/// user : {"id":"add5e284-9a22-4469-bf2a-b20883d66a19","aud":"authenticated","role":"authenticated","email":"balajikanna456@gmail.com","email_confirmed_at":"2024-10-18T14:44:45.767576Z","phone":"","confirmation_sent_at":"2024-10-18T14:44:25.28228Z","confirmed_at":"2024-10-18T14:44:45.767576Z","last_sign_in_at":"2024-10-19T06:30:03.006621707Z","app_metadata":{"provider":"email","providers":["email"]},"user_metadata":{"email":"balajikanna456@gmail.com","email_verified":false,"phone_verified":false,"sub":"add5e284-9a22-4469-bf2a-b20883d66a19"},"identities":[{"identity_id":"d2349de3-8b7e-44c1-b1d9-b8a3e7166920","id":"add5e284-9a22-4469-bf2a-b20883d66a19","user_id":"add5e284-9a22-4469-bf2a-b20883d66a19","identity_data":{"email":"balajikanna456@gmail.com","email_verified":false,"phone_verified":false,"sub":"add5e284-9a22-4469-bf2a-b20883d66a19"},"provider":"email","last_sign_in_at":"2024-10-18T14:44:25.278574Z","created_at":"2024-10-18T14:44:25.278628Z","updated_at":"2024-10-18T14:44:25.278628Z","email":"balajikanna456@gmail.com"}],"created_at":"2024-10-18T14:44:25.27568Z","updated_at":"2024-10-19T06:30:03.012277Z","is_anonymous":false}

class LoginResponse {
  LoginResponse({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.expiresAt,
    this.refreshToken,
    this.user,});

  LoginResponse.fromJson(dynamic json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    expiresAt = json['expires_at'];
    refreshToken = json['refresh_token'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  int? expiresAt;
  String? refreshToken;
  UserData? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = accessToken;
    map['token_type'] = tokenType;
    map['expires_in'] = expiresIn;
    map['expires_at'] = expiresAt;
    map['refresh_token'] = refreshToken;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

/// id : "add5e284-9a22-4469-bf2a-b20883d66a19"
/// aud : "authenticated"
/// role : "authenticated"
/// email : "balajikanna456@gmail.com"
/// email_confirmed_at : "2024-10-18T14:44:45.767576Z"
/// phone : ""
/// confirmation_sent_at : "2024-10-18T14:44:25.28228Z"
/// confirmed_at : "2024-10-18T14:44:45.767576Z"
/// last_sign_in_at : "2024-10-19T06:30:03.006621707Z"
/// app_metadata : {"provider":"email","providers":["email"]}
/// user_metadata : {"email":"balajikanna456@gmail.com","email_verified":false,"phone_verified":false,"sub":"add5e284-9a22-4469-bf2a-b20883d66a19"}
/// identities : [{"identity_id":"d2349de3-8b7e-44c1-b1d9-b8a3e7166920","id":"add5e284-9a22-4469-bf2a-b20883d66a19","user_id":"add5e284-9a22-4469-bf2a-b20883d66a19","identity_data":{"email":"balajikanna456@gmail.com","email_verified":false,"phone_verified":false,"sub":"add5e284-9a22-4469-bf2a-b20883d66a19"},"provider":"email","last_sign_in_at":"2024-10-18T14:44:25.278574Z","created_at":"2024-10-18T14:44:25.278628Z","updated_at":"2024-10-18T14:44:25.278628Z","email":"balajikanna456@gmail.com"}]
/// created_at : "2024-10-18T14:44:25.27568Z"
/// updated_at : "2024-10-19T06:30:03.012277Z"
/// is_anonymous : false

class UserData {
  UserData({
    this.id,
    this.aud,
    this.role,
    this.email,
    this.emailConfirmedAt,
    this.phone,
    this.confirmationSentAt,
    this.confirmedAt,
    this.lastSignInAt,
    this.appMetadata,
    this.userMetadata,
    this.identities,
    this.createdAt,
    this.updatedAt,
    this.isAnonymous,});

  UserData.fromJson(dynamic json) {
    id = json['id'];
    aud = json['aud'];
    role = json['role'];
    email = json['email'];
    emailConfirmedAt = json['email_confirmed_at'];
    phone = json['phone'];
    confirmationSentAt = json['confirmation_sent_at'];
    confirmedAt = json['confirmed_at'];
    lastSignInAt = json['last_sign_in_at'];
    appMetadata = json['app_metadata'] != null ? AppMetadata.fromJson(json['app_metadata']) : null;
    userMetadata = json['user_metadata'] != null ? UserMetadata.fromJson(json['user_metadata']) : null;
    if (json['identities'] != null) {
      identities = [];
      json['identities'].forEach((v) {
        identities?.add(Identities.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAnonymous = json['is_anonymous'];
  }
  String? id;
  String? aud;
  String? role;
  String? email;
  String? emailConfirmedAt;
  String? phone;
  String? confirmationSentAt;
  String? confirmedAt;
  String? lastSignInAt;
  AppMetadata? appMetadata;
  UserMetadata? userMetadata;
  List<Identities>? identities;
  String? createdAt;
  String? updatedAt;
  bool? isAnonymous;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['aud'] = aud;
    map['role'] = role;
    map['email'] = email;
    map['email_confirmed_at'] = emailConfirmedAt;
    map['phone'] = phone;
    map['confirmation_sent_at'] = confirmationSentAt;
    map['confirmed_at'] = confirmedAt;
    map['last_sign_in_at'] = lastSignInAt;
    if (appMetadata != null) {
      map['app_metadata'] = appMetadata?.toJson();
    }
    if (userMetadata != null) {
      map['user_metadata'] = userMetadata?.toJson();
    }
    if (identities != null) {
      map['identities'] = identities?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_anonymous'] = isAnonymous;
    return map;
  }

}

/// identity_id : "d2349de3-8b7e-44c1-b1d9-b8a3e7166920"
/// id : "add5e284-9a22-4469-bf2a-b20883d66a19"
/// user_id : "add5e284-9a22-4469-bf2a-b20883d66a19"
/// identity_data : {"email":"balajikanna456@gmail.com","email_verified":false,"phone_verified":false,"sub":"add5e284-9a22-4469-bf2a-b20883d66a19"}
/// provider : "email"
/// last_sign_in_at : "2024-10-18T14:44:25.278574Z"
/// created_at : "2024-10-18T14:44:25.278628Z"
/// updated_at : "2024-10-18T14:44:25.278628Z"
/// email : "balajikanna456@gmail.com"

class Identities {
  Identities({
    this.identityId,
    this.id,
    this.userId,
    this.identityData,
    this.provider,
    this.lastSignInAt,
    this.createdAt,
    this.updatedAt,
    this.email,});

  Identities.fromJson(dynamic json) {
    identityId = json['identity_id'];
    id = json['id'];
    userId = json['user_id'];
    identityData = json['identity_data'] != null ? IdentityData.fromJson(json['identity_data']) : null;
    provider = json['provider'];
    lastSignInAt = json['last_sign_in_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    email = json['email'];
  }
  String? identityId;
  String? id;
  String? userId;
  IdentityData? identityData;
  String? provider;
  String? lastSignInAt;
  String? createdAt;
  String? updatedAt;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['identity_id'] = identityId;
    map['id'] = id;
    map['user_id'] = userId;
    if (identityData != null) {
      map['identity_data'] = identityData?.toJson();
    }
    map['provider'] = provider;
    map['last_sign_in_at'] = lastSignInAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['email'] = email;
    return map;
  }

}

/// email : "balajikanna456@gmail.com"
/// email_verified : false
/// phone_verified : false
/// sub : "add5e284-9a22-4469-bf2a-b20883d66a19"

class IdentityData {
  IdentityData({
    this.email,
    this.emailVerified,
    this.phoneVerified,
    this.sub,});

  IdentityData.fromJson(dynamic json) {
    email = json['email'];
    emailVerified = json['email_verified'];
    phoneVerified = json['phone_verified'];
    sub = json['sub'];
  }
  String? email;
  bool? emailVerified;
  bool? phoneVerified;
  String? sub;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['email_verified'] = emailVerified;
    map['phone_verified'] = phoneVerified;
    map['sub'] = sub;
    return map;
  }

}

/// email : "balajikanna456@gmail.com"
/// email_verified : false
/// phone_verified : false
/// sub : "add5e284-9a22-4469-bf2a-b20883d66a19"

class UserMetadata {
  UserMetadata({
    this.email,
    this.emailVerified,
    this.phoneVerified,
    this.sub,});

  UserMetadata.fromJson(dynamic json) {
    email = json['email'];
    emailVerified = json['email_verified'];
    phoneVerified = json['phone_verified'];
    sub = json['sub'];
  }
  String? email;
  bool? emailVerified;
  bool? phoneVerified;
  String? sub;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['email_verified'] = emailVerified;
    map['phone_verified'] = phoneVerified;
    map['sub'] = sub;
    return map;
  }

}

/// provider : "email"
/// providers : ["email"]

class AppMetadata {
  AppMetadata({
    this.provider,
    this.providers,});

  AppMetadata.fromJson(dynamic json) {
    provider = json['provider'];
    providers = json['providers'] != null ? json['providers'].cast<String>() : [];
  }
  String? provider;
  List<String>? providers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['provider'] = provider;
    map['providers'] = providers;
    return map;
  }

}