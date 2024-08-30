part of 'nutrition_bloc.dart';

sealed class NutritionEvent extends Equatable {
  const NutritionEvent();

  @override
  List<Object> get props => [];
}
// get all tracabilite

class GetAllNutritionEvent extends NutritionEvent{}

// refresh tracabilite

class RefreshNutritionEvent extends NutritionEvent{}


// class FilterTracabilteByDateRangeEvent extends NutritionEvent {
//   final DateTimeRange dateRange;

//   const FilterTracabilteByDateRangeEvent({required this.dateRange});

//   @override
//   List<Object> get props => [dateRange];
// }

// filter by name

// class SearchNutritionEvent extends NutritionEvent {
//   final String searchText;

//   const SearchNutritionEvent(this.searchText);

//   @override
//   List<Object> get props => [searchText];
// }

// class FilterNutritionEvent extends NutritionEvent {
//   final String filterType;
//   final bool? isAscending;

//   const FilterNutritionEvent({required this.filterType, this.isAscending});
// }
