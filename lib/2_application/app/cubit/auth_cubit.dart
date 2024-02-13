import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(const AuthCubitInitial(isLoggedIn: false));

  void authStateChanged({User? user}) {
    final bool isLoggedIn = user != null;
    emit(AuthCubitInitial(
      isLoggedIn: isLoggedIn,
      userId: user?.uid,
    ));
  }
}
