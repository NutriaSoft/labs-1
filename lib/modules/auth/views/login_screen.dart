import 'package:flutter/material.dart';
import 'package:flutter_tutorial/core/contexts/auth_context.dart';
import 'package:flutter_tutorial/modules/auth/services/loginUser.dart';
import 'package:flutter_tutorial/modules/auth/validators/password.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  // ValueNotifier for server-side validation errors
  final ValueNotifier<String?> _usernameErrorNotifier =
      ValueNotifier<String?>(null);

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameErrorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthContext authContext = Provider.of<AuthContext>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Login',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    ValueListenableBuilder(
                        valueListenable: _usernameErrorNotifier,
                        builder: (context, String? serverError, _) {
                          return TextFormField(
                            controller: _usernameController,
                            onChanged: (value) =>
                                _usernameErrorNotifier.value = null,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username or email';
                              }
                              if (value.length < 6) {
                                return 'Username or Email must be at least 6 characters';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Username or Email',
                              border: const OutlineInputBorder(),
                              errorText: serverError,
                            ),
                          );
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: (value) => _usernameErrorNotifier.value = null,
                      controller: _passwordController,
                      obscureText: true,
                      validator: passwordValidator,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _usernameErrorNotifier.value = null;
                        if (!_formKey.currentState!.validate()) return;

                        (() async {
                          final metaUser = await loginUser(
                            _usernameController.text.trim().toLowerCase(),
                            _passwordController.text,
                            _usernameErrorNotifier,
                          );

                          if (metaUser != null && context.mounted) {
                            authContext.setMetaUser(metaUser);
                            context.go('/list-chats');
                          }
                        })();
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      context.go('/register');
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
