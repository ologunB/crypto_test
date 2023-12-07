import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Pizza extends Equatable{
  final String id;
  final String name;
  final Image image;

  const Pizza({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  List<Object?>get props =>[id,name,image];
  static List<Pizza>pizzas=[];
}