import 'dart:ui';

import '../../app/theme.dart';

/// A straight-line branch segment in normalized [0–1] coordinates.
class TreeSegment {
  TreeSegment({
    required this.start,
    required this.end,
    required this.depth,
    required this.branchIndex,
    required this.phaseOffset,
  })  : thickness = (1.5 - depth * 0.25).clamp(0.5, 1.5),
        baseColor = TreeColors.branchDefault
            .withValues(alpha: (1.0 - depth * 0.15).clamp(0.3, 1.0));

  final Offset start;
  final Offset end;
  final int depth;
  final int branchIndex;

  /// Phase offset for oscillation (radians).
  final double phaseOffset;

  /// Thinner at deeper depths. Minimum 0.5px. Precomputed at construction.
  final double thickness;

  /// Fades at deeper depths. Minimum opacity 0.3. Precomputed at construction.
  final Color baseColor;
}

/// A node point where branches fork or terminate.
class TreeNodePoint {
  TreeNodePoint({
    required this.position,
    required this.depth,
    required this.isTerminal,
  }) : size = (4.0 - depth).clamp(2.0, 4.0);

  final Offset position;
  final int depth;
  final bool isTerminal;

  /// Smaller at deeper depths. Minimum 2.0px. Precomputed at construction.
  final double size;
}

/// Pre-computed tree structure — segments + nodes, all in normalized coords.
class TreeStructure {
  const TreeStructure({
    required this.segments,
    required this.nodes,
  });

  final List<TreeSegment> segments;
  final List<TreeNodePoint> nodes;

  static const empty = TreeStructure(segments: [], nodes: []);
}
