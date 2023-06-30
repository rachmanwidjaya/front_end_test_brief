import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel.dummyUser()
      : super(
          displayName: 'Wilson Franci',
          phoneNumber: '+6285123456789',
          photoURL: 'https://i.postimg.cc/NGkV3PtT/Image.png',
          accessToken:
              "[EXAMPLE_ACCES_TOKEN_FROM_SERVER...PLEASE_LOG_OUT_TO_CLEAR_THIS_TOKEN]",
        );
}
