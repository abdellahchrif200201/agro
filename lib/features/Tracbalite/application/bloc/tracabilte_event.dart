part of 'tracabilte_bloc.dart';

sealed class TracabilteEvent extends Equatable {
  const TracabilteEvent();

  @override
  List<Object> get props => [];
}
// get all tracabilite

class GetAllTracabiliteEvent extends TracabilteEvent{}

// refresh tracabilite

class RefreshTracabilteEvent extends TracabilteEvent{}


class FilterTracabilteByDateRangeEvent extends TracabilteEvent {
  final DateTimeRange dateRange;

  const FilterTracabilteByDateRangeEvent({required this.dateRange});

  @override
  List<Object> get props => [dateRange];
}

// filter by name

class SearchTracabilteEvent extends TracabilteEvent {
  final String searchText;

  const SearchTracabilteEvent(this.searchText);

  @override
  List<Object> get props => [searchText];
}

class FilterTracabilteEvent extends TracabilteEvent {
  final String filterType;
  final bool? isAscending;

  const FilterTracabilteEvent({required this.filterType, this.isAscending});
}
