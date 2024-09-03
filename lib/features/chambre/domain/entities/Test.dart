// import 'package:json_annotation/json_annotation.dart';

// part 'data_model.g.dart';

// @JsonSerializable()
// class DataResponse {
//   final List<DataItem> data;
//   final Links links;
//   final Meta meta;

//   DataResponse({required this.data, required this.links, required this.meta});

//   factory DataResponse.fromJson(Map<String, dynamic> json) => _$DataResponseFromJson(json);
//   Map<String, dynamic> toJson() => _$DataResponseToJson(this);
// }

// @JsonSerializable()
// class DataItem {
//   final int id;
//   final String Name;
//   final Zone Zone;
//   final Entreprise Entreprise;
//   final double Surface;
//   final double Temperature;
//   final String created_at;
//   final String updated_at;

//   DataItem({
//     required this.id,
//     required this.Name,
//     required this.Zone,
//     required this.Entreprise,
//     required this.Surface,
//     required this.Temperature,
//     required this.created_at,
//     required this.updated_at,
//   });

//   factory DataItem.fromJson(Map<String, dynamic> json) => _$DataItemFromJson(json);
//   Map<String, dynamic> toJson() => _$DataItemToJson(this);
// }

// @JsonSerializable()
// class Zone {
//   final int id;
//   final String name;

//   Zone({required this.id, required this.name});

//   factory Zone.fromJson(Map<String, dynamic> json) => _$ZoneFromJson(json);
//   Map<String, dynamic> toJson() => _$ZoneToJson(this);
// }

// @JsonSerializable()
// class Entreprise {
//   final int id;
//   final String name;
//   final int ICE;

//   Entreprise({required this.id, required this.name, required this.ICE});

//   factory Entreprise.fromJson(Map<String, dynamic> json) => _$EntrepriseFromJson(json);
//   Map<String, dynamic> toJson() => _$EntrepriseToJson(this);
// }

// @JsonSerializable()
// class Links {
//   final String first;
//   final String last;
//   final String? prev;
//   final String? next;

//   Links({required this.first, required this.last, this.prev, this.next});

//   factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
//   Map<String, dynamic> toJson() => _$LinksToJson(this);
// }

// @JsonSerializable()
// class Meta {
//   final int current_page;
//   final int from;
//   final int last_page;
//   final List<Link> links;
//   final String path;
//   final int per_page;
//   final int to;
//   final int total;

//   Meta({
//     required this.current_page,
//     required this.from,
//     required this.last_page,
//     required this.links,
//     required this.path,
//     required this.per_page,
//     required this.to,
//     required this.total,
//   });

//   factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
//   Map<String, dynamic> toJson() => _$MetaToJson(this);
// }

// @JsonSerializable()
// class Link {
//   final String? url;
//   final String label;
//   final bool active;

//   Link({this.url, required this.label, required this.active});

//   factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
//   Map<String, dynamic> toJson() => _$LinkToJson(this);
// }
