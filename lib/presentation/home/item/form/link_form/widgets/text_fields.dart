import 'package:Sepetim/domain/link_object/value_objects.dart';
import 'package:flutter/material.dart';

import 'package:Sepetim/application/item/form/item_form_bloc.dart';
import 'package:Sepetim/domain/core/value_objects.dart';
import 'package:Sepetim/predefined_variables/colors.dart';
import 'package:Sepetim/predefined_variables/helper_functions.dart';
import 'package:Sepetim/predefined_variables/text_styles.dart';

class LinkTitleTextField extends StatelessWidget {
  final ItemFormBloc formBloc;
  final TextEditingController textEditingController;
  const LinkTitleTextField({
    Key key,
    @required this.formBloc,
    @required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      cursorColor: sepetimGrey,
      textCapitalization: TextCapitalization.sentences,
      style: Theme.of(context).textTheme.subtitle1,
      decoration: InputDecoration(
        labelText: translate(context, 'enter_a_title'),
        counterText: "",
      ),
      onChanged: (value) {},
      maxLength: ShortTitle.maxLength,
      autocorrect: false,
      validator: (_) => ShortTitle(textEditingController.text).value.fold(
            (f) => f.maybeMap(
              empty: (_) => translate(context, 'empty_title'),
              exceedingLength: (_) =>
                  translate(context, 'title_exceeding_length'),
              multiLine: (_) => translate(context, 'title_multiline'),
              orElse: () => null,
            ),
            (_) => null,
          ),
    );
  }
}

class LinkUrlTextField extends StatelessWidget {
  final ItemFormBloc formBloc;
  final TextEditingController textEdiginController;
  const LinkUrlTextField({
    Key key,
    @required this.formBloc,
    @required this.textEdiginController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEdiginController,
      cursorColor: sepetimGrey,
      textCapitalization: TextCapitalization.sentences,
      style: Theme.of(context).textTheme.subtitle1,
      decoration: InputDecoration(
        counterStyle: robotoTextStyle(),
        labelText: translate(context, 'enter_a_url'),
      ),
      autocorrect: false,
      validator: (_) => Link(textEdiginController.text).value.fold(
            (f) => f.maybeMap(
              invalidUrl: (_) => translate(context, 'invalid_url'),
              orElse: () => null,
            ),
            (_) => null,
          ),
    );
  }
}
