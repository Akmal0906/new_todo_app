part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();
}

final class TakeItemsEvent extends ItemEvent {
  @override
  List<Object?> get props => [];
}

final class TakeCategoryEvent extends ItemEvent {
  @override
  List<Object?> get props => [];
}

final class TakeCurrentCategoryEvent extends ItemEvent {
  final String id;

  const TakeCurrentCategoryEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

final class DeleteIdItemEvent extends ItemEvent{
  final int id;
  const DeleteIdItemEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

final class UdateItemEvent extends ItemEvent{
  final ItemModel itemModel;
  const UdateItemEvent({required this.itemModel});
  @override
  List<Object?> get props => [itemModel];
}
