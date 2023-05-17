abstract class SocialStates {}

class SocialInitialState extends SocialStates{}

class SociaGetUserLoadingState extends SocialStates{}

class SociaGetUserSuccessState extends SocialStates{}

class SociaGetUserErrorState extends SocialStates{
  final String error;
  SociaGetUserErrorState(this.error);
}
class SocialChangeBottomNavBarState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SociallProfileImagePickedErrorState extends SocialStates{}

class SociallCoverImagePickedSuccessState extends SocialStates{}

class SociallCoverImagePickedErrorState extends SocialStates{}

class SociallProfileImageUploadErrorState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}

class SociallCoverImageUploadErrorState extends SocialStates{}

class SocialUpdateLoadingState extends SocialStates{}
// posts
class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}

class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialGetPostSuccessState extends SocialStates{}

class SocialGetPostErrorState extends SocialStates{}

class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates{}

class SocialLikePostLoadingState extends SocialStates{}

//get all users
class SociaGetAllUserLoadingState extends SocialStates{}

class SociaGetAllUserSuccessState extends SocialStates{}

class SociaGetAllUserErrorState extends SocialStates{}

//chats
class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{}

class SocialGetMessageSuccessState extends SocialStates{}


