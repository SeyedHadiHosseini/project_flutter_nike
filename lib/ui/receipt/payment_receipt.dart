import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_seven_nike_welcomeback/common/utils.dart';
import 'package:project_seven_nike_welcomeback/data/repo/order_repository.dart';
import 'package:project_seven_nike_welcomeback/theme.dart';
import 'package:project_seven_nike_welcomeback/ui/receipt/bloc/payment_receipt_bloc.dart';

class PaymentReceiptScreen extends StatelessWidget {
  final int orderId;
  const PaymentReceiptScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('رسید پرداخت'),
      ),
      body: BlocProvider<PaymentReceiptBloc>(
        create: (context) => PaymentReceiptBloc(orderRepository)..add(PaymentReceiptStarted(orderId)),
        child: BlocBuilder<PaymentReceiptBloc, PaymentReceiptState>(
          builder: (context, state) {
            if (state is PaymentSuccess) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: themeData.dividerColor, width: 1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        Text(
                          state.paymentReceiptData.purchaseSuccess?'پرداخت با موفقیت انجام شد': 'پرداخ با موفقیت انجام نشد',
                          style: themeData.textTheme.titleLarge!
                              .apply(color: themeData.colorScheme.primary),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'وضعیت شفارش',
                              style: TextStyle(
                                  color: LightThemeColor.secondaryTextColor),
                            ),
                            Text(
                              state.paymentReceiptData.paymentStatus,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 32,
                          // ضخامت
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'مبلغ',
                              style: TextStyle(
                                  color: LightThemeColor.secondaryTextColor),
                            ),
                            Text(
                              state.paymentReceiptData.payablePrice.withPriceLabel,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      child: const Text('بازگشت به سبد خرید'))
                ],
              );
            } else if (state is PaymentReceiptError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else if (state is PaymentReceiptLoading) {
              return const Center(child: CupertinoActivityIndicator());
            } else {
              throw Exception('state is not supported!');
            }
          },
        ),
      ),
    );
  }
}
