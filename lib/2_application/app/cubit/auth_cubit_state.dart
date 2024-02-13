part of 'auth_cubit.dart';

sealed class AuthCubitState extends Equatable {
  const AuthCubitState();

  @override
  List<Object> get props => [];
}

final class AuthCubitInitial extends AuthCubitState {
  const AuthCubitInitial({required this.isLoggedIn, this.userId});

  final bool isLoggedIn;
  final String? userId;
}
