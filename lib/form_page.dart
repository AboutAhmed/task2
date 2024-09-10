import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_bloc.dart'; // Import the renamed BLoC file

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BLoC Form')),
      body: BlocProvider(
        create: (_) => FormBloc(), // Initialize the FormBloc
        child: BlocListener<FormBloc, MyFormState>( // Listen to state changes
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login successful!')),
              );
            } else if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _EmailField(),
                _PasswordField(),
                _SubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, MyFormState>(
      builder: (context, state) {
        return TextField(
          onChanged: (email) => context.read<FormBloc>().emailChanged(email),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.isValidEmail ? null : 'Invalid email',
          ),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, MyFormState>(
      builder: (context, state) {
        return TextField(
          onChanged: (password) => context.read<FormBloc>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: state.isValidPassword ? null : 'Password too short',
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, MyFormState>(
      builder: (context, state) {
        return state.isSubmitting
            ? CircularProgressIndicator()
            : ElevatedButton(
          onPressed: () => context.read<FormBloc>().submitForm(),
          child: Text('Submit'),
        );
      },
    );
  }
}
