import 'package:Sepetim/application/item_group/form/item_group_form_bloc.dart';
import 'package:Sepetim/domain/core/value_objects.dart';
import 'package:Sepetim/domain/item_group/item_group.dart';
import 'package:Sepetim/injection.dart';
import 'package:Sepetim/predefined_variables/helper_functions.dart';
import 'package:Sepetim/presentation/core/widgets/action_popups.dart';
import 'package:Sepetim/presentation/core/widgets/default_padding.dart';
import 'package:Sepetim/presentation/core/widgets/divider_default.dart';
import 'package:Sepetim/presentation/core/widgets/small_circular_progress_indicator.dart';
import 'package:Sepetim/presentation/home/item_group/form/widgets/save_button.dart';
import 'package:Sepetim/presentation/home/item_group/form/widgets/text_fields.dart';
import 'package:Sepetim/presentation/routes/router.gr.dart';
import 'package:Sepetim/presentation/sign_in/widgets/auth_failure_popups.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemGroupForm extends StatelessWidget {
  final UniqueId categoryId;
  final ItemGroup editedGroup;
  const ItemGroupForm({Key key, this.editedGroup, this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemGroupFormBloc>(
          create: (context) => getIt<ItemGroupFormBloc>()
            ..add(
              ItemGroupFormEvent.initialized(
                optionOf(editedGroup),
              ),
            ),
        ),
      ],
      child: BlocConsumer<ItemGroupFormBloc, ItemGroupFormState>(
        listener: (context, state) {
          state.groupFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) => failure.map(
                unexpected: (_) => serverErrorPopup(context),
                insufficientPermission: (_) =>
                    insufficientPermissionPopup(context),
                unableToUpdate: (_) => serverErrorPopup(context),
                networkException: (_) => networkExceptionPopup(context),
              ),
              (_) {
                ExtendedNavigator.of(context).popUntil((route) =>
                    route.settings.name == Routes.itemGroupOverviewPage);
              },
            ),
          );
        },
        builder: (context, state) => WillPopScope(
          onWillPop: () async {
            bool willPop = true;
            if (state.isChanged) {
              FocusScope.of(context).unfocus();
              discardChangesPopup(
                context,
                yesFunction: () {
                  ExtendedNavigator.of(context).pop();
                  ExtendedNavigator.of(context).pop();
                },
                noFunction: () {
                  ExtendedNavigator.of(context).pop();
                  willPop = false;
                },
              );
            }

            return willPop;
          },
          child: Scaffold(
              resizeToAvoidBottomPadding: false,
              appBar: AppBar(
                title: Text('Sepetim',
                    style: Theme.of(context).appBarTheme.textTheme.headline1),
              ),
              body: DefaultPadding(
                child: Form(
                  autovalidate: state.showErrorMessages,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        translate(context, 'add_a_group'),
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        translate(context, 'title'),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 18.0),
                      ),
                      const TitleTextField(),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (state.isSaving) ...[
                              SmallCircularProgressIndicator()
                            ],
                            const DividerDefault(),
                            SaveButton(
                              categoryId: categoryId,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
