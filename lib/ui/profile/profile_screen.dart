import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_seven_nike_welcomeback/data/auth_info.dart';
import 'package:project_seven_nike_welcomeback/data/repo/auth_repositroy.dart';
import 'package:project_seven_nike_welcomeback/data/repo/cart_repository.dart';
import 'package:project_seven_nike_welcomeback/ui/auth/auth.dart';
import 'package:project_seven_nike_welcomeback/ui/favorites/favorite_screen.dart';
import 'package:project_seven_nike_welcomeback/ui/order/order_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              'پروفایل',
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       authRepository.signOut();
        //       CartRepository.cartItemCountNotifier.value = 0;
        //     },
        //     icon: const Icon(
        //       (Icons.exit_to_app),
        //     ),
        //   ),
        // ],
      ),
      body: ValueListenableBuilder<AuthInfo?>(
          valueListenable: AuthRepository.authChangeNotifier,
          builder: (context, authInfo, child) {
            final isLogin = authInfo != null && authInfo.accessToken.isNotEmpty;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(top: 32, bottom: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).dividerColor.withOpacity(0.2),
                      ),
                    ),
                    child: Image.asset('assets/img/nike_logo.png'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    isLogin ? authInfo.email : 'کابر مهمان',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Divider(
                    height: 1,
                    color: Theme.of(context).dividerColor.withOpacity(0.2),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const FavoriteListScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      height: 56,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Icon(
                            CupertinoIcons.heart,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('لیست علاقمندی ها')
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Theme.of(context).dividerColor.withOpacity(0.2),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OrderHistoryScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      height: 56,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Icon(
                            CupertinoIcons.cart,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('سوابق سفارش')
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Theme.of(context).dividerColor.withOpacity(0.2),
                  ),
                  InkWell(
                    onTap: () {
                      if (isLogin) {
                        // When we want to show dialog we can use this fun
                        showDialog(
                            context: context,
                            useRootNavigator: true,
                            builder: (context) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: AlertDialog(
                                  title: const Text('خروج از حساب کاربری'),
                                  content: const Text(
                                      'آیا میخواهید از حساب خود خارج شوید؟'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('خیر')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          authRepository.signOut();
                                          CartRepository
                                              .cartItemCountNotifier.value = 0;
                                        },
                                        child: const Text('بله')),
                                  ],
                                ),
                              );
                            });
                      } else {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) => const AuthScreen(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      height: 56,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Icon(
                            isLogin
                                ? CupertinoIcons.arrow_right_square
                                : CupertinoIcons.arrow_left_square,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(isLogin
                              ? 'خروج از حساب کاربری'
                              : 'ورود به حساب کاربری')
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Theme.of(context).dividerColor.withOpacity(0.2),
                  )
                ],
              ),
            );
          }),
    );
  }
}
