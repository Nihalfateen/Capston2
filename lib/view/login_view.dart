import 'package:capstone/core/theme/style.dart';
import 'package:capstone/core/utils/cache_helper.dart';
import 'package:capstone/view/home/home_view.dart';
import 'package:capstone/view/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/constants.dart';
import '../core/constants/status.dart';
import '../core/localization/localization.dart';
import '../core/shared_widgets/animations.dart';
import '../core/shared_widgets/components.dart';
import '../core/shared_widgets/default_form_field.dart';
import '../view_model/user_profile_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String route = "login";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  bool isPassword = true;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(height: 10),
              DefaultFormField(
                controller: _emailController,
                validateMode: AutovalidateMode.onUserInteraction,
                hint: getString(context).phoneNumber,
                autofocus: true,
                focusNode: emailNode,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(passwordNode);
                },
                textInputAction: TextInputAction.next,
                validatorFunction: (value) {
                  if (value!.isEmpty) {
                    return getString(context).emptyEmail;
                  }
                  return null;
                },
                prefixIcon: Icons.phone,
              ),
              DefaultFormField(
                controller: _passwordController,
                focusNode: passwordNode,
                validateMode: AutovalidateMode.onUserInteraction,
                hint: getString(context).password,
                onFieldSubmitted: (term) {
                  _submit();
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
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      getString(context).accountNotExists,
                      style: const TextStyle(
                          fontSize: 17.0,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterView(),
                          ),
                        );
                      },
                      child: Text(
                        getString(context).createAccount,
                        style: const TextStyle(
                          fontSize: 18.0,
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
                    textStyle: const TextStyle(fontSize: 24),
                    minimumSize: const Size.fromHeight(50),
                    foregroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  onPressed: () async {
                    if (isLoading) {
                      return;
                    }

                    // await Future.delayed(const Duration(seconds: 3));
                    _submit();
                    // setState(() => isLoading = false);
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
                    getString(context).login,
                    style: const TextStyle(color: whiteColor),
                  ),
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
    _emailController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  void _submit() {
    checkInternetConnection().then((value) {
      if (value) {
        if (!_formKey.currentState!.validate()) {
        } else {
          setState(() => isLoading = true);
          // user login with phone
          final phoneNumber = _emailController.text;
          final password = _passwordController.text;
          final fcmToken =
              CacheHelper.getPrefs(key: Constants.fcmTokenPrefKey) ?? "";
          ref
              .read(userProfileProvider)
              .userLogin(phoneNumber, password, fcmToken)
              .then((value) {
            if (value == LoginStatus.success) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(HomeView.route, (route) => false);
            } else {
              setState(() => isLoading = false);
              showToast(
                text: getString(context).unAuthorized,
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