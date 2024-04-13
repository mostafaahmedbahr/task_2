class UserModel
{
  String? name;
  String? phone;
  String? uid;
  String? email;
  String? groupCode;


  UserModel({
    required this.uid,
    required this.phone,
    required this.email,
    required this.name,
    required this.groupCode,

  });

  UserModel.fromJson(Map<String , dynamic> json)
  {
    email = json["email"];
    name = json["name"];
    uid = json["uid"];
    phone = json["phone"];
    groupCode = json["groupCode"];


  }

  Map<String , dynamic> toMap()
  {
    return {
      "name":name,
      "email":email,
      "uid":uid,
      "phone" : phone,
      "groupCode" : groupCode,

    };
  }
}