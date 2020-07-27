import 'package:Sepetim/application/item/form/item_form_bloc.dart';
import 'package:Sepetim/predefined_variables/colors.dart';
import 'package:Sepetim/predefined_variables/helper_functions.dart';
import 'package:Sepetim/predefined_variables/text_styles.dart';
import 'package:Sepetim/presentation/core/widgets/default_padding.dart';
import 'package:Sepetim/presentation/sign_in/widgets/auth_failure_popups.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:Sepetim/domain/item_category/item_category.dart';
import 'package:Sepetim/domain/item_group/item_group.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

class ItemPage extends StatelessWidget {
  final ItemCategory category;
  final ItemGroup group;
  final ItemFormBloc formBloc;
  const ItemPage({
    Key key,
    @required this.category,
    @required this.group,
    @required this.formBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemFormBloc, ItemFormState>(
      bloc: formBloc,
      listener: (context, state) {
        state.itemFailureOrSuccessOption.fold(
          () {},
          (either) {
            either.fold(
              (failure) {
                failure.maybeMap(
                  imageLoadCanceled: (_) {},
                  networkException: (_) => networkExceptionPopup(context),
                  orElse: () => serverErrorPopup(context),
                );
              },
              (_) {},
            );
          },
        );
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text('Sepetim', style: robotoTextStyle(bold: true)),
        ),
        body: DefaultPadding(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(state.item.title.getOrCrash(),
                    style: robotoTextStyle(bold: true, fontSize: 24.0)),
                const SizedBox(
                  height: 10.0,
                ),
                catalog(state, context),
                const SizedBox(
                  height: 10.0,
                ),
                Text(translate(context, 'description'),
                    style: robotoTextStyle(bold: true, fontSize: 24.0)),
                const SizedBox(
                  height: 10.0,
                ),
                Scrollbar(
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 150),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(4.0),
                    color: Colors.yellow[50],
                    child: SingleChildScrollView(
                      child: Text(state.item.description.getOrCrash(),
                          style: didactGothicTextStyle(bold: true)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container catalog(ItemFormState state, BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: sepetimLightGrey,
        ))),
        height: 150 * 1.5,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            coverImage(context, state),
            informations(context, state),
            isFavorite(state)
          ],
        ));
  }

  Widget coverImage(BuildContext context, ItemFormState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 90 * 1.5,
            height: 140 * 1.5,
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
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/default.png',
                width: 90,
                height: 160,
                fit: BoxFit.cover,
              ),
              imageUrl: state.item.imageUrls
                  .getOrCrash()[state.item.selectedIndex.getOrCrash()]
                  .getOrCrash(),
              width: 90,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 30,
            padding: const EdgeInsets.only(bottom: 3),
            child: FlatButton(
              onPressed: () {
                formBloc.add(ItemFormEvent.saved(category.uid, group.uid));
              },
              color: Colors.black.withOpacity(0.3),
              child: Text(translate(context, 'set_as_cover'),
                  style: robotoTextStyle(color: Colors.white, fontSize: 11.0)),
            ),
          )
        ],
      ),
    );
  }

  Widget informations(BuildContext context, ItemFormState state) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 38,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      formBloc.add(ItemFormEvent.selectedIndexChanged(
                        index,
                      ));
                    },
                    child: circularItemView(state, index: index),
                  );
                },
                itemCount: state.item.imageUrls.getOrCrash().size,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
              ),
            ),
            RichText(
              text: TextSpan(
                style: didactGothicTextStyle(fontSize: 15.0),
                children: [
                  TextSpan(
                    text: '${translate(context, 'category')}: ',
                    style: didactGothicTextStyle(bold: true),
                  ),
                  TextSpan(
                    text: category.title.getOrCrash(),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: didactGothicTextStyle(fontSize: 15.0),
                children: [
                  TextSpan(
                    text: '${translate(context, 'group')}: ',
                    style: didactGothicTextStyle(bold: true),
                  ),
                  TextSpan(
                    text: group.title.getOrCrash(),
                  )
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: didactGothicTextStyle(fontSize: 15.0),
                children: [
                  TextSpan(
                    text: '${translate(context, 'price')}: ',
                    style: didactGothicTextStyle(bold: true),
                  ),
                  TextSpan(
                    text: '${state.item.price.getOrCrash().toString()}₺',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget isFavorite(ItemFormState state) {
    return Container(
      width: 30,
      child: GestureDetector(
        onTap: () => formBloc
            .add(ItemFormEvent.isFavoriteChanged(category.uid, group.uid)),
        child: state.item.isFavorite
            ? Icon(
                Icons.favorite,
                color: Colors.redAccent,
              )
            : Icon(
                Icons.favorite_border,
                color: sepetimLightGrey,
              ),
      ),
    );
  }

  Widget circularItemView(
    ItemFormState state, {
    @required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: CachedNetworkImage(
              imageUrl: state.item.imageUrls.getOrCrash()[index].getOrCrash(),
              placeholder: (context, url) =>
                  CircleAvatar(backgroundColor: Colors.white, radius: 16),
              imageBuilder: (context, image) =>
                  CircleAvatar(backgroundImage: image, radius: 16),
            ),
          ),
        ],
      ),
    );
  }
}
