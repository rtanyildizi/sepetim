import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Sepetim/application/item/form/item_form_bloc.dart';
import 'package:Sepetim/domain/item/item.dart';
import 'package:Sepetim/domain/item_category/item_category.dart';
import 'package:Sepetim/domain/item_group/item_group.dart';
import 'package:Sepetim/predefined_variables/colors.dart';
import 'package:Sepetim/predefined_variables/helper_functions.dart';
import 'package:Sepetim/predefined_variables/text_styles.dart';
import 'package:Sepetim/presentation/routes/router.gr.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final ItemCategory category;
  final ItemGroup group;
  const ItemCard({
    Key key,
    @required this.item,
    @required this.category,
    @required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return item.failureOption.fold(
      () => cardSuccess(context),
      (a) => cardFailure(context),
    );
  }

  Container cardFailure(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: sepetimLightGrey,
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8.0,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: sepetimSmoothRed,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            height: 120,
            width: screenWidthByScalar(context, 1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 40,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 3.0,
                ),
                Text(
                  translate(context, 'something_went_wrong'),
                  style: robotoTextStyle(color: Colors.white),
                ),
                const SizedBox(height: 3.0),
                reactiveErrorOutlineButton(
                  categoryId: category.uid,
                  groupId: group.uid,
                  itemId: item.uid,
                  details:
                      "Quite likely there is a problem with the item's title, price, selectedIndex or imageUrls.",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector cardSuccess(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.bloc<ItemFormBloc>().add(ItemFormEvent.initialized(some(item)));
        ExtendedNavigator.of(context).push(
          Routes.itemPage,
          arguments: ItemPageArguments(
            formBloc: context.bloc<ItemFormBloc>(),
            category: category,
            group: group,
          ),
        );
      },
      child: Container(
        height: 160,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: sepetimLightGrey,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            coverImage(),
            informations(context),
            isFavorite(),
          ],
        ),
      ),
    );
  }

  Widget isFavorite() {
    return Padding(
      padding: const EdgeInsets.only(right: 22.0),
      child: Container(
        width: 20,
        child: item.isFavorite
            ? const Icon(
                Icons.favorite,
                color: Colors.redAccent,
              )
            : const Icon(
                Icons.favorite_border,
                color: sepetimLightGrey,
              ),
      ),
    );
  }

  Widget informations(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 4.0,
            ),
            Text(
              item.title.fittedString(maxLength: 14),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '${category.title.getOrCrash()}, ${group.title.getOrCrash()}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 14.0),
            ),
            Text(
              '${translate(context, 'price')}: ${item.price.fittedPrice(context)} ₺',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 14.0),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${translate(context, 'last_edited')}:\n${item.lastEditTime.toString().substring(0, 16)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 14.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget coverImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 22.0),
      child: Container(
        width: 90,
        height: 140,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: CachedNetworkImage(
          imageUrl: item.imageUrls
              .getOrCrash()[item.selectedIndex.getOrCrash()]
              .getOrCrash(),
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/default.png',
            width: 90,
            height: 160,
            fit: BoxFit.cover,
          ),
          width: 90,
          height: 160,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
