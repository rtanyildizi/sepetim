import 'package:Sepetim/application/item_category/actor/item_category_actor_bloc.dart';
import 'package:Sepetim/application/item_category/selector/item_category_selector_bloc.dart';
import 'package:Sepetim/application/item_category/watcher/item_category_watcher_bloc.dart';
import 'package:Sepetim/domain/core/enums.dart';
import 'package:Sepetim/injection.dart';
import 'package:Sepetim/predefined_variables/helper_functions.dart';
import 'package:Sepetim/predefined_variables/text_styles.dart';
import 'package:Sepetim/presentation/core/widgets/action_popup.dart';
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
            initial: (_) => Scaffold(
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
            ),
            loading: (_) => Scaffold(
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
            ),
            loadSuccess: (state) {
              return BlocListener<ItemCategoryActorBloc,
                  ItemCategoryActorState>(
                listener: (context, state) {
                  state.map(
                    initial: (_) {},
                    actionInProgress: (_) {
                      actionPopup(
                        context,
                        backgroundColor: Colors.white,
                        content: Text('${translate(context, 'deleting')}...'),
                        barrierDismissible: false,
                      );
                    },
                    deleteFailure: (failure) {
                      ExtendedNavigator.of(context).pop();
                      failure.categoryFailure.maybeMap(
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
                      ],
                    ),
                  ),
                  floatingActionButton: DefaultFloatingActionButton(
                    iconData: Icons.add,
                    onPressed: () {
                      ExtendedNavigator.of(context).pushNamed(
                        Routes.itemCategoryForm,
                      );
                    },
                  ),
                ),
              );
            },
            loadFailure: (_) => Scaffold(
              appBar: AppBar(
                title: Text(
                  'Sepetim',
                  style: Theme.of(context).appBarTheme.textTheme.headline1,
                ),
              ),
              body: DefaultPadding(
                child: Center(
                  child: Container(
                    width: screenWidthByScalar(context, 0.8),
                    child: Text(
                      translate(context, 'please_report'),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
              floatingActionButton: DefaultFloatingActionButton(
                onPressed: () {},
                iconData: Icons.add,
              ),
            ),
          );
        },
      ),
    );
  }
}
