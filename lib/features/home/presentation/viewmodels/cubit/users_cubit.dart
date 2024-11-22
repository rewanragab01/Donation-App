import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation/features/home/data/repos/donor_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final DonarRepository _donarRepository;
  UsersCubit(this._donarRepository) : super(UsersInitial());

  Future<Map<String, dynamic>> fetchdonors() async {
    Map<String, dynamic> Donors = {};
    emit(Donorsloading());
    try {
      Donors = await _donarRepository.getDonors();
      emit(DonorsUserfetched(donors: Donors));
      print(Donors);
    } catch (e) {
      emit(DonorsFetchfailure(failuremessage: e.toString()));
    }
    return Donors;
  }

  Future<void> updateUserRoleToDonor() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      if (uid != null) {
        await _donarRepository.updateUserRoleToDonor(uid);
        emit(UpdatedToDonor());
        fetchdonors();
      }
    } catch (e) {
      emit(UpdatedRoleFailed(failedmessage: e.toString()));
    }
  }

  Future<void> updateUserRoleTopatient() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      if (uid != null) {
        await _donarRepository.updateUserRoleToPatient(uid);
        emit(UpdatedToPatient());
        fetchdonors();
      }
    } catch (e) {
      emit(UpdatedRoleFailed(failedmessage: e.toString()));
    }
  }

  Future<void> fetchUserRole() async {
    emit(Donorsloading());
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _donarRepository.fetchUserRole(user.uid);

        if (userDoc.exists) {
          String role = userDoc['role'];
          emit(RoleFetched(role: role));
        }
      }
    } catch (e) {
      emit(RoleFetchedFailed(
          failedemessage: "Failed to fetch user role: ${e.toString()}"));
    }
  }

  Future<Map<String, dynamic>> searchDonors(String bloodType) async {
    Map<String, dynamic> donors = {};
    emit(Donorsloading());
    try {
      donors = await _donarRepository.searchDonorsByBloodType(bloodType);
      emit(DonorsSearchSuccess(donors: donors));
      print(donors);
    } catch (e) {
      emit(DonorsSearchFailure(failuremessage: e.toString()));
    }
    return donors;
  }

  // void streamDonors() {
  //   emit(Donorsloading());
  //   _donorsSubscription = _donarRepository.streamDonors().listen(
  //     (donors) {
  //       print("Donors fetched: $donors");
  //       emit(DonorsUserfetched(donors: donors));
  //     },
  //     onError: (error) {
  //       print(error.toString());
  //       emit(DonorsFetchfailure(failuremessage: error.toString()));
  //     },
  //   );
  // }

  // @override
  // Future<void> close() {
  //   _donorsSubscription?.cancel();
  //   return super.close();
  // }
}
