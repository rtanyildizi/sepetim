import 'package:Sepetim/application/item/form/item_form_bloc.dart';
import 'package:Sepetim/domain/core/enums.dart';
import 'package:Sepetim/domain/item_category/item_category.dart';
import 'package:Sepetim/injection.dart';
import 'package:Sepetim/predefined_variables/colors.dart';
import 'package:Sepetim/predefined_variables/helper_functions.dart';
import 'package:Sepetim/presentation/core/widgets/boxes_image.dart';
import 'package:Sepetim/presentation/home/item/overview/widgets/item_card.dart';
import 'package:Sepetim/presentation/home/item/overview/widgets/search_field.dart';
import 'package:Sepetim/presentation/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Sepetim/application/item/watcher/item_watcher_bloc.dart';
import 'package:Sepetim/domain/item_group/item_group.dart';
import 'package:Sepetim/presentation/core/widgets/default_floating_action_button.dart';
import 'package:Sepetim/presentation/core/widgets/default_padding.dart';

class ItemOverviewPage extends StatelessWidget {
  final ItemCategory category;
  final ItemGroup group;
  final ItemWatcherBloc watcherBloc;
  const ItemOverviewPage({
    Key key,
    @required this.category,
    @required this.group,
    @required this.watcherBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemFormBloc>(
          create: (context) => getIt<ItemFormBloc>(),
        ),
      ],
      child: BlocBuilder<ItemWatcherBloc, ItemWatcherState>(
        cubit: watcherBloc,
        builder: (context, state) => state.map(
          initial: (_) => buildInitial(context, _controller),
          loading: (_) => buildLoading(context, _controller),
          loadSuccess: (state) {
            return WillPopScope(
              onWillPop: () async {
                watcherBloc.add(ItemWatcherEvent.watchAllStarted(
                    category.uid, group.uid, OrderType.date));
                await Future.delayed(const Duration(milliseconds: 50)); // ???
                return true;
              },
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Sepetim',
                    style: Theme.of(context).appBarTheme.textTheme.headline1,
                  ),
                ),
                body: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22.0, 16.0, 22.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SearchField(
                            categoryId: category.uid,
                            groupId: group.uid,
                            controller: _controller,
                            watcherBloc: watcherBloc,
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            '${translate(context, 'items')} - ${group.title.getOrCrash()}',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${translate(context, 'items_count')}: ${state.items.size}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 12.0),
                              ),
                              Text(
                                '${translate(context, 'total_price')}: ${totalItemsPrice(state.items).fittedPrice(context)} ₺',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (state.items.size > 0) ...[
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ItemCard(
                              item: state.items[index],
                              category: category,
                              group: group,
                              key: Key(state.items[index].uid.getOrCrash()),
                            );
                          },
                          itemCount: state.items.size,
                        ),
                      ),
                    ] else ...[
                      BoxesImage(text: translate(context, 'items_are_empty')),
                    ]
                  ],
                ),
                floatingActionButton: DefaultFloatingActionButton(
                  iconData: Icons.add,
                  onPressed: () {
                    ExtendedNavigator.of(context).push(
                      Routes.itemForm,
                      arguments: ItemFormArguments(
                        category: category,
                        group: group,
                        editedItem: null,
                      ),
                    );
                  },
                ),
              ),
            );
          },
          loadFailure: (_) => buildFailure(context),
        ),
      ),
    );
  }

  Scaffold buildFailure(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sepetim',
            style: Theme.of(context).appBarTheme.textTheme.headline1),
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
              categoryId: category.uid,
              groupId: group.uid,
              itemId: null,
              details: "The user can't watch her/his items.",
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
              categoryId: category.uid,
              groupId: group.uid,
              controller: _controller,
              watcherBloc: watcherBloc,
            ),
            const SizedBox(height: 12.0),
            Text(
              '${translate(context, 'items')} - ${group.title.getOrCrash()}',
              style: Theme.of(context).textTheme.headline1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${translate(context, 'items_count')}:...',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 12.0),
                ),
                Text(
                  '${translate(context, 'total_price')}:...',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 12.0),
                ),
              ],
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
        onPressed: () {},
        iconData: Icons.add,
      ),
    );
  }

  Scaffold buildInitial(
      BuildContext context, TextEditingController _controller) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sepetim',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: DefaultPadding(
        child: Column(
          children: <Widget>[
            SearchField(
              categoryId: category.uid,
              groupId: group.uid,
              controller: _controller,
              watcherBloc: watcherBloc,
            ),
            const SizedBox(height: 12.0),
            Text(
              '${translate(context, 'items')} - ${group.title.getOrCrash()}',
              style: Theme.of(context).textTheme.headline1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${translate(context, 'items_count')}:...',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 12.0),
                ),
                Text(
                  '${translate(context, 'total_price')}:...',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 12.0),
                ),
              ],
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
}
