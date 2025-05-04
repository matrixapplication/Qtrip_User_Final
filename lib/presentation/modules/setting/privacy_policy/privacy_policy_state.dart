part of 'privacy_policy_cubit.dart';

@immutable
abstract class PrivacyPolicyState {}

class PrivacyPolicyInitial extends PrivacyPolicyState {}
class PrivacyPolicyLoading extends PrivacyPolicyState {}


class PrivacyPolicyGotSuccessfully extends PrivacyPolicyState {
  final String _privacyPolicy;

  String get privacyPolicy => _privacyPolicy;

  PrivacyPolicyGotSuccessfully({
    required String privacyPolicy,
  }) : _privacyPolicy = privacyPolicy;
}