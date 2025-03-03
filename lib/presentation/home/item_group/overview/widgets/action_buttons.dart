import 'package:Sepetim/application/item_group/actor/item_group_actor_bloc.dart';
import 'package:Sepetim/application/theme/theme_bloc.dart';
import 'package:Sepetim/domain/core/value_objects.dart';
import 'package:Sepetim/domain/item_group/item_group.dart';
import 'package:Sepetim/predefined_variables/colors.dart';
import 'package:Sepetim/predefined_variables/helper_functions.dart';
import 'package:Sepetim/presentation/core/widgets/action_popups.dart';
import 'package:Sepetim/presentation/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemGroupActionButtons extends StatelessWidget {
  final ItemGroup group;
  final UniqueId categoryId;
  const ItemGroupActionButtons({Key key, this.group, this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        ClipOval(
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: InkWell(
              splashColor: Theme.of(context).scaffoldBackgroundColor,
              onTap: () {
                deletePopup(
                  context,
                  title:
                      '${translate(context, 'delete_group_title')} ${group.title.getOrCrash()}',
                  message: translate(context, 'delete_group_message'),
                  action: () => context.bloc<ItemGroupActorBloc>().add(
                        ItemGroupActorEvent.deleted(categoryId, group),
                      ),
                );
              },
              child: SizedBox(
                  width: 26,
                  height: 26,
                  child: Icon(
                    Icons.delete_forever,
                    size: 22,
                    color:
                        context.bloc<ThemeBloc>().state.theme == AppTheme.light
                            ? sepetimGrey
                            : Colors.white,
                  )),
            ),
          ),
        ),
        ClipOval(
          child: Material(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: InkWell(
              splashColor: Theme.of(context).scaffoldBackgroundColor,
              onTap: () {
                ExtendedNavigator.of(context).push(
                  Routes.itemGroupForm,
                  arguments: ItemGroupFormArguments(
                    editedGroup: group,
                    categoryId: categoryId,
                  ),
                );
              },
              child: SizedBox(
                  width: 26,
                  height: 26,
                  child: Icon(
                    Icons.edit,
                    size: 22,
                    color:
                        context.bloc<ThemeBloc>().state.theme == AppTheme.light
                            ? sepetimGrey
                            : Colors.white,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
