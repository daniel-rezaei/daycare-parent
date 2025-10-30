
import 'package:equatable/equatable.dart';

abstract class BottomNavEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TabChanged extends BottomNavEvent {
  final int index;
  TabChanged(this.index);

  @override
  List<Object> get props => [index];
}