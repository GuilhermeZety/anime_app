// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class ImagesEntity extends Equatable {
  final String? legacy;
  final String? avif;

  const ImagesEntity({required this.legacy, required this.avif});

  @override
  List<Object?> get props => [legacy, avif];
}
