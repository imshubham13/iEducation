import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:user/constant.dart';

Widget cachedNetworkImage(
  BuildContext context, {
  required String imageUrl,
}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.28,
    width: MediaQuery.of(context).size.width * 0.48,
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primarycolor),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) =>
          Center(child: CircularProgressIndicator(color: primarycolor)),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ),
  );
}
