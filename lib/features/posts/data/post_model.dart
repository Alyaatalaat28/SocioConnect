class PostModel {

  String?name;
  String?uId;
  String?image;
  String?dateTime;
  String?postImage;
   String?text;

  PostModel({
    this.name,this.text,this.dateTime,this.uId,this.postImage,this.image,

});
  PostModel.fromjson(Map<String,dynamic>json){
    name=json['name'];
    text=json['text'];
    dateTime=json['dateTime'];
    image=json['image'];
    postImage=json['postImage'];
    uId=json['uId'];
    

  }
  Map <String,dynamic> toMap(){
    return {
      'name':name,
      'text':text,
      'dateTime': dateTime,
      'uId':uId,
      'image':image,
      'postImage':postImage,
    };
  }
}