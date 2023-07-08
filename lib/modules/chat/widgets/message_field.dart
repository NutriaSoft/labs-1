import 'package:flutter/material.dart';
import 'package:flutter_tutorial/modules/chat/widgets/message_field_style.dart';
import 'package:flutter_tutorial/core/utils/get_theme.dart';

class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;

  const MessageFieldBox({super.key, required this.onValue});
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final FocusNode focusNode = FocusNode();
    final ColorScheme colors = getTheme(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: TextFormField(
          controller: controller,
          decoration: messageFieldStyle(colors).copyWith(
            suffixIcon: DynamicSuffixIcon(
              controller: controller,
              colors: colors,
              focusNode: focusNode,
              onValue: onValue,
            ),
            hintText: 'Type a message',
          ),
          textInputAction: TextInputAction.done,
          autofocus: true,
          focusNode: focusNode,
          onFieldSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              controller.clear();
              onValue(value.trim());
            }
            focusNode.requestFocus();
          },
        ),
      ),
    );
  }
}

class DynamicSuffixIcon extends StatelessWidget {
  final TextEditingController controller;
  final ColorScheme colors;
  final FocusNode focusNode;
  final ValueChanged<String> onValue;

  const DynamicSuffixIcon(
      {Key? key,
      required this.controller,
      required this.colors,
      required this.focusNode,
      required this.onValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          transitionBuilder: (widget, animation) {
            return FadeTransition(opacity: animation, child: widget);
          },
          child: controller.text.trim().isEmpty
              ? Row(
                  key: const ValueKey(1),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.attach_file,
                        color: colors.onSurface,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt,
                        color: colors.onSurface,
                      ),
                    ),
                  ],
                )
              : Row(
                  key: const ValueKey(2),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 48.0),
                    IconButton(
                      onPressed: () {
                        if (controller.text.trim().isEmpty) return;
                        String value = controller.text.trim();
                        controller.clear();
                        onValue(value);

                        focusNode.requestFocus();
                      },
                      icon: Icon(
                        Icons.send,
                        color: colors.primary,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
