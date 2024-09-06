import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:devti_agro/core/error/failures.dart';
import 'package:devti_agro/features/Fournisseur/domain/entities/Fournisseur.dart';


/// Abstract repository interface for fetching zones.
abstract class FournisseurRepo {
  /// Fetches all zones associated with a specific enterprise ID.
  ///
  /// Takes an [idEntreprise] as a parameter.
  /// Returns an [Either] containing a [Failure] on error or a list of [Zone] objects on success.
  Future<Either<Failure, List<Fournisseur>>> getAllFournisseur();
}