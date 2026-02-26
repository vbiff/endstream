import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'component_enums.dart';

/// Line connector between nodes, optionally animated with a subtle wave.
class TreeBranch extends StatefulWidget {
  const TreeBranch({
    super.key,
    this.direction = TreeBranchDirection.horizontal,
    this.length = 100,
    this.animated = false,
    this.color = TreeColors.branchDefault,
    this.thickness = 1.0,
  });

  final TreeBranchDirection direction;
  final double length;
  final bool animated;
  final Color color;
  final double thickness;

  @override
  State<TreeBranch> createState() => _TreeBranchState();
}

class _TreeBranchState extends State<TreeBranch>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.animated) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
      )..repeat();
    }
  }

  @override
  void didUpdateWidget(TreeBranch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animated && _controller == null) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
      )..repeat();
    } else if (!widget.animated && _controller != null) {
      _controller!.dispose();
      _controller = null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal = widget.direction == TreeBranchDirection.horizontal;
    final size = isHorizontal
        ? Size(widget.length, widget.thickness + 2)
        : Size(widget.thickness + 2, widget.length);

    if (!widget.animated || _controller == null || MediaQuery.disableAnimationsOf(context)) {
      return ExcludeSemantics(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: widget.color,
              // constrain to the thickness
            ),
          ),
        ),
      );
    }

    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _controller!,
        builder: (context, _) {
          return CustomPaint(
            size: size,
            painter: _WaveBranchPainter(
              progress: _controller!.value,
              color: widget.color,
              thickness: widget.thickness,
              isHorizontal: isHorizontal,
            ),
          );
        },
      ),
    );
  }
}

class _WaveBranchPainter extends CustomPainter {
  _WaveBranchPainter({
    required this.progress,
    required this.color,
    required this.thickness,
    required this.isHorizontal,
  });

  final double progress;
  final Color color;
  final double thickness;
  final bool isHorizontal;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    final path = Path();
    final length = isHorizontal ? size.width : size.height;
    final center = isHorizontal ? size.height / 2 : size.width / 2;

    // Step by 3px — on a 1px-thick line, 3px resolution is imperceptible
    // but reduces sin() calls by ~67%.
    if (isHorizontal) {
      path.moveTo(0, center);
      for (var i = 0.0; i <= length; i += 3) {
        final wave =
            math.sin((i / length * 2 * math.pi) + (progress * 2 * math.pi)) *
            0.75;
        path.lineTo(i, center + wave);
      }
    } else {
      path.moveTo(center, 0);
      for (var i = 0.0; i <= length; i += 3) {
        final wave =
            math.sin((i / length * 2 * math.pi) + (progress * 2 * math.pi)) *
            0.75;
        path.lineTo(center + wave, i);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_WaveBranchPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.color != color ||
      oldDelegate.thickness != thickness;
}
