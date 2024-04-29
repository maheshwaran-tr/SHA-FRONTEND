// To parse this JSON data, do
//
//     final block = blockFromJson(jsonString);


import 'dart:convert';

Block blockFromJson(String str) => Block.fromJson(json.decode(str));

String blockToJson(Block data) => json.encode(data.toJson());

class Block {
  final int id;
  final String name;

  Block({
    required this.id,
    required this.name,
  });

  factory Block.fromJson(Map<String, dynamic> json) => Block(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
