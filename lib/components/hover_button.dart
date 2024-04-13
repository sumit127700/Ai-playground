import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;

  const HoverButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _updateHoverState(true),
      onExit: (_) => _updateHoverState(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => _updateClickedState(true),
        onTapUp: (_) => _updateClickedState(false),
        onTapCancel: () => _updateClickedState(false),
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: _isHovered || _isClicked ? widget.color : Colors.transparent,
            border: Border.all(
              color: widget.color,
              width: 2.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10.0,
          ),
          child: widget.child,
        ),
      ),
    );
  }

  void _updateHoverState(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }

  void _updateClickedState(bool isClicked) {
    setState(() {
      _isClicked = isClicked;
    });
  }
}