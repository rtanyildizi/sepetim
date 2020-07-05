import 'package:Sepetim/application/item_category/form/item_category_form_bloc.dart';
import 'package:Sepetim/predefined_variables/helper_functions.dart';
import 'package:Sepetim/presentation/core/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RoundedButton(
      width: screenWidthByScalar(context, 1.0),
      text: translate(
        context,
        'save',
      ),
      onPressed: () {
        context
            .bloc<ItemCategoryFormBloc>()
            .add(const ItemCategoryFormEvent.saved());
      },
    );
  }
}
