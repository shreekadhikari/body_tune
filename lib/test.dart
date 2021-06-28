class TestInfo {
  String id = '';
  String test = '';
  String date = '';

  TestInfo(this.id, this.test, this.date);

  Map<dynamic, String> toJson() => {'id': id, 'test': test, 'date': date};

  TestInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        test = json['test'],
        date = json['date'];

  @override
  String toString() {
    return 'TestInfo{id: $id, test: $test, date: $date}';
  }
}
