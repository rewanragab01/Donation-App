part of 'users_cubit.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class DonorsUserfetched extends UsersState {
  final Map<String, dynamic> donors;
  DonorsUserfetched({required this.donors});
}

final class Donorsloading extends UsersState {}

final class DonorsFetchfailure extends UsersState {
  final String failuremessage;
  DonorsFetchfailure({required this.failuremessage});
}

final class UpdatedToDonor extends UsersState {}

final class UpdatedToPatient extends UsersState {}

final class UpdatedToDonorFailed extends UsersState {
  final String failedmessage;
  UpdatedToDonorFailed({required this.failedmessage});
}

class RoleFetched extends UsersState {
  final String role;
  RoleFetched({required this.role});
}

class RoleFetchedFailed extends UsersState {
  final String failedemessage;
  RoleFetchedFailed({required this.failedemessage});
}

final class UpdatedToPatientFailed extends UsersState {
  final String failedmessage;
  UpdatedToPatientFailed({required this.failedmessage});
}
