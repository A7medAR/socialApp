
abstract class SocialLoginStates {}

class SocialLoginInitialState extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates{}

class SocialLoginSuccessState extends SocialLoginStates{
  final String uId;

  SocialLoginSuccessState(this.uId);
}

class SocialChangePasswordVisibilityState extends SocialLoginStates{}


class SocialLoginErrorState extends SocialLoginStates
{

  final String error;

  SocialLoginErrorState(this.error);

}
