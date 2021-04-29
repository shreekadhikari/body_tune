class UserInfo {
  String id = '';
  String firstName = '';
  String dob = '';
  String gender = '';
  String smoke = '';
  String height = '';
  String activity = '';

  UserInfo(
      this.id, this.firstName, this.dob, this.gender, this.smoke, this.height);

  Map<dynamic, String> toJson() => {
        'id': id,
        'fname': firstName,
        'dob': dob,
        'gender': gender,
        'smoke': smoke,
        'height': height,
        'activity': activity
      };

  UserInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['fname'],
        dob = json['dob'],
        gender = json['gender'],
        smoke = json['smoke'],
        height = json['height'],
        activity = json['activity'];

  @override
  String toString() {
    return 'UserInfo{id: $id, firstName: $firstName, dob: $dob, gender: $gender, smoke: $smoke, height: $height, activity: $activity}';
  }
}
