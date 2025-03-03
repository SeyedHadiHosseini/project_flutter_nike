import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_seven_nike_welcomeback/common/utils.dart';
import 'package:project_seven_nike_welcomeback/data/cart_item.dart';
import 'package:project_seven_nike_welcomeback/ui/widgets/images.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.data,
    required this.onDeleteButtonClick, required this.onIncreaseButtonClick, required this.onDecreaseButtonClick,
  }) : super(key: key);

  final CartItemData data;
  final GestureTapCallback onDeleteButtonClick;
  final GestureTapCallback onIncreaseButtonClick;
  final GestureTapCallback onDecreaseButtonClick;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: ImagesLoadingService(
                    imageUrl: data.product.imageUrl,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.product.title,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('تعداد'),
                    Row(
                      children: [
                        IconButton(
                          onPressed: onIncreaseButtonClick,
                          icon: const Icon(CupertinoIcons.plus_rectangle),
                        ),
                        data.changeCountLoading ? CupertinoActivityIndicator(color: Theme.of(context).colorScheme.onBackground,) : Text(
                          data.count.toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        IconButton(
                          onPressed: onDecreaseButtonClick,
                          icon: const Icon(CupertinoIcons.minus_rectangle),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.product.previousPrice.withPriceLabel,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(decoration: TextDecoration.lineThrough),
                    ),
                    Text(data.product.price.withPriceLabel),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          data.deleteButtonLoading
              ? const SizedBox(
                  height: 48,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ))
              : TextButton(
                  onPressed: onDeleteButtonClick ,
                  child: const Text('حذف از سبد خرید'),
                ),
        ],
      ),
    );
  }
}
