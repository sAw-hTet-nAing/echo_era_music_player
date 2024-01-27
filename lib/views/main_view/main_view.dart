import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/video_data.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
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
