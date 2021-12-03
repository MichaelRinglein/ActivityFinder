class SingleActivity {
  final String activity;
  final String type;
  //final double price;
  final int participants;

  SingleActivity(
      {required this.activity,
      required this.type,
      //required this.price,
      required this.participants});

  factory SingleActivity.fromJson(Map<String, dynamic> json) {
    return SingleActivity(
      activity: json['activity'],
      type: json['type'],
      //price: json['price'].toDouble(),
      participants: json['participants'],
    );
  }
}
