part of 'item_bloc.dart';

abstract class ItemState extends Equatable {
  const ItemState();
}

class ItemInitial extends ItemState {
  @override
  List<Object> get props => [];
}

final class ItemLoading extends ItemState{
  @override
  List<Object> get props => [];
}

final class ItemLoaded extends ItemState{
  final List<ItemModel> itemModelList;
  const ItemLoaded({required this.itemModelList});
  @override
  List<Object> get props => [itemModelList];
}
final class ItemError extends ItemState{
  final String error;
  const ItemError({required this.error});
  @override
  List<Object> get props => [error];
}
final class ItemEmpty extends ItemState{
  @override
  List<Object> get props => [];
}
final class CategorySate extends ItemState{
  final List<CategoryModel> categoryModelList;
 const CategorySate({required this.categoryModelList});
  @override
  List<Object> get props => [categoryModelList];
}
final class CurrentCategoryState extends ItemState{
  final CategoryModel categoryModel;
  const CurrentCategoryState({required this.categoryModel});
  @override
  List<Object> get props => [categoryModel];
}
final class ItemSuccfullyDeletedState extends ItemState{
  final String success;
  const ItemSuccfullyDeletedState({required this.success});
  @override
  List<Object> get props => [success];
}
final class UpdateItemSuccessState extends ItemState{
  final String success;
  const UpdateItemSuccessState({required this.success});
  @override
  List<Object> get props => [success];
}

