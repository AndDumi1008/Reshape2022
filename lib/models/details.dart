import 'dart:convert';

Details detailsFromJson(String str) => Details.fromJson(json.decode(str));

String detailsToJson(Details data) => json.encode(data.toJson());

class Details {
  Details({
    required this.id,
    required this.name,
    required this.level,
    required this.bigUrl,
    required this.shortBio,
    required this.smallUrl,
    required this.backgroundUrl,
    required this.age,
    required this.netWorth,
    required this.wakeUpTime,
    required this.sleepTime,
    required this.mealsWeek,
    required this.trainingWeek,
  });

  String id;
  String name;
  String level;
  String bigUrl;
  String shortBio;
  String smallUrl;
  String backgroundUrl;
  String age;
  String netWorth;
  String wakeUpTime;
  String sleepTime;
  List<MealsWeek> mealsWeek;
  List<String> trainingWeek;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    id: json["id"],
    name: json["name"],
    level: json["level"],
    bigUrl: json["bigUrl"],
    shortBio: json["shortBio"],
    smallUrl: json["smallUrl"],
    backgroundUrl: json["backgroundUrl"],
    age: json["age"],
    netWorth: json["netWorth"],
    wakeUpTime: json["wakeUpTime"],
    sleepTime: json["sleepTime"],
    mealsWeek: List<MealsWeek>.from(json["mealsWeek"].map((x) => MealsWeek.fromJson(x))),
    trainingWeek: List<String>.from(json["trainingWeek"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "level": level,
    "bigUrl": bigUrl,
    "shortBio": shortBio,
    "smallUrl": smallUrl,
    "backgroundUrl": backgroundUrl,
    "age": age,
    "netWorth": netWorth,
    "wakeUpTime": wakeUpTime,
    "sleepTime": sleepTime,
    "mealsWeek": List<dynamic>.from(mealsWeek.map((x) => x.toJson())),
    "trainingWeek": List<dynamic>.from(trainingWeek.map((x) => x)),
  };
}

class MealsWeek {
  MealsWeek({
    required this.id,
    this.name,
    this.kcal,
    this.receiptUrl,
  });

  String id;
  String? name;
  String? kcal;
  String? receiptUrl;

  factory MealsWeek.fromJson(Map<String, dynamic> json) => MealsWeek(
    id: json["id"],
    name: json["name"],
    kcal: json["kcal"],
    receiptUrl: json["receiptUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "kcal": kcal,
    "receiptUrl": receiptUrl,
  };
}
