class Chambre {
  final int? id;
  final String name;
  final String? zoneName;
  final String? entrepriseName;
  final int? zoneId;
  final int? entrepriseICE;
  final double surface;
  final double temperature;
  final String? createdAt;

  final int? pageFrom;
  final int? pageCurrent;
  final int? lastPage;

  Chambre(
      {this.id,
      required this.name,
      this.zoneName,
      this.entrepriseName,
      required this.surface,
      required this.temperature,
      this.createdAt,
      this.entrepriseICE,
      this.pageCurrent,
      this.pageFrom,
      this.lastPage,
      this.zoneId});
}
