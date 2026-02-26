import 'dart:math';
import 'dart:ui';

import 'time_tree_data.dart';

/// Generates a procedural time tree using seeded PRNG recursive branching.
///
/// All coordinates are normalized [0–1]. The tree grows upward from the
/// bottom of the screen. Density controls branch count and depth.
class TimeTreeGenerator {
  TimeTreeGenerator._();

  /// Hard cap on total segments to keep rendering fast.
  static const _maxSegments = 500;

  /// Generates a complete tree structure for the given screen dimensions.
  ///
  /// [density] ranges 0.0–1.0 and controls maxDepth, branchProbability,
  /// and segment length.
  static TreeStructure generate(
    Size screenSize, {
    double density = 0.7,
    int seed = 42,
  }) {
    final rng = Random(seed);
    final segments = <TreeSegment>[];
    final nodes = <TreeNodePoint>[];

    final clampedDensity = density.clamp(0.0, 1.0);

    // Scale parameters by density
    final maxDepth = (3 + (clampedDensity * 5)).round(); // 3–8
    final branchProbability = 0.3 + clampedDensity * 0.4; // 0.3–0.7
    final segmentLength = 0.14 - clampedDensity * 0.06; // 0.14–0.08

    // Aspect ratio affects horizontal spread
    final aspectRatio = screenSize.width / screenSize.height;
    final horizontalSpread = (aspectRatio * 0.5).clamp(0.2, 0.6);

    var branchIndex = 0;

    void growBranch(
      Offset from,
      double angle,
      int depth,
      int parentBranch,
    ) {
      if (depth > maxDepth) {
        nodes.add(TreeNodePoint(
          position: from,
          depth: depth,
          isTerminal: true,
        ));
        return;
      }
      if (segments.length >= _maxSegments) return;
      if (from.dx < -0.05 || from.dx > 1.05 || from.dy < -0.05 || from.dy > 1.05) return;

      // Slight wobble to the angle
      final wobble = (rng.nextDouble() - 0.5) * 0.15;
      final actualAngle = angle + wobble;

      final dx = cos(actualAngle) * segmentLength * horizontalSpread;
      final dy = -sin(actualAngle) * segmentLength; // negative = upward
      final to = Offset(from.dx + dx, from.dy + dy);

      // Phase offset varies by branch and depth for organic oscillation
      final phaseOffset = parentBranch * 1.7 + depth * 0.9 + rng.nextDouble() * 0.5;

      segments.add(TreeSegment(
        start: from,
        end: to,
        depth: depth,
        branchIndex: parentBranch,
        phaseOffset: phaseOffset,
      ));

      // Add node at junction
      nodes.add(TreeNodePoint(
        position: to,
        depth: depth,
        isTerminal: false,
      ));

      // Continue straight
      growBranch(to, actualAngle, depth + 1, parentBranch);

      // Probabilistic fork
      if (rng.nextDouble() < branchProbability && segments.length < _maxSegments) {
        branchIndex++;
        // Fork angles: 30°, 45°, or 60° off the parent direction
        final forkAngles = [pi / 6, pi / 4, pi / 3];
        final forkAngle = forkAngles[rng.nextInt(forkAngles.length)];
        final direction = rng.nextBool() ? 1.0 : -1.0;

        growBranch(to, actualAngle + forkAngle * direction, depth + 1, branchIndex);
      }
    }

    // Main trunk — grows from bottom center upward
    branchIndex = 0;
    growBranch(
      const Offset(0.5, 0.95),
      pi / 2, // straight up
      0,
      branchIndex,
    );

    // Secondary trunk left — when density > 0.3
    if (clampedDensity > 0.3) {
      branchIndex++;
      growBranch(
        const Offset(0.35, 0.98),
        pi / 2 + 0.1,
        1,
        branchIndex,
      );
    }

    // Secondary trunk right — when density > 0.5
    if (clampedDensity > 0.5) {
      branchIndex++;
      growBranch(
        const Offset(0.65, 0.97),
        pi / 2 - 0.1,
        1,
        branchIndex,
      );
    }

    return TreeStructure(segments: segments, nodes: nodes);
  }
}
