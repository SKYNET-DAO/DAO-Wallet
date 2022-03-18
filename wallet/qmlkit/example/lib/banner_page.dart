import 'package:flutter/material.dart';
import 'package:qmlkit/widgets/banner_widget.dart';
import 'package:qmlkit/pub/extensions/extensions.dart';

class BannerPage extends StatefulWidget {
  BannerPage({Key? key}) : super(key: key);

  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banner"),
      ),
      body: AspectRatio(
        aspectRatio: 2,
        child: BannerWidget(
          itemCount: 4,
          itemBuilder: (_, index) => "$index"
              .toText(color: Colors.white)
              .applyBackground(
                  color: Colors.green, alignment: Alignment.center),
        ),
      ).applyBackground(width: double.infinity),
    );
  }
}
