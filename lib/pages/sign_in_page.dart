import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:go_router/go_router.dart';

import '../blocs/bloc_provider.dart';
import '../blocs/firebase_auth_bloc.dart';
import '../extension/build_context.dart';
import '../extension/string.dart';
import '../routes/router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final _authBloc = BlocProvider.of<FirebaseAuthBloc>(context);
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordVisibility = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordVisibility.dispose();
    super.dispose();
  }

  void _afterSignIn(fpdart.Either<UserCredential?, String> result) {
    result.match(
      (user) {
        if (user != null) {
          context.goNamed(AppRoute.fridge.name);
        }
      },
      (exception) => context.showErrorSnackBar(exception),
    );
  }

  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      await _authBloc
          .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          )
          .then(_afterSignIn);
    }
  }

  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      await _authBloc
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          )
          .then(_afterSignIn);
    }
  }

  Future<void> _signInWithGoogle() async =>
      _authBloc.signInWithGoogle().then(_afterSignIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/8.0x/flutter_logo.png',
                    height: 200,
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Adresse email',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    } else if (!value.isValidEmail()) {
                      return 'Veuillez entrer un email valide';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder(
                  valueListenable: _passwordVisibility,
                  builder: (context, passwordVisibility, child) =>
                      TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () => _passwordVisibility.value =
                            !_passwordVisibility.value,
                        icon: Icon(
                          passwordVisibility
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        tooltip: passwordVisibility
                            ? 'Masquer le mot de passe'
                            : 'Afficher le mot de passe',
                      ),
                    ),
                    obscureText: !passwordVisibility,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: _signIn,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      } else if (value.length < 8) {
                        return "Veuillez entrer un mot de passe d'au moins 8 caractères";
                      } else if (!value.containsNumber()) {
                        return 'Veuillez entrer un mot de passe contenant au moins un chiffre';
                      } else if (!value.containsUppercase()) {
                        return 'Veuillez entrer un mot de passe contenant au moins une majuscule';
                      } else if (!value.containsLowercase()) {
                        return 'Veuillez entrer un mot de passe contenant au moins une minuscule';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _signIn,
                      child: const Text('Se connecter'),
                    ),
                    const SizedBox(width: 32),
                    ElevatedButton(
                      onPressed: _signUp,
                      child: const Text("S'inscrire"),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: _signInWithGoogle,
                  child: const Text('Se connecter avec Google'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
