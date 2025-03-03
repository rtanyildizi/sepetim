import 'package:Sepetim/application/item_category/actor/item_category_actor_bloc.dart';
import 'package:Sepetim/application/item_category/selector/item_category_selector_bloc.dart';
import 'package:Sepetim/application/item_category/watcher/item_category_watcher_bloc.dart';
import 'package:Sepetim/domain/core/enums.dart';
import 'package:Sepetim/injection.dart';
import 'package:Sepetim/predefined_variables/colors.dart';
import 'package:Sepetim/predefined_variables/helper_functions.dart';
import 'package:Sepetim/presentation/core/widgets/action_popups.dart';
import 'package:Sepetim/presentation/core/widgets/boxes_image.dart';
import 'package:Sepetim/presentation/core/widgets/default_floating_action_button.dart';
import 'package:Sepetim/presentation/core/widgets/default_padding.dart';
import 'package:Sepetim/presentation/home/item_category/overview/widgets/item_category_card.dart';
import 'package:Sepetim/presentation/home/item_category/overview/widgets/search_field.dart';
import 'package:Sepetim/presentation/routes/router.gr.dart';
import 'package:Sepetim/presentation/sign_in/widgets/auth_failure_popups.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCategoryOverviewPage extends StatelessWidget {
  const ItemCategoryOverviewPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemCategoryWatcherBloc>(
          create: (context) => getIt<ItemCategoryWatcherBloc>()
            ..add(
              const ItemCategoryWatcherEvent.watchAllStarted(OrderType.date),
            ),
        ),
        BlocProvider<ItemCategoryActorBloc>(
          create: (context) => getIt<ItemCategoryActorBloc>(),
        ),
        BlocProvider<ItemCategorySelectorBloc>(
          create: (context) => getIt<ItemCategorySelectorBloc>(),
        ),
      ],
      child: BlocBuilder<ItemCategoryWatcherBloc, ItemCategoryWatcherState>(
        builder: (context, state) {
          return state.map(
            initial: (_) => buildInitial(context, _controller),
            loading: (_) => buildLoading(context, _controller),
            loadSuccess: (state) {
              return BlocListener<ItemCategoryActorBloc,
                  ItemCategoryActorState>(
                listener: (context, state) {
                  state.map(
                    initial: (_) {},
                    actionInProgress: (_) {
                      deletingPopup(context);
                    },
                    deleteFailure: (failure) {
                      ExtendedNavigator.of(context).pop();
                      failure.categoryFailure.maybeMap(
                        insufficientPermission: (_) =>
                            insufficientPermissionPopup(context),
                        networkException: (_) => networkExceptionPopup(context),
                        orElse: () => serverErrorPopup(context),
                      );
                    },
                    deleteSuccess: (_) {
                      ExtendedNavigator.of(context).popUntil((route) =>
                          route.settings.name == Routes.applicationContentPage);
                    },
                  );
                },
                child: Scaffold(
                  resizeToAvoidBottomPadding: false,
                  appBar: AppBar(
                    title: Text(
                      'Sepetim',
                      style: Theme.of(context).appBarTheme.textTheme.headline1,
                    ),
                  ),
                  body: DefaultPadding(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SearchField(
                          controller: _controller,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          translate(context, 'categories'),
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        if (state.categories.size > 0) ...[
                          Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 8.0,
                                      mainAxisSpacing: 8.0,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return ItemCategoryCard(
                                  key: Key(
                                      state.categories[index].uid.getOrCrash()),
                                  category: state.categories[index],
                                );
                              },
                              itemCount: state.categories.size,
                            ),
                          ),
                        ] else ...[
                          BoxesImage(
                            text: translate(context, 'categories_are_empty'),
                          ),
                        ]
                      ],
                    ),
                  ),
                  floatingActionButton: DefaultFloatingActionButton(
                    iconData: Icons.add,
                    onPressed: () {
                      ExtendedNavigator.of(context).push(
                        Routes.itemCategoryForm,
                      );
                    },
                  ),
                ),
              );
            },
            loadFailure: (_) => buildFailure(context),
          );
        },
      ),
    );
  }

  Scaffold buildFailure(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sepetim',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: DefaultPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidthByScalar(context, 0.8),
              child: Text(
                translate(context, 'please_report'),
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 6),
            reactiveErrorOutlineButton(
              categoryId: null,
              groupId: null,
              itemId: null,
              details: "The user can't watch her/his categories.",
              color: sepetimSmoothRed,
            ),
          ],
        ),
      ),
      floatingActionButton: DefaultFloatingActionButton(
        onPressed: () {},
        iconData: Icons.add,
      ),
    );
  }

  Scaffold buildLoading(
      BuildContext context, TextEditingController _controller) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Sepetim',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: DefaultPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SearchField(
              controller: _controller,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              translate(context, 'categories'),
              style: Theme.of(context).textTheme.headline1,
            ),
            const Expanded(
              child: Center(
                child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator()),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: DefaultFloatingActionButton(
        iconData: Icons.add,
        onPressed: () {},
      ),
    );
  }

  Scaffold buildInitial(
      BuildContext context, TextEditingController _controller) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Sepetim',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: DefaultPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SearchField(
              controller: _controller,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              translate(context, 'categories'),
              style: Theme.of(context).textTheme.headline1,
            ),
            Expanded(
              child: Center(child: Container()),
            ),
          ],
        ),
      ),
      floatingActionButton: DefaultFloatingActionButton(
        iconData: Icons.add,
        onPressed: () {},
      ),
    );
  }
}
