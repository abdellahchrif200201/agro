part of 'chambres_bloc.dart';

abstract class ChambresEvent extends Equatable {
  const ChambresEvent();

  @override
  List<Object?> get props => [];
}

// get all chambres

class GetAllChambresEvent extends ChambresEvent {}

// refresh chambres

class RefreshChambresEvent extends ChambresEvent {}

// filtter by date

class FilterChambresByDateRange extends ChambresEvent {
  final DateTimeRange dateRange;

  const FilterChambresByDateRange({required this.dateRange});

  @override
  List<Object?> get props => [dateRange];
}

// filter by name

class SearchChambresEvent extends ChambresEvent {
  final String searchText;

  const SearchChambresEvent(this.searchText);

  @override
  List<Object?> get props => [searchText];
}

// filter

class FilterChambresEvent extends ChambresEvent {
  final String filterType;
  final bool? isAscending;

  const FilterChambresEvent({required this.filterType, this.isAscending});
}
