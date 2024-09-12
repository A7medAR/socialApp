abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates
{
  final String error;

  SocialGetUserErrorState(this.error);

}

class SocialGetAllUserSuccessState extends SocialStates{}

class SocialChangeIsGridState extends SocialStates{}

class SocialGetAllUserLoadingState extends SocialStates{}

class SocialGetAllUserErrorState extends SocialStates
{
  final String error;

  SocialGetAllUserErrorState(this.error);

}

class SocialGetMessagesSuccessState extends SocialStates{}

class SocialGetMessagesErrorState extends SocialStates
{
  final String error;

  SocialGetMessagesErrorState(this.error);

}

class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates
{
  final String error;

  SocialSendMessageErrorState(this.error);

}

class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates
{
  final String error;

  SocialLikePostErrorState(this.error);

}

class SocialCommentPostSuccessState extends SocialStates{}

class SocialCommentPostErrorState extends SocialStates
{
  final String error;

  SocialCommentPostErrorState(this.error);

}
class SocialChangeBottomNavState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialUploadProfileImagePickedSuccessState extends SocialStates{}

class SocialUploadProfileImagePickedErrorState extends SocialStates{

  String error;

  SocialUploadProfileImagePickedErrorState(this.error);

}

class SocialUploadCoverImagePickedSuccessState extends SocialStates{}

class SocialUploadCoverImagePickedErrorState extends SocialStates{

  String error;

  SocialUploadCoverImagePickedErrorState(this.error);
}

class SocialUserUpdateErrorState extends SocialStates{}

class SocialUserUpdateLoadingState extends SocialStates{}

class SocialGetProfilePostLoadingState extends SocialStates{}

class SocialPostUpdateLoadingState extends SocialStates{}

class SocialPostUpdateSuccessState extends SocialStates{}

class SocialPostUpdateErrorState extends SocialStates{}

//create post
class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}

class SocialRemovePostImagePickedState extends SocialStates{}

class SocialGetPostSuccessState extends SocialStates{}

class SocialDeletePostSuccessState extends SocialStates{}

class SocialDeletePostErrorState extends SocialStates{}

class SocialGetProfilePostSuccessState extends SocialStates{}

class SocialGetProfilePostErrorState extends SocialStates{
  String error;

  SocialGetProfilePostErrorState(this.error);
}

class SocialGetLikeSuccessState extends SocialStates{}

class SocialGetPostLoadingState extends SocialStates{}

class SocialGetPostErrorState extends SocialStates
{
  final String error;

  SocialGetPostErrorState(this.error);

}

class SocialGetLikeErrorState extends SocialStates
{
  final String error;

  SocialGetLikeErrorState(this.error);

}

class SocialGetCommentSuccessState extends SocialStates{}

class SocialGetCommentLoadingState extends SocialStates{}

class SocialGetCommentErrorState extends SocialStates
{
  final String error;

  SocialGetCommentErrorState(this.error);

}

class SocialCreateCommentLoadingState extends SocialStates{}

class SocialGetCommentCountsSuccessState extends SocialStates{}

class SocialGetCommentCountsErrorState extends SocialStates
{
  final String error;

  SocialGetCommentCountsErrorState(this.error);

}

class SocialDeleteCommentPostSuccessState extends SocialStates{}

class SocialDeleteCommentPostErrorState extends SocialStates{
  final String error;
  SocialDeleteCommentPostErrorState(this.error);
}

class SocialCommentUpdateSuccessState extends SocialStates{}

class SocialCommentUpdateErrorState extends SocialStates{}
