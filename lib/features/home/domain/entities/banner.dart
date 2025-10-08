import 'package:equatable/equatable.dart';

/// Domain entity for home banner
class Banner extends Equatable {
  const Banner({
    required this.id,
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.actionUrl,
    this.order = 0,
  });

  final String id;
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final String? actionUrl;
  final int order;

  @override
  List<Object?> get props => [id, imageUrl, title, subtitle, actionUrl, order];
}

