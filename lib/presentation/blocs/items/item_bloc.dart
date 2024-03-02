import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/network/api.dart';
import '../../../domain/models/categories_model/category_model.dart';
import '../../../domain/models/items_model/item_model.dart';

part 'item_event.dart';

part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final FetchData fetchData;

  ItemBloc({required this.fetchData}) : super(ItemInitial()) {
    on<TakeItemsEvent>(_takeAllItems);
    on<TakeCategoryEvent>(_takeAllCategory);
    on<TakeCurrentCategoryEvent>(_takeCurrentCategory);
    on<DeleteIdItemEvent>(_deleteIdItem);
    on<UdateItemEvent>(_updateIdItem);
  }

  void _takeAllItems(TakeItemsEvent event, Emitter<ItemState> emit) async {
    emit(ItemLoading());
    final List<ItemModel>? list = await fetchData.getAllTask1('');
    print('BLOC LIST=${list}');
    switch (list) {
      case null:
        emit(const ItemError(
          error: 'Something went wrong',
        ));
        break;
      default:
        emit(ItemLoaded(itemModelList: list));
        break;
    }
  }

  void _takeAllCategory(
      TakeCategoryEvent event, Emitter<ItemState> emit) async {
    emit(ItemLoading());
    final List<CategoryModel>? list = await fetchData.getAllCategory('');
    print('BLOC LIST=${list}');
    switch (list) {
      case null:
        emit(const ItemError(
          error: 'Something went wrong',
        ));
        break;
      default:
        emit(CategorySate(categoryModelList: list));
        break;
    }
  }

  void _takeCurrentCategory(
      TakeCurrentCategoryEvent event, Emitter<ItemState> emit) async {
    emit(ItemLoading());
    final CategoryModel? categoryModel =
        await fetchData.getCurrentCategory(event.id);

    switch (categoryModel) {
      case null:
        emit(const ItemError(
          error: 'Something went wrong',
        ));
        break;
      default:
        emit(CurrentCategoryState(categoryModel: categoryModel));
        break;
    }
  }

  void _deleteIdItem(DeleteIdItemEvent event, Emitter<ItemState> emit) async {
    emit(ItemLoading());
    final String? isSuccess = await fetchData.deleteIdTask(event.id);
    if (isSuccess != null) {
      emit(ItemSuccfullyDeletedState(success: isSuccess));
      emit(ItemLoading());
      final List<ItemModel>? list = await fetchData.getAllTask1('');
      switch (list) {
        case null:
          emit(const ItemError(
            error: 'Something went wrong',
          ));
          break;
        default:
          emit(ItemLoaded(itemModelList: list));
          break;
      }
    }
  }

  void _updateIdItem(UdateItemEvent event, Emitter<ItemState> emit) async {
    emit(ItemLoading());
    final String? isSuccess = await fetchData.updateIdTask(event.itemModel);
    if (isSuccess != null) {
      emit(UpdateItemSuccessState(success: isSuccess));
      emit(ItemLoading());
      final List<ItemModel>? list = await fetchData.getAllTask1('');
      switch (list) {
        case null:
          emit(const ItemError(
            error: 'Something went wrong',
          ));
          break;
        default:
          emit(ItemLoaded(itemModelList: list));
          break;
      }
    }else{
      emit(const ItemError(error: 'Someting went wrong'));
    }
  }
}
