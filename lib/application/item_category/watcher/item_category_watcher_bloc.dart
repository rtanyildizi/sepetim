import 'dart:async';

import 'package:Sepetim/domain/item_category/i_category_repository.dart';
import 'package:Sepetim/domain/item_category/item_category.dart';
import 'package:Sepetim/domain/item_category/item_category_failure.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:meta/meta.dart';

part 'item_category_watcher_event.dart';
part 'item_category_watcher_state.dart';

part 'item_category_watcher_bloc.freezed.dart';

@injectable
class ItemCategoryWatcherBloc
    extends Bloc<ItemCategoryWatcherEvent, ItemCategoryWatcherState> {
  final IItemCategoryRepository _categoryRepository;

  ItemCategoryWatcherBloc(this._categoryRepository);

  StreamSubscription<Either<ItemCategoryFailure, KtList<ItemCategory>>>
      _categoryStreamSubscription;

  @override
  ItemCategoryWatcherState get initialState =>
      const ItemCategoryWatcherState.initial();

  @override
  Stream<ItemCategoryWatcherState> mapEventToState(
    ItemCategoryWatcherEvent event,
  ) async* {
    yield* event.map(
      watchAllStarted: (e) async* {
        yield const ItemCategoryWatcherState.loadInProgress(isSearching: false);
        await _categoryStreamSubscription?.cancel();
        _categoryStreamSubscription = _categoryRepository
            .watchAll(e.orderType)
            .listen((failureOrCategories) => add($ItemCategoryWatcherEvent
                .categoriesReceived(failureOrCategories)));
      },
      watchAllByTitleStarted: (e) async* {
        //* Not sure if it's working
        /*if (e.title.trim() == null || e.title.trim() == '') {
          add(ItemCategoryWatcherEvent.watchAllStarted(e.orderType));
        }*/

        yield const ItemCategoryWatcherState.loadInProgress(isSearching: true);

        await _categoryStreamSubscription?.cancel();
        _categoryStreamSubscription = _categoryRepository
            .watchAllByTitle(e.orderType, e.title)
            .listen((failureOrCategories) => add($ItemCategoryWatcherEvent
                .categoriesReceived(failureOrCategories)));
      },
      categoriesReceived: (e) async* {
        yield e.failureOrCategories
            .fold((f) => ItemCategoryWatcherState.loadFailure(f), (categories) {
          print(categories.size);
          return ItemCategoryWatcherState.loadSuccess(categories);
        });
      },
    );
  }

  @override
  Future<void> close() async {
    await _categoryStreamSubscription?.cancel();
    return super.close();
  }
}
