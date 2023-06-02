import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/localization/localization.dart';
import '../../../core/shared_widgets/animations.dart';
import '../../../core/shared_widgets/components.dart';
import '../../../core/shared_widgets/default_form_field.dart';
import '../../../core/theme/style.dart';
import '../core/constants/status.dart';
import '../view_model/register_view_model.dart';
import 'login_view.dart';

class RegisterView extends ConsumerStatefulWidget {
  static const String route = "register";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _specializationController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  FocusNode _emailNode = FocusNode();
  FocusNode _nameNode = FocusNode();
  FocusNode _specializationNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  FocusNode _confirmPasswordNode = FocusNode();
  FocusNode _passwordNode = FocusNode();
  bool isPassword = true;
  bool isLoading = false;
  int userType = 0;
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height / 5,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Image.asset(
                  'assets/images/app_logo.png',
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            value: 0,
                            onChanged: (int? value) {
                              setState(() {
                                userType = value!;
                              });
                            },
                            groupValue: userType,
                            title: Text(
                              getString(context).doctor,
                            ),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            value: 1,
                            onChanged: (int? value) {
                              setState(() {
                                userType = value!;
                              });
                            },
                            groupValue: userType,
                            title: Text(getString(context).patient),
                          ),
                        ),
                      ],
                    ),
                    DefaultFormField(
                      controller: _nameController,
                      validateMode: AutovalidateMode.onUserInteraction,
                      hint: getString(context).userName,
                      autofocus: true,
                      focusNode: _nameNode,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (term) {
                        FocusScope.of(context).requestFocus(_emailNode);
                      },
                      textInputAction: TextInputAction.next,
                      validatorFunction: (value) {
                        if (value!.isEmpty) {
                          return getString(context).emptyName;
                        }
                        return null;
                      },
                      prefixIcon: Icons.person,
                    ),
                    DefaultFormField(
                      controller: _emailController,
                      validateMode: AutovalidateMode.onUserInteraction,
                      hint: getString(context).email,
                      autofocus: true,
                      focusNode: _emailNode,
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (term) {
                        FocusScope.of(context).requestFocus(_phoneNode);
                      },
                      textInputAction: TextInputAction.next,
                      validatorFunction: (value) {
                        if (value!.isEmpty) {
                          return getString(context).emptyEmail;
                        }
                        return null;
                      },
                      prefixIcon: Icons.email,
                    ),
                    DefaultFormField(
                      controller: _phoneController,
                      validateMode: AutovalidateMode.onUserInteraction,
                      hint: getString(context).phoneNumber,
                      autofocus: true,
                      focusNode: _phoneNode,
                      keyboardType: TextInputType.phone,
                      onFieldSubmitted: (term) {
                        FocusScope.of(context)
                            .requestFocus(_specializationNode);
                      },
                      textInputAction: TextInputAction.next,
                      validatorFunction: (value) {
                        if (value!.isEmpty) {
                          return getString(context).emptyPhoneNumber;
                        }
                        return null;
                      },
                      prefixIcon: Icons.phone,
                    ),
                    if (userType == 0)
                      DefaultFormField(
                        controller: _specializationController,
                        validateMode: AutovalidateMode.onUserInteraction,
                        hint: getString(context).specialization,
                        autofocus: true,
                        focusNode: _specializationNode,
                        keyboardType: TextInputType.text,
                        onFieldSubmitted: (term) {
                          FocusScope.of(context).requestFocus(_passwordNode);
                        },
                        textInputAction: TextInputAction.next,
                        validatorFunction: (value) {
                          if (value!.isEmpty) {
                            return getString(context).emptySpectialization;
                          }
                          return null;
                        },
                        prefixIcon: Icons.perm_identity,
                      ),
                    DefaultFormField(
                      controller: _passwordController,
                      focusNode: _passwordNode,
                      textInputAction: TextInputAction.next,
                      validateMode: AutovalidateMode.onUserInteraction,
                      hint: getString(context).password,
                      onFieldSubmitted: (term) {
                        FocusScope.of(context)
                            .requestFocus(_confirmPasswordNode);
                      },
                      validatorFunction: (value) {
                        if (value!.isEmpty) {
                          return getString(context).emptyPassword;
                        } else {
                          return null;
                        }
                      },
                      isPassword: isPassword,
                      suffixIcon:
                          isPassword ? Icons.visibility : Icons.visibility_off,
                      suffixPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      prefixIcon: Icons.lock,
                    ),
                    DefaultFormField(
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordNode,
                      validateMode: AutovalidateMode.onUserInteraction,
                      hint: getString(context).password,
                      onFieldSubmitted: (term) {
                        _submit();
                      },
                      validatorFunction: (value) {
                        if (value!.isEmpty) {
                          return getString(context).emptyPassword;
                        } else if (value != _passwordController.text) {
                          return getString(context).passwordMismatch;
                        } else {
                          return null;
                        }
                      },
                      isPassword: isPassword,
                      // suffixIcon:
                      //     isPassword ? Icons.visibility : Icons.visibility_off,
                      suffixPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      prefixIcon: Icons.lock,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            getString(context).aleardyHaveAccount,
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                LoginScreen.route,
                                (route) => false,
                              );
                            },
                            child: Text(
                              getString(context).login,
                              style: const TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                                color: secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          textStyle: const TextStyle(fontSize: 24),
                          minimumSize: const Size.fromHeight(50),
                          foregroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        onPressed: () async {
                          if (isLoading) {
                            return;
                          }

                          _submit();
                        },
                        child: isLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(
                                      color: Colors.white),
                                  const SizedBox(width: 16),
                                  Text(
                                    getString(context).isLoading,
                                    style: const TextStyle(color: whiteColor),
                                  ),
                                ],
                              )
                            : Text(
                                getString(context).createAccount,
                                style: const TextStyle(color: whiteColor),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameNode.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    super.dispose();
  }

  void _submit() {
    checkInternetConnection().then((value) {
      if (value) {
        if (!_formKey.currentState!.validate()) {
        } else {
          setState(() => isLoading = true);
          // user login with phone
          final email = _emailController.text;
          final name = _nameController.text;
          final phone = _phoneController.text;
          final password = _passwordController.text;
          final confirmPassword = _confirmPasswordController.text;
          final specialization = _specializationController.text.isEmpty
              ? ""
              : _specializationController.text;
          ref
              .read(registerVM)
              .register(
                userType == 0 ? "Doctor" : "Patient",
                name,
                email,
                phone,
                specialization,
                password,
              )
              .then((accountStatus) {
            if (accountStatus == LoginStatus.success) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
            } else {
              setState(() => isLoading = false);
              showToast(
                text: getString(context).registerationError,
                bgColor: errorColor,
              );
            }
          });
        }
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) => _showStartDialog());
      }
    });
  }

  _showStartDialog() async {
    return showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionBuilder: (context, _animation, _secondaryAnimation, _child) {
        return Animations.grow(_animation, _secondaryAnimation, _child);
      },
      pageBuilder: (_animation, _secondaryAnimation, _child) {
        return AlertDialog(
          content: Text(
            getString(context).internetProblem,
            style: const TextStyle(
              color: primaryColor,
              fontSize: 20,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                getString(context).ok,
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
