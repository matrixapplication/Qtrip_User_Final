part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileLoading2 extends ProfileState {}
class ProfileError2 extends ProfileState {}
class ProfileSuccess2 extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileDataSuccessfully extends ProfileState {
 final UserEntity? _entity  ;

  ProfileDataSuccessfully({
    required UserEntity? entity,
  }) : _entity = entity;

  UserEntity? get entity => _entity;
}
class ProfileUpdatingImage extends ProfileState {}
class ProfileSuccessfully extends ProfileState {}
