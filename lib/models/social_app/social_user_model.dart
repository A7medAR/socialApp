class SocialUserModel
{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? bio;
  String? cover;
  bool? isEmailVerified;
  SocialUserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.bio,
    this.cover,
    this.image,
    this.isEmailVerified,
});

  SocialUserModel.fromJson(Map<String,dynamic>json)
  {
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    cover=json['cover'];
    bio=json['bio'];
    image=json['image'];
    name=json['name'];
    isEmailVerified=json['isEmailVerified'];

  }

  Map<String,dynamic> toMap()
  {
    return
        {
          'name':name,
          'phone':phone,
          'uId':uId,
          'cover':cover,
          'bio':bio,
          'image':image,
          'email':email,
          'isEmailVerified':isEmailVerified,

        };
  }
}