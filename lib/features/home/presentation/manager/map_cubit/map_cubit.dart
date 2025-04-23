import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_cart_app/core/services/helper_functions.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  Position? _currentPosition;
  StreamSubscription<Position>? _positionStream;
  final List<Offset> _recentPositions = [];
  static const int _maxRecentPositions = 5;

  // Map dimensions - match with WalkableGrid (30x50 cells, 10 pixels per cell)
  static const double mapImageWidth = 300.0; // 30 cells * 10 pixels
  static const double mapImageHeight = 500.0; // 50 cells * 10 pixels

  // GPS boundaries - keep the same as they are correct
  static const double mapMinLat = 29.944984; // South edge
  static const double mapMaxLat = 29.945096; // North edge
  static const double mapMinLon = 31.279337; // West edge
  static const double mapMaxLon = 31.279484; // East edge

  static const double _minMovementThreshold = 0.5;

  // Calculate the actual GPS distances
  final double _latDistance = mapMaxLat - mapMinLat;
  final double _lonDistance = mapMaxLon - mapMinLon;

  MapCubit() : super(MapInitial()) {
    _initializeLocation();
  }

  @override
  Future<void> close() {
    _positionStream?.cancel();
    return super.close();
  }

  Future<void> _initializeLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(MapError('Location permissions are required for navigation'));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(MapError('Location permissions are permanently denied'));
      return;
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(MapError('Location service is not enabled'));
      return;
    }

    _startLocationUpdates();
  }

  void _startLocationUpdates() {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    ).then((Position position) {
      _updatePosition(position);
    });

    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1,
        timeLimit: null,
      ),
    ).listen(
      (Position position) {
        _updatePosition(position);
      },
      onError: (error) {
        emit(MapError('Error getting location: $error'));
      },
    );
  }

  void _updatePosition(Position position) {
    if (_currentPosition != null) {
      double distance = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        position.latitude,
        position.longitude,
      );

      if (distance < _minMovementThreshold) {
        return;
      }
    }

    _currentPosition = position;
    final mapPosition = _convertGpsToMapCoordinates(position);

    _recentPositions.add(mapPosition);
    if (_recentPositions.length > _maxRecentPositions) {
      _recentPositions.removeAt(0);
    }

    final smoothedPosition = _calculateSmoothedPosition();
    emit(MapLoaded(currentPosition: smoothedPosition));
  }

  Offset _convertGpsToMapCoordinates(Position position) {
    // Convert GPS to map coordinates
    final normalizedLat =
        (position.latitude - mapMinLat) / (mapMaxLat - mapMinLat);
    final normalizedLon =
        (position.longitude - mapMinLon) / (mapMaxLon - mapMinLon);

    // Apply offset correction and scaling
    // Note: We invert the latitude (1 - normalizedLat) because GPS coordinates increase northward
    // but our Y coordinates increase southward
    final mapX = normalizedLon * mapImageWidth;
    final mapY = (1 - normalizedLat) * mapImageHeight;

    print('GPS: (${position.latitude}, ${position.longitude})');
    print('Normalized: ($normalizedLat, $normalizedLon)');
    print('Map position: ($mapX, $mapY)');

    // Ensure the position stays within map bounds
    return Offset(
      mapX.clamp(0.0, mapImageWidth).toDouble(),
      mapY.clamp(0.0, mapImageHeight).toDouble(),
    );
  }

  Offset _calculateSmoothedPosition() {
    if (_recentPositions.isEmpty) return Offset.zero;

    double x = 0;
    double y = 0;
    double totalWeight = 0;

    // Use more recent positions with higher weight for smoother movement
    for (int i = 0; i < _recentPositions.length; i++) {
      double weight = pow(2, i).toDouble();
      x += _recentPositions[i].dx * weight;
      y += _recentPositions[i].dy * weight;
      totalWeight += weight;
    }

    final smoothedX = (x / totalWeight).clamp(0.0, mapImageWidth).toDouble();
    final smoothedY = (y / totalWeight).clamp(0.0, mapImageHeight).toDouble();

    return Offset(smoothedX, smoothedY);
  }

  void startNavigation(Offset destination) {
    if (state is MapLoaded) {
      final currentState = state as MapLoaded;
      final pathPoints =
          _calculatePath(currentState.currentPosition, destination);
      emit(currentState.copyWith(
        pathPoints: pathPoints,
        isNavigating: true,
      ));
    }
  }

  void stopNavigation() {
    if (state is MapLoaded) {
      final currentState = state as MapLoaded;
      emit(currentState.copyWith(
        pathPoints: [],
        isNavigating: false,
      ));
    }
  }

  List<Offset> _calculatePath(Offset start, Offset end) {
    return [
      start,
      Offset((start.dx + end.dx) / 2, (start.dy + end.dy) / 2),
      end,
    ];
  }
}
