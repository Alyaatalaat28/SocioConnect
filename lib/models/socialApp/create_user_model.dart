class SocialUserModel {

  String?name;
  String?phone;
  String?email;
  String?uId;
  String?image;
  String?cover;
  String?bio;
  bool? isEmailVerified;

  SocialUserModel({
    this.name,this.phone,this.email,this.uId,this.isEmailVerified,this.image,this.bio,this.cover,

});
  SocialUserModel.fromjson(Map<String,dynamic>json){
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    uId=json['uId'];
    isEmailVerified=json['isEmailVerified'];

  }
  Map <String,dynamic> toMap(){
    return {
      'name':name,
      'phone':phone,
      'email':email,
      'uId':uId,
      'image':image,
      'cover':cover,
      'isEmailVerified':isEmailVerified,
    };
  }
}