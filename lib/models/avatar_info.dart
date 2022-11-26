import 'dart:convert';

List<AvatarInfo> avatarInfoFromJson(String str) => List<AvatarInfo>.from(json.decode(str).map((x) => AvatarInfo.fromJson(x)));

String avatarInfoToJson(List<AvatarInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AvatarInfo {
  AvatarInfo({
    required this.id,
    required this.name,
    required this.level,
    required this.bigUrl,
  });

  String id;
  String name;
  String level;
  String bigUrl;

  factory AvatarInfo.fromJson(Map<String, dynamic> json) => AvatarInfo(
    id: json["id"],
    name: json["name"],
    level: json["level"],
    bigUrl: json["bigUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "level": level,
    "bigUrl": bigUrl,
  };
}