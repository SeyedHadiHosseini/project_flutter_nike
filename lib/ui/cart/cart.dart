import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_seven_nike_welcomeback/common/utils.dart';
import 'package:project_seven_nike_welcomeback/data/repo/auth_repositroy.dart';
import 'package:project_seven_nike_welcomeback/data/repo/cart_repository.dart';
import 'package:project_seven_nike_welcomeback/ui/auth/auth.dart';
import 'package:project_seven_nike_welcomeback/ui/cart/bloc/cart_bloc.dart';
import 'package:project_seven_nike_welcomeback/ui/cart/cart_item.dart';
import 'package:project_seven_nike_welcomeback/ui/cart/price_info.dart';
import 'package:project_seven_nike_welcomeback/ui/empty_state.dart';
import 'package:project_seven_nike_welcomeback/ui/shipping/shipping.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;
  StreamSubscription? stateStreamSubscription;
  final RefreshController _refreshController = RefreshController();
  bool stateIsSuccess = false;

  @override
  void initState() {
    super.initState();
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
  }

  void authChangeNotifierListener() {
    cartBloc?.add(CartAuthInfoChanged(AuthRepository.authChangeNotifier.value));
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier
        .removeListener(authChangeNotifierListener);
    cartBloc?.close();
    stateStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: stateIsSuccess,
        child: Container(
          margin: const EdgeInsets.only(left: 48, right: 48),
          width: MediaQuery.of(context).size.width,
          child: FloatingActionButton.extended(onPressed: () {
            final state = cartBloc!.state;

            if (state is CartSuccess) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ShippingScreen(
                payablePrice: state.cartResponse.payablePrice ,
                shippingCost: state.cartResponse.shippingCost,
                totalPrice: state.cartResponse.totalPrice,
              )));
            }


          }, label: const Text('پرداخت'),
          ),
        ),
      ),floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("سبد خرید"),
      ),
      body: BlocProvider<CartBloc>(
        create: (context) {
          final bloc = CartBloc(cartRepository);
          stateStreamSubscription = bloc.stream.listen((state) {

              setState(() {
                stateIsSuccess = state is CartSuccess;
              });

            if (_refreshController.isRefresh) {
              if (state is CartSuccess) {
                _refreshController.refreshCompleted();
              } else if (state is CartError) {
                _refreshController.refreshFailed();
              }
            }
          });
          cartBloc = bloc;
          bloc.add(CartStarted(AuthRepository.authChangeNotifier.value));
          return bloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else if (state is CartSuccess) {
              return SmartRefresher(
                controller: _refreshController,
                header: const ClassicHeader(
                  completeText: 'با موفقیت انجام شد',
                  refreshingText: 'در حال به روزرسانی',
                  idleText: 'برای به روزرسانی پایین بکشید',
                  releaseText: 'رها کنید',
                  failedText: 'خطای نامشخض',
                  spacing: 2,
                  completeIcon: Icon(
                    CupertinoIcons.checkmark_alt_circle,
                    color: Colors.grey,
                  ),
                  refreshStyle: RefreshStyle.UnFollow,
                  releaseIcon: Icon(
                    CupertinoIcons.exclamationmark,
                    color: Colors.grey,
                    size: 17,
                  ),
                ),
                onRefresh: () {
                  cartBloc?.add(
                    CartStarted(AuthRepository.authChangeNotifier.value,
                        isRefreshing: true),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: ListView.builder(
                    physics: defaultScrollPhysics,
                    itemBuilder: (context, index) {
                      if (index < state.cartResponse.cartItems.length) {
                        final data = state.cartResponse.cartItems[index];
                        return CartItem(
                          data: data,
                          onDeleteButtonClick: () {
                            cartBloc?.add(CartDeleteButtonClicked(data.id));
                          },
                          onDecreaseButtonClick: () {
                            if (data.count > 1) {
                              cartBloc?.add(CartDecreaseCountClicked(data.id));
                            }
                          },
                          onIncreaseButtonClick: () {
                            cartBloc
                                ?.add(CartIncreaseCountButtonClicked(data.id));
                          },
                        );
                      } else {
                        return PriceInfo(
                          payablePrice: state.cartResponse.payablePrice,
                          totalPrice: state.cartResponse.totalPrice,
                          shippingCost: state.cartResponse.shippingCost,
                        );
                      }
                    },
                    itemCount: state.cartResponse.cartItems.length + 1,
                  ),
                ),
              );
            } else if (state is CartAuthRequired) {
              return EmptyView(
                message:
                    ('برای مشاهده سبد خرید خود ابتدا وارد حساب کاربری خود شوید'),
                callToAction: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ),
                    );
                  },
                  child: const Text('ورود به حساب کاربری'),
                ),
                image: SvgPicture.asset(
                  'assets/img/auth_required.svg',
                  width: 140,
                ),
              );
            } else if (state is CartEmpty) {
              return EmptyView(
                  message: 'سبد خرید شما خالی می باشد',
                  image: SvgPicture.asset(
                    'assets/img/empty_cart.svg',
                    width: 200,
                  ));
            } else {
              throw Exception('current cart state is not valid');
            }
          },
        ),
      ),
//------------------------------------------------------------------------------
//       ValueListenableBuilder<AuthInfo?>(
//         valueListenable: AuthRepository.authChangeNotifier,
//         builder: (context, authState, child) {
//           bool isAuthenticated =
//               authState != null && authState.accessToken.isNotEmpty;
//           return SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(isAuthenticated
//                     ? 'خوش امدید'
//                     : 'لطفا وارد حساب کاربری خود شوید'),
//                 isAuthenticated
//                     ? ElevatedButton(
//                         onPressed: () {
//                           authRepository.signOut();
//                         },
//                         child: const Text('خروج از حساب'))
//                     : ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context, rootNavigator: true).push(
//                               MaterialPageRoute(
//                                   builder: (context) => const AuthScreen()));
//                         },
//                         child: const Text('ورود')),
//                 ElevatedButton(
//                     onPressed: () async {
//                       await authRepository.refreshToken();
//                     },
//                     child: const Text('Refresh Token')),
//               ],
//             ),
//           );
//         },
//       ),
    );
  }
}
