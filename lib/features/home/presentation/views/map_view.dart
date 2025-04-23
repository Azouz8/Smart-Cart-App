import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cart_app/core/themes/light_theme/app_colors_light.dart';
import 'dart:math' show Point;
import '../manager/map_cubit/map_cubit.dart';
import '../manager/map_cubit/map_state.dart';
import '../../domain/models/walkable_grid.dart';
import '../../domain/models/pathfinding.dart';
import '../../domain/models/product.dart';

class WalkableGridPainter extends CustomPainter {
  final WalkableGrid grid;

  WalkableGridPainter({required this.grid});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint walkablePaint = Paint()
      ..color = Colors.green.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final Paint gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw grid cells
    for (int y = 0; y < WalkableGrid.gridHeight; y++) {
      for (int x = 0; x < WalkableGrid.gridWidth; x++) {
        final rect = Rect.fromLTWH(
          x * 10.0,
          y * 10.0,
          10.0,
          10.0,
        );

        // Draw walkable cells
        if (grid.isWalkableAt(Point(x, y))) {
          canvas.drawRect(rect, walkablePaint);
        }

        // Draw grid lines
        canvas.drawRect(rect, gridPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final TextEditingController _searchController = TextEditingController();
  final WalkableGrid _walkableGrid = WalkableGrid();
  final Pathfinding _pathfinding = Pathfinding(WalkableGrid());
  final FocusNode _searchFocusNode = FocusNode();
  List<Product> _searchResults = [];
  List<Point<int>>? _currentPath;
  Product? _selectedProduct;
  bool _isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    _walkableGrid.debugPrint();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    setState(() {
      _searchResults = Product.search(query);
    });
  }

  void _selectProduct(Product product) {
    setState(() {
      _selectedProduct = product;
      // Get current position from MapCubit
      if (context.read<MapCubit>().state is MapLoaded) {
        final currentPosition =
            (context.read<MapCubit>().state as MapLoaded).currentPosition;
        print('Current screen position: $currentPosition');

        // Convert screen coordinates to grid coordinates
        // The grid is 40x60 cells, and the screen is 800x600
        // So each grid cell is 20x10 pixels
        final gridX = (currentPosition.dx / 20).round();
        final gridY = (currentPosition.dy / 10).round();

        // Ensure coordinates are within grid bounds
        final boundedGridX = gridX.clamp(0, WalkableGrid.gridWidth - 1);
        final boundedGridY = gridY.clamp(0, WalkableGrid.gridHeight - 1);

        final startPoint = Point(boundedGridX, boundedGridY);

        print(
            'Converting screen position ($currentPosition) to grid position $startPoint');
        print('Finding path from $startPoint to ${product.location}');

        // Find path to product
        _currentPath = _pathfinding.findPath(startPoint, product.location);

        if (_currentPath != null) {
          print('Path found with ${_currentPath!.length} points');
          print('Path points: $_currentPath');
        } else {
          print('No path found from $startPoint to ${product.location}');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                // Main content
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // Search bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          decoration: InputDecoration(
                            hintText: 'Search for products...',
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.search,
                              color: _isSearchFocused
                                  ? AppColorsLight.primaryColor
                                  : AppColorsLight.secondaryColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: AppColorsLight.secondaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: AppColorsLight.secondaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: AppColorsLight.primaryColor, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          onChanged: _handleSearch,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Map view
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.85,
                        child: BlocBuilder<MapCubit, MapState>(
                          builder: (context, state) {
                            if (state is MapLoaded) {
                              double scaleX = MapCubit.mapImageWidth / 800.0;
                              double scaleY = MapCubit.mapImageHeight / 600.0;
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

                                      // Walkable grid visualization
                                      // CustomPaint(
                                      //   painter: WalkableGridPainter(
                                      //       grid: _walkableGrid),
                                      //   size: const Size(MapCubit.mapImageWidth,
                                      //       MapCubit.mapImageHeight),
                                      // ),

                                      // Path visualization
                                      if (_currentPath != null)
                                        CustomPaint(
                                          painter: PathPainter(
                                            path: _currentPath!,
                                            maxWidth: MapCubit.mapImageWidth,
                                            maxHeight: MapCubit.mapImageHeight,
                                          ),
                                          size: const Size(
                                              MapCubit.mapImageWidth,
                                              MapCubit.mapImageHeight),
                                        ),

                                      // Current position marker
                                      CustomPaint(
                                        painter: MarkerPainter(
                                          position: scaledPosition,
                                          showGrid: false,
                                          maxWidth: MapCubit.mapImageWidth,
                                          maxHeight: MapCubit.mapImageHeight,
                                        ),
                                        size: const Size(MapCubit.mapImageWidth,
                                            MapCubit.mapImageHeight),
                                      ),

                                      // Destination marker
                                      if (_selectedProduct != null)
                                        Positioned(
                                          left: WalkableGrid.gridToMap(
                                                      _selectedProduct!
                                                          .location)
                                                  .dx -
                                              10,
                                          top: WalkableGrid.gridToMap(
                                                      _selectedProduct!
                                                          .location)
                                                  .dy -
                                              10,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.green.withOpacity(0.7),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                            ),
                                          ),
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
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Search results overlay
                if (_searchResults.isNotEmpty &&
                    _searchController.text.isNotEmpty)
                  Positioned(
                    top: 60, // Below search bar
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final product = _searchResults[index];
                            return Material(
                              color: Colors.transparent,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue.withOpacity(0.1),
                                  child: Icon(
                                    _getCategoryIcon(product.category),
                                    color: Colors.blue,
                                  ),
                                ),
                                title: Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  product.category,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  _selectProduct(product);
                                  // Clear search results after selection
                                  setState(() {
                                    _searchResults = [];
                                    _searchController.clear();
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'dairy':
        return Icons.egg_outlined;
      case 'bakery':
        return Icons.breakfast_dining;
      case 'beverages':
        return Icons.local_drink;
      case 'snacks':
        return Icons.cookie;
      case 'produce':
        return Icons.eco;
      default:
        return Icons.shopping_basket;
    }
  }
}

class PathPainter extends CustomPainter {
  final List<Point<int>> path;
  final double maxWidth;
  final double maxHeight;

  PathPainter({
    required this.path,
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.6)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    if (path.length < 2) return;

    final pathPoints =
        path.map((point) => WalkableGrid.gridToMap(point)).toList();
    final drawPath = Path();
    drawPath.moveTo(pathPoints[0].dx, pathPoints[0].dy);

    for (int i = 1; i < pathPoints.length; i++) {
      drawPath.lineTo(pathPoints[i].dx, pathPoints[i].dy);
    }

    canvas.drawPath(drawPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
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
