import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/video_data.dart';

class LibraryView extends StatefulWidget {
  const LibraryView({super.key});

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: DemoData.images.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => context.goNamed('player',
                  extra: DemoData.videos,
                  queryParameters: {'index': index.toString()}),
              child: Card(
                child: Column(
                  children: [
                    Image.network(DemoData.images[index]),
                    ListTile(
                      title: Text(index.toString()),
                      subtitle: const Text("Channel Name"),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
