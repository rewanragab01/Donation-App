part of 'auth_cubit_cubit.dart';

@immutable
sealed class AuthCubitState {}

final class AuthCubitInitial extends AuthCubitState {}

final class AuthLoading extends AuthCubitState {}

final class AuthFailure extends AuthCubitState {
  final String errorMessage;
  AuthFailure({required this.errorMessage});
}

final class AuthSuccess extends AuthCubitState {}
