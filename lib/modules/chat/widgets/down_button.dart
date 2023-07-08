
import 'package:flutter/material.dart';

class DownButton extends StatefulWidget {
  const DownButton({
    super.key,
    required this.colors,
    required this.scrollController,
  });

  final ColorScheme colors;
  final ScrollController scrollController;

  @override
  State<DownButton> createState() => _DownButtonState();
}

class _DownButtonState extends State<DownButton> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.scrollController.hasClients ||
        !(widget.scrollController.offset > 0.0)) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.colors.onSecondary,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: IconButton(
          onPressed: () {
            widget.scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
          icon: Icon(
            Icons.arrow_downward,
            color: widget.colors.secondary,
          ),
        ),
      ),
    );
  }
}
