import 'package:flutter/material.dart';

abstract class MapState {}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final Offset currentPosition;
  final List<Offset> pathPoints;
  final bool isNavigating;

  MapLoaded({
    this.currentPosition = const Offset(0, 0),
    this.pathPoints = const [],
    this.isNavigating = false,
  });

  MapLoaded copyWith({
    Offset? currentPosition,
    List<Offset>? pathPoints,
    bool? isNavigating,
  }) {
    return MapLoaded(
      currentPosition: currentPosition ?? this.currentPosition,
      pathPoints: pathPoints ?? this.pathPoints,
      isNavigating: isNavigating ?? this.isNavigating,
    );
  }
}

class MapError extends MapState {
  final String message;

  MapError(this.message);
}
