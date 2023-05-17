
abstract class SocialRegisterStates{}

class SocialRegisterInitialState extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}

class SocialRegisterSuccessState extends SocialRegisterStates{
}
class SocialRegisterErrorState extends SocialRegisterStates{
}
class SocialRegisterPasswordVisibilityState extends SocialRegisterStates{}

class SocialCreateUserSuccessState extends SocialRegisterStates{
}
class SocialCreateUserErrorState extends SocialRegisterStates{
}