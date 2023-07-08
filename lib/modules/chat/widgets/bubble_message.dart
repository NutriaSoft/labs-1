import 'package:flutter/material.dart';
import 'package:flutter_tutorial/core/utils/get_size.dart';

class BubbleMessage extends StatelessWidget {
  final Color colorBubble;
  final String? text;
  final Color colorText;
  final bool left;
  final String? image;

  const BubbleMessage({
    super.key,
    required this.colorBubble,
    required this.colorText,
    required this.left,
    this.text,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      verticalDirection: VerticalDirection.up,
      textDirection: TextDirection.ltr,
      crossAxisAlignment:
          left ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorBubble,
            borderRadius: BorderRadius.circular(13.0),
          ),
          constraints: BoxConstraints(
            maxWidth: size.width * 0.73,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image != null)
                  _ImageBubble(
                    image: image!,
                  ),
                if (text != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 4.0,
                    ),
                    child: Text(
                      text!,
                      style: TextStyle(
                        color: colorText,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}

class _ImageBubble extends StatelessWidget {
  final String image;
  const _ImageBubble({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: LimitedBox(
        maxHeight: size.height * 0.5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13.0),
          child: Image.network(
            image,
            width: size.width * 0.73,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress == null
                    ? child
                    : Container(
                        width: size.width * 0.73,
                        height: size.height * 0.33,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
            errorBuilder: (context, error, stackTrace) => Container(
              width: size.width * 0.73,
              height: size.height * 0.33,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(13.0),
              ),
              child: const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
