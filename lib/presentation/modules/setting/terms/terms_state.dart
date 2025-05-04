part of 'terms_cubit.dart';

@immutable
abstract class TermsState {}

class TermsInitial extends TermsState {}
class TermsLoading extends TermsState {}


class TermsGotSuccessfully extends TermsState {
  final String _terms;

  String get terms => _terms;

  TermsGotSuccessfully({
    required String terms,
  }) : _terms = terms;
}