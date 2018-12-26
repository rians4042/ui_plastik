abstract class UserCache {
  String getCompanyId();
  void setCompanyId(String companyId);
  String getUserId();
  void setUserId(String userId);
}

class UserCacheImplementation implements UserCache {
  static final UserCacheImplementation _singleton =
      new UserCacheImplementation._internal();

  String companyId = '8f17a762-ddf8-472d-8a4a-c0e79924e269';
  String userId = '0f78335b-f693-42af-8a67-19503daecd4e';

  factory UserCacheImplementation() {
    return _singleton;
  }

  UserCacheImplementation._internal();

  @override
  String getCompanyId() {
    return companyId;
  }

  @override
  String getUserId() {
    return userId;
  }

  @override
  void setCompanyId(String companyId) {
    this.companyId = companyId;
  }

  @override
  void setUserId(String userId) {
    this.userId = userId;
  }
}
