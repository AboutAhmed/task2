import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

/// Define the state class (MyFormState)
class MyFormState extends Equatable {
  final String email;
  final String password;
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final String errorMessage;

  const MyFormState({
    required this.email,
    required this.password,
    this.isValidEmail = true,
    this.isValidPassword = true,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  MyFormState copyWith({
    String? email,
    String? password,
    bool? isValidEmail,
    bool? isValidPassword,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return MyFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    isValidEmail,
    isValidPassword,
    isSubmitting,
    isSuccess,
    errorMessage
  ];
}

/// Define the FormBloc class
class FormBloc extends Cubit<MyFormState> {
  FormBloc() : super(const MyFormState(email: '', password: ''));

  /// Handles email input changes
  void emailChanged(String email) {
    emit(state.copyWith(
      email: email,
      isValidEmail: _validateEmail(email),
    ));
  }

  /// Handles password input changes
  void passwordChanged(String password) {
    emit(state.copyWith(
      password: password,
      isValidPassword: _validatePassword(password),
    ));
  }

  /// Submits the form and handles validation
  void submitForm() async {
    // Check if email and password are valid
    if (_validateEmail(state.email) && _validatePassword(state.password)) {
      emit(state.copyWith(isSubmitting: true));

      // Simulate a delay to mimic network call (e.g., authentication)
      await Future.delayed(const Duration(seconds: 2));

      // For demonstration, we assume success if email is "test@test.com"
      // and password is "password123"
      if (state.email == 'test@test.com' && state.password == 'password123') {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          errorMessage: 'Invalid credentials',
        ));
      }
    } else {
      emit(state.copyWith(
        isValidEmail: _validateEmail(state.email),
        isValidPassword: _validatePassword(state.password),
      ));
    }
  }

  /// Helper function to validate email format
  bool _validateEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  /// Helper function to validate password length
  bool _validatePassword(String password) {
    return password.length >= 6;
  }
}
