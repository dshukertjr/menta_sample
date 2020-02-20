import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sample/models/user.dart';

class ProfileImage extends StatelessWidget {
  final double size;
  final User user;
  final void Function() onTap;

  const ProfileImage({
    Key key,
    this.size = 50,
    @required this.user,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
        child: Material(
          child: InkWell(
            onTap: onTap,
            child: user?.imageUrl == null
                ? _NoImage(size)
                : CachedNetworkImage(
                    imageUrl: user.imageUrl,
                    placeholder: (context, imageUrl) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, imageUrl, err) => _NoImage(size),
                  ),
          ),
        ),
      ),
    );
  }
}

class _NoImage extends StatelessWidget {
  final double size;

  const _NoImage(this.size, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: Colors.grey,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Transform.translate(
          offset: Offset(0, size / 5),
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: size,
          ),
        ),
      ),
    );
  }
}
