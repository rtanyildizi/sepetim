import 'package:Sepetim/application/item_group/form/item_group_form_bloc.dart';
import 'package:Sepetim/domain/core/value_objects.dart';
import 'package:Sepetim/predefined_variables/helper_functions.dart';
import 'package:Sepetim/presentation/core/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveButton extends StatelessWidget {
  final UniqueId categoryId;

  const SaveButton({Key key, this.categoryId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      height: 35,
      width: screenWidthByScalar(context, 1.0),
      text: translate(
        context,
        'save',
      ),
      onPressed: () {
        if (!context.bloc<ItemGroupFormBloc>().state.isSaving) {
          context
              .bloc<ItemGroupFormBloc>()
              .add(ItemGroupFormEvent.saved(categoryId));
        }
      },
    );
  }
}
