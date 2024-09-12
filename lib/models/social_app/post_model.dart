class PostModel
{
  String? postId;
  String? name;
  String? dateTime;
  String? uId;
  String? image;
  String? text;
  String? postImage;
  PostModel({
    this.postId,
    this.name,
    this.dateTime,
    this.text,
    this.uId,
    this.image,
    this.postImage,
});

  PostModel.fromJson(Map<String,dynamic>json)
  {
    postId = json['postId'];
    dateTime=json['dateTime'];
    uId=json['uId'];
    text=json['text'];
    image=json['image'];
    name=json['name'];
    postImage=json['postImage'];

  }

  Map<String,dynamic> toMap()
  {
    return
        {
          'postId': postId,
          'name':name,
          'dateTime':dateTime,
          'uId':uId,
          'text':text,
          'image':image,
          'postImage':postImage,

        };
  }
}