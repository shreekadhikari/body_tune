class UserInfo {
  String _firstName = '';
  String _dob = '';
  String _gender = '';
  String _smoke = '';
  String _height = '';
  String _activity = '';

  UserInfo(this._firstName, this._dob, this._gender, this._smoke, this._height);

  Map<dynamic, String> toJson() => {
        'fname': _firstName,
        'dob': _dob,
        'gender': _gender,
        'smoke': _smoke,
        'height': _height,
        'activity': _activity
      };

  UserInfo.fromJson(Map<String, dynamic> json)
      : _firstName = json['fname'],
        _dob = json['dob'],
        _gender = json['gender'],
        _smoke = json['smoke'],
        _height = json['height'],
        _activity = json['activity'];

  String get firstName => _firstName;

  String get activity => _activity;

  String get height => _height;

  String get smoke => _smoke;

  String get gender => _gender;

  String get dob => _dob;

  set firstName(String value) {
    _firstName = value;
  }

  set dob(String value) {
    _dob = value;
  }

  set gender(String value) {
    _gender = value;
  }

  set smoke(String value) {
    _smoke = value;
  }

  set height(String value) {
    _height = value;
  }

  set activity(String value) {
    _activity = value;
  }

  setActivity(String activity){
    _activity = (activity);
  }

  @override
  String toString() {
    return 'UserInfo{_firstName: $_firstName, _dob: $_dob, _gender: $_gender, _smoke: $_smoke, _height: $_height, _activity: $_activity}';
  }
}
