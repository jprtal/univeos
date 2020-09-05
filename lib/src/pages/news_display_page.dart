import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:univeos/src/models/news_model.dart';
import 'package:univeos/src/utils/utils.dart';

class NewsDisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final News data = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: size.height * 0.45,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                  titlePadding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
                  // https://stackoverflow.com/questions/50764558/expand-the-app-bar-in-flutter-to-allow-multi-line-title
                  title: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: size.width - 170,
                    ),
                    child: Text(data.newTitle,
                        style: TextStyle(
                            fontFamily: 'Gill Sans',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0)),
                  ),
                  background: Image.network(
                    data.newImage,
                    fit: BoxFit.cover,
                    color: Colors.black38,
                    colorBlendMode: BlendMode.darken,
                  )),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Html(
            data: data.newDescription,
            defaultTextStyle: TextStyle(
                fontFamily: 'Open Sans', fontSize: 16, color: Colors.black54),
            onLinkTap: (url) {
              print(url);
              Utils.showWebview(context, url, url);
            },
            customTextAlign: (element) {
              return TextAlign.justify;
            },
          ),
          padding: EdgeInsets.all(15.0),
        ),
      ),
    );
  }
}
