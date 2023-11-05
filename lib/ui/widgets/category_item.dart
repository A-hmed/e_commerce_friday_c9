import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_friday_c9/data/model/response/category_dm.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final CategoryDM categoryDM;

  const CategoryItem({super.key, required this.categoryDM});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      //  margin: EdgeInsets.all(1),
      child: Column(
        children: [
          const Spacer(),
          CircleAvatar(
            radius: 30,
            backgroundImage: CachedNetworkImageProvider(
              categoryDM.image ?? "",
            ),
          ),
          const Spacer(),
          Text(
            categoryDM.name ?? "",
            textAlign: TextAlign.center,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
