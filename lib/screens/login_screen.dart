import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/home_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/utils/validators.dart';
import 'package:instagram_clone/widgets/elevated_button.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final String? response = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (response is String) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, response);
      return;
    }

    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() => naviagateToScreen(context, const SignUpScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                // Logo
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  height: 64,
                  // ignore: deprecated_member_use
                  color: primaryColor,
                ),
                const SizedBox(
                  height: 64,
                ),
                // Email
                TextFieldInput(
                  textEditingController: _emailController,
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                  validator: (value) => emailValidator(value!),
                ),
                const SizedBox(
                  height: 24,
                ),
                // Password
                TextFieldInput(
                  textEditingController: _passwordController,
                  hintText: 'Enter your password',
                  textInputType: TextInputType.text,
                  isPassword: true,
                  validator: (value) => passwordValidator(value!),
                ),
                const SizedBox(
                  height: 24,
                ),
                // Log In Button
                ReusableElevatedButton(
                  text: 'Log In',
                  onPressed: () => onLogin(),
                  isLoading: _isLoading,
                ),
                const SizedBox(
                  height: 24,
                ),
                // Sign Up Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Don't have an account?",
                      ),
                    ),
                    GestureDetector(
                      onTap: () => navigateToSignUp(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          ' Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: blueColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
