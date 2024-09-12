class CommentModel
{
  String? name;
  String? uId;
  String? image;
  String? text;
  String? dateTime;
  String? commentId;

  CommentModel({
    this.name,
    this.text,
    this.uId,
    this.image,
    this.dateTime,
    this.commentId,

  });

  CommentModel.fromJson(Map<String,dynamic>json)
  {
    uId=json['uId'];
    text=json['text'];
    image=json['image'];
    name=json['name'];
    dateTime=json['dateTime'];
    commentId=json['commentId'];


  }

  Map<String,dynamic> toMap()
  {
    return
        {
          'name':name,
          'uId':uId,
          'text':text,
          'image':image,
          'dateTime':dateTime,
          'commentId':commentId,

        };
  }
}