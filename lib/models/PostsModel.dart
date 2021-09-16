

class PostsModel{

   String _userDpUrl;
   String _userId;
  String _longitude;
  String _latitude;
  String _requiredService;
  String _requiredDescription;
  String _returnService;
  String _returnDescription;

   String get userDpUrl => _userDpUrl;

  set userDpUrl(String value) {
    _userDpUrl = value;
  }

   String get userId => _userId;

   String get returnDescription => _returnDescription;

  set returnDescription(String value) {
    _returnDescription = value;
  }

  String get returnService => _returnService;

  set returnService(String value) {
    _returnService = value;
  }

  String get requiredDescription => _requiredDescription;

  set requiredDescription(String value) {
    _requiredDescription = value;
  }

  String get requiredService => _requiredService;

  set requiredService(String value) {
    _requiredService = value;
  }

  String get latitude => _latitude;

  set latitude(String value) {
    _latitude = value;
  }

  String get longitude => _longitude;

  set longitude(String value) {
    _longitude = value;
  }

  set userId(String value) {
    _userId = value;
  }

   PostsModel();
}