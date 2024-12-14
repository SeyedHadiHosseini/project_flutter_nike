import 'package:flutter/material.dart';
import 'package:project_seven_nike_welcomeback/common/utils.dart';
import 'package:project_seven_nike_welcomeback/theme.dart';
import 'package:project_seven_nike_welcomeback/ui/cart/computing_cart_price.dart';

class PriceInfo extends StatelessWidget {
  final int payablePrice;
  final int shippingCost;
  final int totalPrice;

  const PriceInfo(
      {Key? key,
      required this.payablePrice,
      required this.shippingCost,
      required this.totalPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 8, 0),
          child: Text(
            'جزِییات خرید',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(8, 8, 8, 32),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.05),
              ),
            ],
          ),
          child: Column(
            children: [
              ComputingCartPrices(
                textComment: 'مبلغ کل خرید',
                textComputing: RichText(
                  text: TextSpan(
                    text: totalPrice.separateByComma,
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(color: LightThemeColor.secondaryTextColor),
                    children: const [
                      TextSpan(
                        text: ' تومان',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 1,
              ),
              ComputingCartPrices(
                textComment: 'هزینه ارسال',
                textComputing: Text(shippingCost.withPriceLabel),
              ),
              const Divider(
                height: 1,
              ),
              ComputingCartPrices(
                textComment: 'مبلغ قابل پرداخت',
                textComputing: RichText(
                  text: TextSpan(
                    text: payablePrice.separateByComma,
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: ' تومان',
                        style: DefaultTextStyle.of(context).style.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
