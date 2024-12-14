import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ImagesLoadingService extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;



  const ImagesLoadingService({
    Key? key,
    required this.imageUrl, required this.borderRadius,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
    );
    if (borderRadius != null ) {
      return ClipRRect(
          borderRadius: borderRadius!,
          child: image
      );
    }else{
      return image;
    }


  }
}
