import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final Widget? callToAction;
  final Widget image;

  const EmptyView(
      {Key? key,
      required this.message,
       this.callToAction,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image,
          const SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          // وقای شما یک فرمی دارید که کاربر میتونه فقط یک کار انجام بده بهش میگم CallToAction
          //اگر CallToAction مخالف با null بود بیا CallToAction رو نشون بده
          if (callToAction != null ) callToAction!
        ],
      ),
    );
  }
}
