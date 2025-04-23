import 'dart:math' show Point;
import 'dart:collection';
import 'walkable_grid.dart';

class PathNode {
  final Point<int> position;
  final PathNode? parent;
  final double g; // Cost from start to current node
  final double h; // Estimated cost from current node to end
  double get f => g + h; // Total cost

  PathNode(this.position, this.parent, this.g, this.h);
}

class Pathfinding {
  final WalkableGrid grid;

  Pathfinding(this.grid);

  // Manhattan distance heuristic with diagonal movement
  double _heuristic(Point<int> a, Point<int> b) {
    final dx = (a.x - b.x).abs();
    final dy = (a.y - b.y).abs();
    return (dx + dy).toDouble();
  }

  List<Point<int>>? findPath(Point<int> start, Point<int> end) {
    print('Finding path from $start to $end');

    // First, ensure start and end are walkable
    if (!grid.isWalkableAt(start) || !grid.isWalkableAt(end)) {
      print('Start or end position is not walkable');
      // Find nearest walkable points if current points aren't walkable
      start = _findNearestWalkable(start);
      end = _findNearestWalkable(end);
      print('Adjusted path: from $start to $end');
    }

    final openSet = SplayTreeSet<PathNode>((a, b) {
      int compare = a.f.compareTo(b.f);
      if (compare == 0) {
        compare = a.h.compareTo(b.h);
      }
      return compare;
    });

    final closedSet = <String>{};
    final startNode = PathNode(start, null, 0, _heuristic(start, end));
    openSet.add(startNode);

    while (openSet.isNotEmpty) {
      final current = openSet.first;
      openSet.remove(current);

      if (current.position == end) {
        print('Path found!');
        return _reconstructPath(current);
      }

      final positionKey = '${current.position.x},${current.position.y}';
      closedSet.add(positionKey);

      // Get neighbors including diagonal movements
      final neighbors = _getNeighbors(current.position);
      for (final neighbor in neighbors) {
        final neighborKey = '${neighbor.x},${neighbor.y}';
        if (closedSet.contains(neighborKey)) continue;

        // Calculate cost to neighbor
        // Use 1.4 for diagonal movement (approximately sqrt(2))
        final isDiagonal = neighbor.x != current.position.x &&
            neighbor.y != current.position.y;
        final moveCost = isDiagonal ? 1.4 : 1.0;
        final g = current.g + moveCost;

        final existingNode = openSet.firstWhere(
          (node) => node.position == neighbor,
          orElse: () => PathNode(neighbor, null, double.infinity, 0),
        );

        if (g < existingNode.g) {
          // This path is better than any previous one
          final h = _heuristic(neighbor, end);
          final node = PathNode(neighbor, current, g, h);
          openSet.remove(existingNode);
          openSet.add(node);
        }
      }
    }

    print('No path found');
    return null;
  }

  Point<int> _findNearestWalkable(Point<int> point) {
    var minDistance = double.infinity;
    Point<int>? nearest;

    // First try a larger search area
    for (var d = 1; d < 20; d++) {
      for (var dx = -d; dx <= d; dx++) {
        for (var dy = -d; dy <= d; dy++) {
          final candidate = Point(point.x + dx, point.y + dy);
          // Check if the point is within grid bounds
          if (candidate.x >= 0 &&
              candidate.x < WalkableGrid.gridWidth &&
              candidate.y >= 0 &&
              candidate.y < WalkableGrid.gridHeight) {
            if (grid.isWalkableAt(candidate)) {
              final distance = _heuristic(point, candidate);
              if (distance < minDistance) {
                minDistance = distance;
                nearest = candidate;
              }
            }
          }
        }
      }
      if (nearest != null) break;
    }

    // If no walkable point found, return the closest valid grid point
    if (nearest == null) {
      print('No walkable points found near $point, using fallback position');
      int x = point.x.clamp(0, WalkableGrid.gridWidth - 1);
      int y = point.y.clamp(0, WalkableGrid.gridHeight - 1);
      // Try to find any walkable point in the grid
      for (int i = 0; i < WalkableGrid.gridWidth; i++) {
        for (int j = 0; j < WalkableGrid.gridHeight; j++) {
          final candidate = Point(i, j);
          if (grid.isWalkableAt(candidate)) {
            return candidate;
          }
        }
      }
      // If still no walkable point found, use a known walkable point
      return const Point(15, 23); // Middle walkway as fallback
    }

    return nearest;
  }

  List<Point<int>> _getNeighbors(Point<int> point) {
    final neighbors = <Point<int>>[];

    // Check all 8 directions
    for (var dx = -1; dx <= 1; dx++) {
      for (var dy = -1; dy <= 1; dy++) {
        if (dx == 0 && dy == 0) continue;

        final newPoint = Point(point.x + dx, point.y + dy);
        if (grid.isWalkableAt(newPoint)) {
          // For diagonal movement, check if both cardinal diections are walkable
          if (dx != 0 && dy != 0) {
            final horizontal = Point(point.x + dx, point.y);
            final vertical = Point(point.x, point.y + dy);
            if (grid.isWalkableAt(horizontal) && grid.isWalkableAt(vertical)) {
              neighbors.add(newPoint);
            }
          } else {
            neighbors.add(newPoint);
          }
        }
      }
    }

    return neighbors;
  }

  List<Point<int>> _reconstructPath(PathNode endNode) {
    final path = <Point<int>>[];
    var current = endNode;
    while (current.parent != null) {
      path.add(current.position);
      current = current.parent!;
    }
    path.add(current.position);
    return path.reversed.toList();
  }
}
