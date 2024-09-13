import 'package:devti_agro/features/Fournisseur/domain/entities/Fournisseur.dart';
import 'package:devti_agro/features/user/domain/entities/user.dart';


class ColieData {
  int id;
  String? referenceColie;
  int? idUser;
  String? etat;
  String? statut;
  String? raison;
  int? idFournisseur;
  int? idDestinataire;
  int? quantiteApresTraitement;
  int? quantiteAvantTraitement;
  int? quantiteRetour;
  int? quantiteSortie;
  String? motif;
  DateTime? createdAt;
  double? prix;
  User? destinataire;
  Fournisseur? fournisseur;

  ColieData({
    required this.id,
    this.referenceColie,
    this.idUser,
    this.etat,
    this.statut,
    this.raison,
    this.idFournisseur,
    this.idDestinataire,
    this.quantiteApresTraitement,
    this.quantiteAvantTraitement,
    this.quantiteRetour,
    this.quantiteSortie,
    this.motif,
    this.createdAt,
    this.prix,
    this.destinataire,
    this.fournisseur,
  });

  

 
}
