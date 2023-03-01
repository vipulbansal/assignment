import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vipul_assignment/home/home_bloc/home_bloc.dart';
import 'package:vipul_assignment/models/user_model.dart';

class HomeItem extends StatelessWidget {
  final UserModel userModel;
  final Function() setFavourite;

  const HomeItem(this.userModel, this.setFavourite, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(userModel.id),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: "https://robohash.org/${userModel.id}?100*100",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const SpinKitCircle(
                      color: Colors.grey,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: InkWell(
                      onTap: setFavourite,
                      child: Icon(
                        userModel.isFavourite
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${userModel.name}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              "${userModel.email}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
