import 'package:donation/core/apptext_button.dart';
import 'package:donation/core/apptext_formfield.dart';
import 'package:donation/core/showtoast.dart';
import 'package:donation/features/auth/data/repos/authrepo.dart';
import 'package:donation/features/auth/presentation/viewmodel/cubit/auth_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Authscreen extends StatefulWidget {
  const Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  String _selectedBloodType = 'A+';
  String _role = 'patient';
  bool _issignup = false;
  final List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phonenumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubitCubit(AuthRepository()),
        child: Stack(
          children: [
            // Red background container
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.05), // Adjust top padding
                height: screenHeight * 0.35, // Dynamic height
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
                child: BloodCare_Logo(
                    screenHeight: screenHeight, screenWidth: screenWidth),
              ),
            ),
            // Positioned form container
            Positioned(
              top: screenHeight *
                  0.20, // Adjust top positioning based on screen height
              right: screenWidth * 0.05, // Adjust right padding
              left: screenWidth * 0.05, // Adjust left padding

              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 5.5,
                        spreadRadius: 2.2,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: 8), // Dynamic padding
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            _issignup ? 'Sign up' : 'Login',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: screenWidth * 0.05),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.03, // Dynamic spacing
                        ),
                        AppTextFormField(
                          labeltext: 'Email',
                          hintText: 'Email',
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        AppTextFormField(
                          isObscureText: true,
                          labeltext: 'Password',
                          hintText: 'Password',
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        if (_issignup) ...[
                          const SizedBox(height: 10),
                          AppTextFormField(
                            labeltext: 'PhoneNumber',
                            keyboardType: TextInputType.phone,
                            hintText: 'PhoneNumber',
                            controller: phonenumberController,
                            validator: (value) {
                              if (value!.isEmpty || value.length != 12) {
                                return 'phone number must containing 12 digits';
                              }
                              return null;
                            },
                          ),
                        ],
                        const SizedBox(
                          height: 10,
                        ),
                        if (_issignup) ...[
                          Select_BloodType(),
                          const SizedBox(
                            height: 10,
                          ),
                          PatientOrDonar(),
                        ],
                        _issignup
                            ? LoginMethod(screenWidth)
                            : SignUpMethod(screenWidth),
                        SizedBox(
                          height: 10,
                        ),
                        BlocConsumer<AuthCubitCubit, AuthCubitState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return CircularProgressIndicator();
                            } else {
                              return AppTextButton(
                                backgroundColor: Colors.red,
                                buttonHeight: screenHeight *
                                    0.06, // Dynamic button height
                                buttonWidth:
                                    screenWidth * 0.4, // Dynamic button width
                                buttonText: _issignup ? 'Sign up' : 'Login',
                                textStyle: TextStyle(color: Colors.white),
                                onPressed: () {
                                  // Handle form submission based on _issignup
                                  if (_formKey.currentState!.validate()) {
                                    if (_issignup) {
                                      BlocProvider.of<AuthCubitCubit>(context)
                                          .signUp(
                                              emailController.text,
                                              passwordController.text,
                                              phonenumberController.text,
                                              _selectedBloodType,
                                              _role);
                                    } else {
                                      BlocProvider.of<AuthCubitCubit>(context)
                                          .login(emailController.text,
                                              passwordController.text);
                                    }
                                  }
                                },
                              );
                            }
                          },
                          listener: (context, state) {
                            if (state is AuthFailure) {
                              showToast(message: state.errorMessage);
                            } else if (state is AuthSuccess) {
                              _issignup
                                  ? showToast(message: 'SignUp successfully')
                                  : showToast(message: 'Login successfully');
                              Navigator.pushNamed(context, '/home');
                            } else {
                              Text('jfbhbbjfdnmf');
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField<String> Select_BloodType() {
    return DropdownButtonFormField<String>(
      value: _selectedBloodType,
      items: _bloodTypes
          .map((bloodType) => DropdownMenuItem(
                value: bloodType,
                child: Text(bloodType),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedBloodType = value!;
        });
      },
      decoration: const InputDecoration(labelText: 'Blood Type'),
    );
  }

  Column PatientOrDonar() {
    return Column(
      children: [
        RadioListTile(
          title: const Text('Patient'),
          value: 'patient',
          groupValue: _role,
          onChanged: (value) {
            setState(() {
              _role = value.toString();
            });
          },
        ),
        RadioListTile(
          title: const Text('Donator'),
          value: 'donator',
          groupValue: _role,
          onChanged: (value) {
            setState(() {
              _role = value.toString();
            });
          },
        ),
      ],
    );
  }

  Row SignUpMethod(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Don\'t have an account? ',
          style: TextStyle(fontSize: screenWidth * 0.03),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _issignup = true;
              // Switch to sign up screen
              FocusScope.of(context).unfocus();
              emailController.clear();
              passwordController.clear();
            });
          },
          child: Text(
            'Sign up',
            style: TextStyle(
              color: Colors.red,
              fontSize: screenWidth * 0.03,
            ),
          ),
        ),
      ],
    );
  }

  Row LoginMethod(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(fontSize: screenWidth * 0.03),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _issignup = false; // Switch to sign up screen
              FocusScope.of(context).unfocus();
              emailController.clear();
              passwordController.clear();
            });
          },
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.red,
              fontSize: screenWidth * 0.03,
            ),
          ),
        ),
      ],
    );
  }
}

class BloodCare_Logo extends StatelessWidget {
  const BloodCare_Logo({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(150), // No border radius
            child: Image.asset(
              'assets/water 1.png', // Path to your image
              height: screenHeight * 0.1, // Set specific height for the image
              width: screenWidth * 0.2, // Set specific width for the image
              fit: BoxFit.cover, // This controls how the image scales
            ),
          ),
        ),
        Text(
          'Blood Care',
          style: TextStyle(
            color: Colors.white,
            fontSize:
                screenWidth * 0.05, // Dynamic font size based on screen width
          ),
        ),
      ],
    );
  }
}
