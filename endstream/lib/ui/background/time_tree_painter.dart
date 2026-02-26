import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'ripple_engine.dart';
import 'time_tree_data.dart';

/// Paints the procedural Time Tree background.
///
/// Draws all segments with oscillation displacement, ripple color influence,
/// and node points as small filled squares. Angular aesthetic only — no
/// rounded caps or circles.
class TimeTreePainter extends CustomPainter {
  TimeTreePainter({
    required this.structure,
    required this.oscillationTime,
    required this.oscillationAmplitude,
    required this.ripples,
  });

  final TreeStructure structure;
  final double oscillationTime;
  final double oscillationAmplitude;
  final List<ActiveRipple> ripples;

  // Cached Paint objects — reused across frames, only color/strokeWidth mutated.
  final Paint _bgPaint = Paint()..color = TreeColors.background;

  final Paint _segmentPaint = Paint()
    ..strokeCap = StrokeCap.square
    ..style = PaintingStyle.stroke;

  final Paint _nodePaint = Paint()..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    // Fill background
    canvas.drawRect(Offset.zero & size, _bgPaint);

    // Draw segments
    for (final segment in structure.segments) {
      final osc = _oscillationOffset(segment, size);
      final start = _toScreen(segment.start, size) + osc;
      final end = _toScreen(segment.end, size) + osc;

      var color = segment.baseColor;
      color = _applyRippleColor(color, segment);

      _segmentPaint
        ..color = color
        ..strokeWidth = segment.thickness;

      canvas.drawLine(start, end, _segmentPaint);
    }

    // Draw nodes as small filled squares
    for (final node in structure.nodes) {
      final pos = _toScreen(node.position, size);
      final half = node.size / 2;

      var color = TreeColors.nodePoint;
      color = _applyRippleColorAtPoint(color, node.position);

      _nodePaint.color = node.isTerminal
          ? color.withValues(alpha: 0.5)
          : color;

      canvas.drawRect(
        Rect.fromCenter(center: pos, width: half * 2, height: half * 2),
        _nodePaint,
      );
    }
  }

  Offset _toScreen(Offset normalized, Size size) {
    return Offset(normalized.dx * size.width, normalized.dy * size.height);
  }

  /// Perpendicular displacement based on oscillation time + phase.
  Offset _oscillationOffset(TreeSegment segment, Size size) {
    if (oscillationAmplitude == 0) return Offset.zero;

    final phase = oscillationTime * 2 * pi + segment.phaseOffset;
    final displacement = sin(phase) * oscillationAmplitude;

    // Perpendicular to segment direction
    final dx = segment.end.dx - segment.start.dx;
    final dy = segment.end.dy - segment.start.dy;
    final length = sqrt(dx * dx + dy * dy);
    if (length == 0) return Offset.zero;

    // Perpendicular unit vector (in screen space)
    final perpX = -dy / length;
    final perpY = dx / length;

    return Offset(perpX * displacement, perpY * displacement);
  }

  /// Lerp segment color toward branchActive based on ripple influence.
  Color _applyRippleColor(Color base, TreeSegment segment) {
    if (ripples.isEmpty) return base;

    var maxInfluence = 0.0;
    for (final ripple in ripples) {
      final influence = ripple.influenceAt(segment.start, segment.end);
      if (influence > maxInfluence) maxInfluence = influence;
    }

    if (maxInfluence <= 0) return base;
    return Color.lerp(base, TreeColors.branchActive, maxInfluence)!;
  }

  /// Ripple influence at a single point (for nodes).
  Color _applyRippleColorAtPoint(Color base, Offset normalizedPos) {
    if (ripples.isEmpty) return base;

    var maxInfluence = 0.0;
    for (final ripple in ripples) {
      final influence = ripple.influenceAt(normalizedPos, normalizedPos);
      if (influence > maxInfluence) maxInfluence = influence;
    }

    if (maxInfluence <= 0) return base;
    return Color.lerp(base, TreeColors.branchActive, maxInfluence)!;
  }

  @override
  bool shouldRepaint(TimeTreePainter oldDelegate) {
    if (oscillationAmplitude != 0) return true;
    if (ripples.isNotEmpty) return true;
    if (!identical(structure, oldDelegate.structure)) return true;
    return false;
  }
}
