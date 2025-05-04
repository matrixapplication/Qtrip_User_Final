part of 'about_us_cubit.dart';

@immutable
abstract class AboutUsState {}

class AboutUsInitial extends AboutUsState {}
class AboutUsLoading extends AboutUsState {}


class AboutUsGotSuccessfully extends AboutUsState {
  final String _aboutUs;

  String get aboutUs => _aboutUs;

  AboutUsGotSuccessfully({
    required String aboutUs,
  }) : _aboutUs = aboutUs;
}