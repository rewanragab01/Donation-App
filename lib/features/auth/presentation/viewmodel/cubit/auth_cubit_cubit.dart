import 'package:bloc/bloc.dart';
import 'package:donation/features/auth/data/repos/authrepo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_cubit_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  final AuthRepository _authRepository;
  AuthCubitCubit(this._authRepository) : super(AuthCubitInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      await _authRepository.signIn(email: email, password: password);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'invalid-credential':
          errorMessage =
              'The supplied auth credential is incorrect, malformed, or has expired.';
          break;
        default:
          errorMessage = e.message ?? 'An unknown error occurred.';
      }
      emit(AuthFailure(errorMessage: errorMessage));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred.'));
    }
  }

  Future<void> signUp(String email, String password, String phone,
      String bloodType, String role) async {
    try {
      emit(AuthLoading());
      await _authRepository.signUp(
          email: email,
          password: password,
          phone: phone,
          bloodType: bloodType,
          role: role);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'An account already exists with this email.';
          break;
        case 'weak-password':
          errorMessage = 'Password should be at least 6 characters.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        default:
          errorMessage = 'An unknown error occurred.';
      }
      emit(AuthFailure(errorMessage: errorMessage));
    } catch (e) {
      emit(AuthFailure(errorMessage: 'An unexpected error occurred.'));
    }
  }

//   Future<void> signOut() async {
//     try {
//       emit(AuthLoading());
//       await _authRepository
//           .signOut(); // Assuming your AuthRepository has a signOut method
//       emit(AuthSignOutSuccess());
//     } catch (e) {
//       emit(AuthFailure(errorMessage: 'An unexpected error occurred.'));
//     }
//   }
}
