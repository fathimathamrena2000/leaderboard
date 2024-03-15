import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String region;
  final List<Leader> leaders;

  UserModel({
    required this.region,
    required this.leaders,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        region: json["region"],
        leaders:
            List<Leader>.from(json["leaders"].map((x) => Leader.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "region": region,
        "leaders": List<dynamic>.from(leaders.map((x) => x.toMap())),
      };
}

class Leader {
  final String userId;
  final String name;
  final String profilePic;
  final int points;

  Leader({
    required this.userId,
    required this.name,
    required this.profilePic,
    required this.points,
  });

  factory Leader.fromJson(Map<String, dynamic> json) => Leader(
        userId: json["userId"],
        name: json["name"],
        profilePic: json["profilePic"],
        points: json["points"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "name": name,
        "profilePic": profilePic,
        "points": points,
      };
}
