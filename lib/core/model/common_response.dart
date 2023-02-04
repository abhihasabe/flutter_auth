/// (c) Walt Disney.  All rights reserved.
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable()
//ignore: must_be_immutable
class CommonResponse extends Equatable {
  int? code;
  String? message;

  CommonResponse({this.code, this.message});

  factory CommonResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);

  @override
  List<Object?> get props => [];
}
