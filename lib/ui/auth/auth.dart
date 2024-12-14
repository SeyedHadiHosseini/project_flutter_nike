import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_seven_nike_welcomeback/data/repo/auth_repositroy.dart';
import 'package:project_seven_nike_welcomeback/data/repo/cart_repository.dart';
import 'package:project_seven_nike_welcomeback/theme.dart';
import 'package:project_seven_nike_welcomeback/ui/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController usernameController =
      TextEditingController(text: "test@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onBackGround = Colors.white;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Theme(
        data: themeData.copyWith(
          colorScheme: themeData.colorScheme.copyWith(
            onSurface: onBackGround,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              minimumSize: MaterialStateProperty.all(const Size.fromHeight(56)),
              backgroundColor: MaterialStateProperty.all(onBackGround),
              foregroundColor:
                  MaterialStateProperty.all(themeData.colorScheme.secondary),
            ),
          ),
          snackBarTheme: SnackBarThemeData(
              backgroundColor: themeData.colorScheme.primary,
              contentTextStyle: const TextStyle(fontFamily: "")),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: const TextStyle(color: onBackGround),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: onBackGround, width: 1),
            ),
          ),
        ),
        child: Scaffold(
            backgroundColor: themeData.colorScheme.secondary,
            body: BlocProvider<AuthBloc>(
              create: (context) {
                final bloc =
                    AuthBloc(authRepository, cartRepository: cartRepository);
                bloc.stream.forEach((state) {
                  if (state is AuthSuccess) {
                    Navigator.of(context).pop();
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.exception.message)));
                  }
                });
                return bloc;
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 48, right: 48),
                child: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) {
                    return current is AuthLoading ||
                        current is AuthInitial ||
                        current is AuthError;
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/nike_logo.png',
                          color: Colors.white,
                          width: 120,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          state.isLoginMode ? 'خوش امدید' : 'ثبت نام',
                          style: const TextStyle(
                              color: onBackGround, fontSize: 22),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                            state.isLoginMode
                                ? 'لطفا وارد حساب کاربری خود شوید'
                                : 'ایمیل و رمز عبور خود را تعیین کنید',
                            style: const TextStyle(
                                color: onBackGround, fontSize: 16)),
                        const SizedBox(
                          height: 24,
                        ),
                        TextField(
                          style: const TextStyle(color: LightThemeColor.secondaryTextColor),
                          controller: usernameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:  BorderSide(color: onBackGround.withOpacity(0.5)),
                            ),
                            label: const Text('آدرس ایمیل'),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _PasswordTextField(
                          onBackGround: onBackGround,
                          controller: passwordController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            //  await authRepository.login("mammamma5@gmail.com", "123456");
                            BlocProvider.of<AuthBloc>(context).add(
                                AuthButtonIsClicked(usernameController.text,
                                    passwordController.text));
                          },
                          child: (state is AuthLoading
                              ? const CircularProgressIndicator()
                              : Text(state.isLoginMode ? 'ورود' : 'ثبت نام')),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(AuthModeChangeIsClicked());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.isLoginMode
                                    ? 'حساب کاربری ندارید؟'
                                    : 'حساب کاربری دارید؟',
                                style: TextStyle(
                                    color: onBackGround.withOpacity(0.7)),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                state.isLoginMode ? 'ثبت نام کنید' : 'ورود',
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            )),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    Key? key,
    required this.onBackGround,
    required this.controller,
  }) : super(key: key);

  final Color onBackGround;
  final TextEditingController controller;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style:  const TextStyle(color: LightThemeColor.secondaryTextColor),
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obsecureText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: widget.onBackGround.withOpacity(0.5)),
        ),
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obsecureText = !obsecureText;
              });
            },
            icon: Icon(
              obsecureText
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: widget.onBackGround.withOpacity(0.6),
            )),
        label: const Text('رمزعبور'),
      ),
    );
  }
}
