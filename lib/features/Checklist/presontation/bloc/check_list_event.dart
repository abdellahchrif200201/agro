part of 'check_list_bloc.dart';

sealed class CheckListEvent extends Equatable {
  const CheckListEvent();

  @override
  List<Object> get props => [];
}


// get all CheckList

class GetAllCheckListEvent extends CheckListEvent {}

// refresh CheckList

class RefreshCkeckListEvent extends CheckListEvent {}

class FilterCheckListByDateRangeEvent extends CheckListEvent {
  final DateTimeRange dateRange;

  const FilterCheckListByDateRangeEvent({required this.dateRange});

  @override
  List<Object> get props => [dateRange];
}

// filter by name

class SearchCheckListEvent extends CheckListEvent {
  final String searchText;

  const SearchCheckListEvent(this.searchText);

  @override
  List<Object> get props => [searchText];
}
// filter 


class FilterCheckListEvent extends CheckListEvent{
  final String filterType;
  final bool? isAscending;

  const FilterCheckListEvent({
    required this.filterType ,  this.isAscending
  });
}