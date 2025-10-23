import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'generation_model.g.dart';

@JsonSerializable()
class GenerationModel extends Equatable {
  final String name;
  final String url;

  const GenerationModel({required this.name, required this.url});

  factory GenerationModel.fromJson(Map<String, dynamic> json) =>
      _$GenerationModelFromJson(json);
  Map<String, dynamic> toJson() => _$GenerationModelToJson(this);

  @override
  List<Object?> get props => [name, url];
}
