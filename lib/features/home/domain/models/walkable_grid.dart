import 'package:flutter/material.dart';
import 'dart:math' show Point;

class WalkableGrid {
  // Define grid size based on map dimensions
  static const int gridWidth = 30; // 300 pixels / 10
  static const int gridHeight = 50; // 500 pixels / 10

  // 2D array representing walkable cells (true = walkable, false = obstacle)
  final List<List<bool>> grid;

  WalkableGrid()
      : grid = List.generate(gridHeight,
            (y) => List.generate(gridWidth, (x) => _isWalkable(x, y)));

  // Convert map coordinates to grid cell
  static Point<int> mapToGrid(Offset mapPosition) {
    // Convert actual map coordinates to grid coordinates
    int x = (mapPosition.dx / 10).floor();
    int y = (mapPosition.dy / 10).floor();

    // Ensure coordinates are within grid bounds
    x = x.clamp(0, gridWidth - 1);
    y = y.clamp(0, gridHeight - 1);

    print('Converting map ($mapPosition) to grid Point($x, $y)');
    return Point(x, y);
  }

  // Convert grid cell to map coordinates (returns center of cell)
  static Offset gridToMap(Point<int> gridPoint) {
    final offset = Offset(
        (gridPoint.x * 10) + 5, // Center of cell
        (gridPoint.y * 10) + 5);
    print(
        'Converting grid Point(${gridPoint.x}, ${gridPoint.y}) to map $offset');
    return offset;
  }

  // Check if a grid cell is walkable
  bool isWalkableAt(Point<int> point) {
    if (point.x < 0 ||
        point.x >= gridWidth ||
        point.y < 0 ||
        point.y >= gridHeight) {
      return false;
    }
    return grid[point.y][point.x];
  }

  // Define walkable areas based on the actual map layout
  static bool _isWalkable(int x, int y) {
    // Convert grid coordinates to map coordinates for easier comparison
    double mapX = x * 10;
    double mapY = y * 10;

    // First, check if we're in the main walkable area bounds
    if (mapX < 0 || mapX >= 300 || mapY < 0 || mapY >= 500) {
      return false;
    }

    // Define vertical walkways (paths between stands)
    bool inVerticalPath = false;
    // Left path
    if (mapX >= 35 && mapX <= 45 && mapY >= 15 && mapY <= 450) {
      inVerticalPath = true;
    }
    if (mapX >= 85 && mapX <= 99 && mapY >= 15 && mapY <= 450) {
      inVerticalPath = true;
    }
    // Middle path
    if (mapX >= 135 && mapX <= 155 && mapY >= 15 && mapY <= 400) {
      inVerticalPath = true;
    }
    if (mapX >= 170 && mapX <= 180 && mapY >= 150 && mapY <= 245) {
      inVerticalPath = true;
    }
    if (mapX >= 245 && mapX <= 255 && mapY >= 15 && mapY <= 150) {
      inVerticalPath = true;
    }
    // Right path

    // Define horizontal walkways
    bool inHorizontalPath = false;
    // Top path
    if (mapY >= 15 && mapY <= 45 && mapX >= 35 && mapX <= 250) {
      inHorizontalPath = true;
    }
    // Upper middle path
    if (mapY >= 140 && mapY <= 145 && mapX >= 35 && mapX <= 250) {
      inHorizontalPath = true;
    }
    if (mapY >= 145 && mapY <= 150 && mapX >= 150 && mapX <= 250) {
      inHorizontalPath = true;
    }
    // Lower middle path
    if (mapY >= 230 && mapY <= 245 && mapX >= 35 && mapX <= 180) {
      inHorizontalPath = true;
    }
    // Bottom path
    if (mapY >= 330 && mapY <= 335 && mapX >= 35 && mapX <= 150) {
      inHorizontalPath = true;
    }

    // Return true only if we're in a valid walkway
    return (inVerticalPath || inHorizontalPath);
  }

  // Get neighboring walkable cells for pathfinding
  List<Point<int>> getNeighbors(Point<int> point) {
    final List<Point<int>> neighbors = [];
    final List<Point<int>> possibleNeighbors = [
      Point(point.x - 1, point.y), // Left
      Point(point.x + 1, point.y), // Right
      Point(point.x, point.y - 1), // Up
      Point(point.x, point.y + 1), // Down
      // Add diagonal movements for more natural paths
      Point(point.x - 1, point.y - 1), // Top-left
      Point(point.x + 1, point.y - 1), // Top-right
      Point(point.x - 1, point.y + 1), // Bottom-left
      Point(point.x + 1, point.y + 1), // Bottom-right
    ];

    for (final neighbor in possibleNeighbors) {
      if (isWalkableAt(neighbor)) {
        neighbors.add(neighbor);
      }
    }

    return neighbors;
  }

  // Debug method to visualize the grid
  void debugPrint() {
    print('\nWalkable Grid Layout:');
    for (int y = 0; y < gridHeight; y++) {
      String row = '';
      for (int x = 0; x < gridWidth; x++) {
        row += grid[y][x] ? '⬜' : '⬛';
      }
      print(row);
    }
  }
}
