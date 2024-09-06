import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/features/Fournisseur/aplication/usecase/Fournisseur_use_case.dart';
import 'package:devti_agro/features/Fournisseur/domain/entities/Fournisseur.dart';
import 'package:equatable/equatable.dart';
import 'package:devti_agro/core/error/failures.dart';

// Define events
part 'Fournisseur_event.dart';

// Define states
part 'Fournisseur_state.dart';

class FournisseurBloc extends Bloc<FournisseurEvent, FournisseurState> {
  final FournisseurUseCase fournisseurUseCase;

  FournisseurBloc({required this.fournisseurUseCase}) : super(FournisseurInitial()) {
    on<GetAllFournisseurEvent>(_onGetAllFournisseur);
  }

  Future<void> _onGetAllFournisseur(
    GetAllFournisseurEvent event,
    Emitter<FournisseurState> emit,
  ) async {
    emit(LoadingFournisseurState());

    final failureOrFournisseur = await fournisseurUseCase.call();
    emit(_mapFailureOrFournisseurToState(failureOrFournisseur));
  }

  FournisseurState _mapFailureOrFournisseurToState(
    Either<Failure, List<Fournisseur>> either,
  ) {
    return either.fold(
      (failure) => ErrorFournisseurState(message: _mapFailureToMessage(failure)),
      (fournisseur) => LoadedFournisseurState(fournisseurs: fournisseur),
    );
  }


  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server Failure';
    } else if (failure is OfflineFailure) {
      return 'Offline Failure';
    } else {
      print('Unknown Failure: ${failure.runtimeType}');
      return 'Unexpected Error';
    }
  }
}
