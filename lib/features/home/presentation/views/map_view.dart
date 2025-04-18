import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/map_cubit/map_cubit.dart';
import '../manager/map_cubit/map_state.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(),
      child: Scaffold(
        body: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            if (state is MapLoaded) {
              // Scale the position to match the actual display size
              double scaleX =
                  MapCubit.mapImageWidth / 800.0; // Scale from 800 to 300
              double scaleY =
                  MapCubit.mapImageHeight / 600.0; // Scale from 600 to 500
              final scaledPosition = Offset(
                state.currentPosition.dx * scaleX,
                state.currentPosition.dy * scaleY,
              );

              return Center(
                child: SizedBox(
                  width: MapCubit.mapImageWidth,
                  height: MapCubit.mapImageHeight,
                  child: Stack(
                    children: [
                      // Base map image
                      Image.asset(
                        'assets/images/indoor_map.png',
                        width: MapCubit.mapImageWidth,
                        height: MapCubit.mapImageHeight,
                        fit: BoxFit.fill,
                      ),

                      // Custom painter for marker and debug grid
                      CustomPaint(
                        painter: MarkerPainter(
                          position: scaledPosition,
                          showGrid: true,
                          maxWidth: MapCubit.mapImageWidth,
                          maxHeight: MapCubit.mapImageHeight,
                        ),
                        size: const Size(
                            MapCubit.mapImageWidth, MapCubit.mapImageHeight),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is MapError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class MarkerPainter extends CustomPainter {
  final Offset position;
  final bool showGrid;
  final double maxWidth;
  final double maxHeight;

  MarkerPainter({
    required this.position,
    this.showGrid = false,
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the current position marker
    // Outer circle
    final outerPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(position, 15, outerPaint);

    // Inner circle
    final innerPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(position, 7, innerPaint);

    // White border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(position, 7, borderPaint);

    // Draw coordinate text near marker
    TextPainter(
      text: TextSpan(
        text:
            '(${position.dx.toStringAsFixed(1)}, ${position.dy.toStringAsFixed(1)})',
        style: const TextStyle(color: Colors.red, fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    )
      ..layout()
      ..paint(canvas, position + const Offset(10, -10));
  }

  @override
  bool shouldRepaint(MarkerPainter oldDelegate) =>
      position != oldDelegate.position;
}
