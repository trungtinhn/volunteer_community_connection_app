import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volunteer_community_connection_app/components/button_blue.dart';
import 'package:volunteer_community_connection_app/components/button_icon.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/auth_controller.dart';
import 'package:volunteer_community_connection_app/controllers/user_controller.dart';
import 'package:volunteer_community_connection_app/models/user.dart';

import 'package:volunteer_community_connection_app/screens/account/sign_up_screen.dart';
import 'package:volunteer_community_connection_app/screens/bottom_nav/bottom_nav.dart';

import 'login_bloc.dart';
import 'login_state.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isChecked = false;
  bool _isObscured = true;
  bool _isLoading = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final Authcontroller authController = Get.put(Authcontroller());
  final Usercontroller usercontroller = Get.put(Usercontroller());

  @override
  Widget build(BuildContext context) {
    void _showSnackBar() {
      const snackBar = SnackBar(
        content: Text('Đăng nhập không thành công!'),
      );

      // Hiển thị SnackBar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful')),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/welcome.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: const ShapeDecoration(
                    color: AppColors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10),
                          right: Radius.circular(10)),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        // Username TextField
                        TextFormField(
                          controller: _usernameController,
                          style: kLableTextBlackMinium,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.stack),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87),
                            ),
                            labelStyle: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            filled: true,
                            fillColor: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Password TextField
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isObscured,
                          style: kLableTextBlackMinium,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.stack),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black87),
                            ),
                            labelStyle: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            filled: true,
                            fillColor: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Remember Me Checkbox and Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _isChecked = !_isChecked;
                                    });
                                  },
                                  activeColor: AppColors.blue,
                                ),
                                Text(
                                  'Remember me',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Forgot Password Screen
                              },
                              child: Text(
                                'Forgot Password',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: AppColors.slamon,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        // Login Button
                        ButtonBlue(
                          isLoading: _isLoading,
                          onPress: () async {
                            final email = _usernameController.text;
                            final password = _passwordController.text;

                            bool isLogin =
                                await authController.login(email, password);
                            if (isLogin) {
                              User? user =
                                  await usercontroller.getUserByEmail(email);

                              usercontroller.setCurrentUser(user);

                              Get.to(const BottomNavigation());
                            } else {
                              _showSnackBar();
                            }
                          },
                          des: 'Login',
                        ),
                        const SizedBox(height: 25),
                        // Sign Up Option
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an account?',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign up',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: AppColors.slamon,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        // Divider with "Or login with" text
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: AppColors.gray),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                'Or login with',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: AppColors.stack,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: AppColors.gray),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        // Social Login Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonIcon(
                              icon: 'assets/svgs/fb_logo.svg',
                              onPress: () {},
                            ),
                            ButtonIcon(
                              icon: 'assets/svgs/gg_logo.svg',
                              onPress: () {},
                            ),
                            ButtonIcon(
                              icon: 'assets/svgs/ap_logo.svg',
                              onPress: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
