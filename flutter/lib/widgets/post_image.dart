import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sample/models/post.dart';

class PostImage extends StatelessWidget {
  final Post post;
  final BoxFit fit;

  const PostImage({
    Key key,
    @required this.post,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: post.imageUrl,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, imageUrl) =>
          Center(child: CircularProgressIndicator()),
    );
  }
}
