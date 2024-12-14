import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_seven_nike_welcomeback/data/order.dart';
import 'package:project_seven_nike_welcomeback/data/repo/order_repository.dart';
import 'package:project_seven_nike_welcomeback/ui/cart/price_info.dart';
import 'package:project_seven_nike_welcomeback/ui/payment_webview/payment_webview.dart';
import 'package:project_seven_nike_welcomeback/ui/receipt/payment_receipt.dart';
import 'package:project_seven_nike_welcomeback/ui/shipping/bloc/shipping_bloc.dart';
import 'package:project_seven_nike_welcomeback/ui/shipping/receiver_delivery_cart.dart';

class ShippingScreen extends StatefulWidget {
  final int payablePrice;
  final int shippingCost;
  final int totalPrice;

  const ShippingScreen({
    Key? key,
    required this.payablePrice,
    required this.shippingCost,
    required this.totalPrice,
  }) : super(key: key);

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final TextEditingController firstNameController =
      TextEditingController(text: 'سعید');

  final TextEditingController lastNameController =
      TextEditingController(text: 'شاهینی');

  final TextEditingController phoneNumberController =
      TextEditingController(text: '12345678901'); // باید 11 کاراکتر باشد

  final TextEditingController postalCodeController =
      TextEditingController(text: '1234567890'); // باید 10 کاراکتر باشد

  final TextEditingController addressController = TextEditingController(
      text:
          'sjancakscka,cnaljwqljzlajndlajnclajnlcljank'); // باید حداقل 20 کاراکتر باشد
  StreamSubscription? subscription;

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تحویل گیرنده',
        ),
        centerTitle: false,
      ),
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = ShippingBloc(orderRepository);
          subscription = bloc.stream.listen((event) {
            if (event is ShippingSuccess) {
              if (event.data.bankGatewayUrl.isNotEmpty) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PaymentGatewayScreen(
                        bankGatewayUrl: event.data.bankGatewayUrl)));
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    //result
                    builder: (context) => PaymentReceiptScreen(
                      orderId: event.data.orderId,
                    ),
                  ),
                );
              }
            } else if (event is ShippingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(event.appException.message),
                ),
              );
            }
          });
          return bloc;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReceiverDeliveryCart(
                  controller: firstNameController, text: 'نام'),
              const SizedBox(height: 3),
              ReceiverDeliveryCart(
                  controller: lastNameController, text: 'نام خانوادگی'),
              const SizedBox(height: 3),
              ReceiverDeliveryCart(
                  controller: phoneNumberController, text: 'شماره همراه'),
              const SizedBox(height: 3),
              ReceiverDeliveryCart(
                  controller: postalCodeController, text: 'کد پستی'),
              const SizedBox(height: 3),
              ReceiverDeliveryCart(controller: addressController, text: 'آدرس'),
              const SizedBox(height: 3),
              PriceInfo(
                  payablePrice: widget.payablePrice,
                  shippingCost: widget.shippingCost,
                  totalPrice: widget.totalPrice),
              const SizedBox(height: 12),
              BlocBuilder<ShippingBloc, ShippingState>(
                builder: (context, state) {
                  return state is ShippingLoading
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  BlocProvider.of<ShippingBloc>(context).add(
                                    ShippingCreateOrder(
                                      CreateOrderParams(
                                        firstNameController.text,
                                        lastNameController.text,
                                        phoneNumberController.text,
                                        addressController.text,
                                        PaymentMethod.cashOnDelivery,
                                        postalCodeController.text,
                                      ),
                                    ),
                                  );
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => const PaymentReceiptScreen()));
                                },
                                child: const Text('پرداخت در محل')),
                            const SizedBox(width: 16),
                            ElevatedButton(
                                onPressed: () {
                                  BlocProvider.of<ShippingBloc>(context).add(
                                    ShippingCreateOrder(
                                      CreateOrderParams(
                                        firstNameController.text,
                                        lastNameController.text,
                                        phoneNumberController.text,
                                        addressController.text,
                                        PaymentMethod.online,
                                        postalCodeController.text,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('پرداخت اینترنتی')),
                          ],
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
//-------------------------------------------------------------------------------
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project_seven_nike/data/order.dart';
// import 'package:project_seven_nike/data/repo/cart_repository.dart';
// import 'package:project_seven_nike/data/repo/order_repository.dart';
// import 'package:project_seven_nike/ui/cart/price_info.dart';
// import 'package:project_seven_nike/ui/receipt/payment_receipt.dart';
// import 'package:project_seven_nike/ui/shipping/bloc/shipping_bloc.dart';
// import 'package:project_seven_nike/ui/shipping/receiver_delivery_cart.dart';
//
//
//
// class ShippingScreen extends StatelessWidget {
//   final int payablePrice;
//   final int shippingCost;
//   final int totalPrice;
//   final TextEditingController firstNameController =
//   TextEditingController(text: 'سید هادی');
//   final TextEditingController lastNameController =
//   TextEditingController(text: 'حسینی');
//   final TextEditingController phoneNumberController =
//   TextEditingController(text: '123456789');
//   final TextEditingController postalCodeController =
//   TextEditingController(text: '987654321');
//   final TextEditingController addressController =
//   TextEditingController(text: 'کرمان سلمان فارسی');
//   StreamSubscription? subscription;
//
//
//   ShippingScreen(
//       {Key? key,
//         required this.payablePrice,
//         required this.shippingCost,
//         required this.totalPrice,
//         required this.subscription})
//       : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'تحویل گیرنده',
//         ),
//         centerTitle: false,
//       ),
//       body: BlocProvider<ShippingBloc>(
//         create: (context) {
//           final bloc = ShippingBloc(orderRepository);
//           subscription =  bloc.stream.listen((event) {
//             if (event is ShippingError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(event.appException.message),
//                 ),
//               );
//             } else if (event is ShippingSuccess) {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const PaymentReceiptScreen()));
//             }
//           });
//           return bloc;
//         },
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ReceiverDeliveryCart(
//                   controller: firstNameController, text: 'نام'),
//               const SizedBox(height: 3),
//               ReceiverDeliveryCart(
//                   controller: lastNameController, text: ' نام خانوادگی'),
//               const SizedBox(height: 3),
//               ReceiverDeliveryCart(
//                   controller: phoneNumberController, text: 'شماره تماس'),
//               const SizedBox(height: 3),
//               ReceiverDeliveryCart(
//                   controller: postalCodeController, text: 'کد پستی'),
//               const SizedBox(height: 3),
//               ReceiverDeliveryCart(controller: addressController, text: 'آدرس'),
//               const SizedBox(height: 3),
//               PriceInfo(
//                   payablePrice: payablePrice,
//                   shippingCost: shippingCost,
//                   totalPrice: totalPrice),
//               const SizedBox(height: 12),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   OutlinedButton(
//                       onPressed: () {
//                         BlocProvider.of<ShippingBloc>(context).add(
//                           ShippingCreateOrder(
//                             CreateOrderParams(
//                               firstNameController.text,
//                               lastNameController.text,
//                               phoneNumberController.text,
//                               addressController.text,
//                               PaymentMethod.cashOnDelivery,
//                               postalCodeController.text,
//                             ),
//                           ),
//                         );
//                         // Navigator.of(context).push(MaterialPageRoute(
//                         //     builder: (context) => const PaymentReceiptScreen()));
//                       },
//                       child: const Text('پرداخت در محل')),
//                   const SizedBox(width: 16),
//                   ElevatedButton(
//                       onPressed: () {}, child: const Text('پرداخت اینترنتی')),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
