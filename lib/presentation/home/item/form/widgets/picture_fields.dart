import 'package:Sepetim/domain/core/value_objects.dart';
import 'package:Sepetim/presentation/core/widgets/action_popup.dart';
import 'package:Sepetim/presentation/core/widgets/buttons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:Sepetim/application/item/form/item_form_bloc.dart';
import 'package:Sepetim/predefined_variables/helper_functions.dart';

class PictureFields extends StatelessWidget {
  const PictureFields({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemFormBloc, ItemFormState>(
      listener: (context, state) => null,
      builder: (context, state) {
        return Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                height: 160,
                width: screenWidthByScalar(context, 1),
                child: Center(
                  child: BlocBuilder<ItemFormBloc, ItemFormState>(
                    builder: (context, state) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: () async {
                                await imagePickerPopup(context,
                                    imageIndex: index);
                              },
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  if (state.isPictureRemoved[index]) ...[
                                    defaultImage(),
                                  ] else ...[
                                    getItemImage(context, state, index),
                                  ],
                                  if ((state.item.imageUrls
                                                  .getOrCrash()[index]
                                                  .getOrCrash() !=
                                              ImageUrl.defaultUrl()
                                                  .getOrCrash() ||
                                          state.temporaryImageFiles[index]
                                              .isSome()) &&
                                      !state.isPictureRemoved[index]) ...[
                                    deleteImageButton(context, index)
                                  ]
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: state.item.imageUrls.getOrCrash().size,
                        scrollDirection: Axis.horizontal,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  GestureDetector deleteImageButton(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        context.bloc<ItemFormBloc>().add(
              ItemFormEvent.pictureRemoved(index),
            );
      },
      child: Icon(
        Icons.close,
        color: Colors.grey[400],
        size: 20,
      ),
    );
  }

  Container getItemImage(BuildContext context, ItemFormState state, int index) {
    return Container(
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
      child: state.temporaryImageFiles[index].fold(
        () => CachedNetworkImage(
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/default.png',
            width: 90,
            height: 160,
            fit: BoxFit.cover,
          ),
          placeholder: (context, url) => Container(
            color: Colors.white,
            width: 90,
            height: 160,
            child: const Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xFFEEEEEE)),
                  strokeWidth: 2.0,
                ),
              ),
            ),
          ),
          imageUrl: state.item.imageUrls.getOrCrash()[index].getOrCrash(),
          width: 90,
          height: 160,
          fit: BoxFit.cover,
        ),
        (imageFile) => Image.file(
          imageFile,
          width: 90,
          height: 160,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container defaultImage() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Image.asset(
        'assets/images/default.png',
        width: 90,
        height: 160,
        fit: BoxFit.cover,
      ),
    );
  }
}

Future imagePickerPopup(
  BuildContext context, {
  @required int imageIndex,
}) async {
  return actionPopup(
    context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    title: Column(
      children: <Widget>[
        Text(
          translate(context, 'upload_image'),
          style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16.0),
        ),
        const SizedBox(
          height: 10,
        ),
        RoundedIconButton(
          onPressed: () {
            ExtendedNavigator.of(context).pop();
            context.bloc<ItemFormBloc>().add(
                  ItemFormEvent.pictureChanged(
                    imageIndex,
                    ImageSource.camera,
                  ),
                );
          },
          text: translate(context, 'from_camera'),
          width: screenWidthByScalar(context, 0.5),
          iconData: Icons.camera_alt,
        ),
        RoundedIconButton(
          width: screenWidthByScalar(context, 0.5),
          onPressed: () {
            ExtendedNavigator.of(context).pop();
            context.bloc<ItemFormBloc>().add(
                  ItemFormEvent.pictureChanged(
                    imageIndex,
                    ImageSource.gallery,
                  ),
                );
          },
          text: translate(context, 'from_gallery'),
          iconData: Icons.image,
        ),
      ],
    ),
  );
}
