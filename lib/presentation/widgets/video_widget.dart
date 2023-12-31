import 'package:flutter/material.dart';

class VideoWidget extends StatelessWidget {
  final String url;
  const VideoWidget({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            url,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
              );
            },
            errorBuilder: (_, error, stackTrace) {
              return const Center(
                child: Icon(Icons.wifi_off),
              );
            },
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.black.withOpacity(0.7),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.volume_off,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
