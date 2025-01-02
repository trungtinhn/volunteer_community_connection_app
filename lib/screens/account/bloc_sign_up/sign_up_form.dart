import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volunteer_community_connection_app/components/button_blue.dart';
import 'package:volunteer_community_connection_app/constants/app_colors.dart';
import 'package:volunteer_community_connection_app/constants/app_styles.dart';
import 'package:volunteer_community_connection_app/controllers/auth_controller.dart';
import 'package:volunteer_community_connection_app/models/user.dart';
import 'package:volunteer_community_connection_app/screens/account/bloc_sign_up/sign_up_event.dart';
import 'package:volunteer_community_connection_app/screens/account/login_screen.dart';
import 'package:intl/intl.dart';
import 'sign_up_bloc.dart';
import 'sign_up_state.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isChecked = false;
  bool _isObscured = false;
  bool _isObscuredConfirm = false;
  bool _isLoading = false;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dayOfBirthController = TextEditingController();
  DateTime dayOfBirth = DateTime.now();

  final Authcontroller _authcontroller = Get.put(Authcontroller());

  String formatDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dayOfBirth,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != dayOfBirth) {
      setState(() {
        dayOfBirth = picked;
        dayOfBirthController.text = formatDate(dayOfBirth);
      });
    }
  }

  Future<bool> _validate() async {
    if (fullNameController.text.isEmpty) {
      return false;
    }
    if (emailController.text.isEmpty) {
      return false;
    }
    if (phoneNumberController.text.isEmpty) {
      return false;
    }
    if (passwordController.text.isEmpty) {
      return false;
    }
    if (confirmPasswordController.text.isEmpty) {
      return false;
    }
    if (dayOfBirthController.text.isEmpty) {
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    void _showSnackBar(String message) {
      final snackBar = SnackBar(
        content: Text(message),
      );

      // Hiển thị SnackBar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void _signUp() async {
      print('Full name: ${fullNameController.text}');
      if (await _validate()) {
        User user = User(
            userId: 0,
            name: fullNameController.text,
            email: emailController.text,
            phoneNumber: phoneNumberController.text,
            dayOfBirth: dayOfBirth,
            role: 'user',
            avatarUrl: '',
            countDonate: 0,
            countPosts: 0);
        setState(() {
          _isLoading = true;
        });
        var result =
            await _authcontroller.register(user, passwordController.text);
        setState(() {
          _isLoading = false;
        });
        if (result) {
          _showSnackBar('Sign Up successful');
          Navigator.pop(context);
        } else {
          _showSnackBar('Sign Up failed');
        }
      } else {
        _showSnackBar('Sign Up failed');
      }
    }

    return BlocListener<SignUpBloc, SignUpState>(listener: (context, state) {
      if (state is SignUpFailure) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      } else if (state is SignUpSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign Up successful')),
        );
      }
    }, child: BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      if (state is SignUpLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign Up',
                  style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Opacity(
                  opacity: 0.75,
                  child: Text(
                    'Let’s get you all st up so you can access your personal account.',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                    controller: fullNameController,
                    onChanged: (value) {},
                    style: kLableTextBlackMinium,
                    decoration: InputDecoration(
                        labelText: 'Full Name',
                        enabledBorder: const OutlineInputBorder(
                          // viền khi không có focus
                          borderSide: BorderSide(color: AppColors.stack),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          // viền khi có focus
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                        filled: true,
                        fillColor: AppColors.white)),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: emailController,
                    onChanged: (value) {},
                    style: kLableTextBlackMinium,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        enabledBorder: const OutlineInputBorder(
                          // viền khi không có focus
                          borderSide: BorderSide(color: AppColors.stack),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          // viền khi có focus
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                        filled: true,
                        fillColor: AppColors.white)),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: phoneNumberController,
                    onChanged: (value) {},
                    style: kLableTextBlackMinium,
                    decoration: InputDecoration(
                        labelText: 'Phone number',
                        enabledBorder: const OutlineInputBorder(
                          // viền khi không có focus
                          borderSide: BorderSide(color: AppColors.stack),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          // viền khi có focus
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                        filled: true,
                        fillColor: AppColors.white)),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: dayOfBirthController,
                    onChanged: (value) {},
                    style: kLableTextBlackMinium,
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: 'Day of birth',
                        enabledBorder: const OutlineInputBorder(
                          // viền khi không có focus
                          borderSide: BorderSide(color: AppColors.stack),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          // viền khi có focus
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                        filled: true,
                        suffixIcon: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: const Icon(Icons.date_range_outlined),
                        ),
                        fillColor: AppColors.white)),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                    controller: passwordController,
                    obscureText: _isObscured,
                    style: kLableTextBlackMinium,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: _isObscured
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                        enabledBorder: const OutlineInputBorder(
                          // viền khi không có focus
                          borderSide: BorderSide(color: AppColors.stack),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          // viền khi có focus
                          borderSide: BorderSide(color: Colors.black87),
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400),
                        ),
                        filled: true,
                        fillColor: AppColors.white)),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: _isObscuredConfirm,
                  style: kLableTextBlackMinium,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: _isObscuredConfirm
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscuredConfirm = !_isObscuredConfirm;
                          });
                        },
                      ),
                      enabledBorder: const OutlineInputBorder(
                        // viền khi không có focus
                        borderSide: BorderSide(color: AppColors.stack),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        // viền khi có focus
                        borderSide: BorderSide(color: Colors.black87),
                      ),
                      labelStyle: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400),
                      ),
                      filled: true,
                      fillColor: AppColors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                    Expanded(
                      child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      color: AppColors.stack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              children: const [
                                TextSpan(text: 'I agree to all to '),
                                TextSpan(
                                    text: 'Term',
                                    style: TextStyle(color: AppColors.slamon)),
                                TextSpan(text: ' and '),
                                TextSpan(
                                    text: 'Privacy Policies',
                                    style: TextStyle(color: AppColors.slamon)),
                              ])),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonBlue(
                  isLoading: _isLoading,
                  onPress: () {
                    setState(() {
                      _isLoading = true;
                    });
                    _signUp();
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  des: 'Sign Up',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: AppColors.slamon,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
