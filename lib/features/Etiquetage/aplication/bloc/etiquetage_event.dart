part of 'etiquetage_bloc.dart';

sealed class EtiquetageEvent extends Equatable {
  const EtiquetageEvent();

  @override
  List<Object> get props => [];
}

class GetAllEtiquetageEvent extends EtiquetageEvent{}

class RefreshEtiquetageEvent extends EtiquetageEvent{}



class SearchEtiquetageEvent extends EtiquetageEvent{
  final String searchText;
  const SearchEtiquetageEvent({
    required this.searchText
  });
  @override
  List<Object> get props => [searchText];
}


class FilterEtiquetageByDateRangeEvent extends EtiquetageEvent {
  final DateTimeRange dateRange;

  const FilterEtiquetageByDateRangeEvent({required this.dateRange});

  @override
  List<Object> get props => [dateRange];
}


class FilterEtiquetageEvent extends EtiquetageEvent {
  final String filterType;
  final bool? isAscending;

  const FilterEtiquetageEvent({required this.filterType, this.isAscending});
}
