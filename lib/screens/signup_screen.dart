// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/utils/validators.dart';
import 'package:instagram_clone/widgets/elevated_button.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List? selectedImage = await pickImage(ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        _image = selectedImage;
      });
    }
  }

  void onSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    if (_image == null) {
      showSnackBar(context, 'You must upload a profile picture');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String? response = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );

    setState(() {
      _isLoading = false;
    });

    if (response != null) {
      showSnackBar(context, response);
      return;
    }

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const ResponsiveLayout(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
    ));
  }

  void navigateToLogIn() => naviagateToScreen(context, const LoginScreen());

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
                // Profile Pic
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                            backgroundColor: Colors.black,
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(
                                'https://i.stack.imgur.com/l60Hf.png'),
                            backgroundColor: Colors.black,
                          ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                TextButton(
                  onPressed: () => selectImage(),
                  child: Text(
                    '${_image != null ? 'Change' : 'Add'} Profile Picture',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                // Username
                TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text,
                  validator: (value) => usernameValidator(value!),
                ),
                const SizedBox(
                  height: 24,
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
                // Bio
                TextFieldInput(
                  textEditingController: _bioController,
                  hintText: 'Enter your bio',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 24,
                ),
                // Log In Button
                ReusableElevatedButton(
                  text: 'Sign Up',
                  onPressed: () => onSignUp(),
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
                        "Already have an account?",
                      ),
                    ),
                    GestureDetector(
                      onTap: () => navigateToLogIn(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          ' Log In',
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
