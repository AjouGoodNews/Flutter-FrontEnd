// ignore_for_file: constant_identifier_names

enum SignInMethod {
  GOOGLE(domain: 'google.com');

  final String domain;

  const SignInMethod({
    required this.domain,
  });
}