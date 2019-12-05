import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:/src/api/news_provider.dart';
import 'package:/src/bloc/rest_info.dart';
import 'package:/src/models/news_model.dart';

class NewsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias'),
      ),
      body: _buildNews(context),
    );
  }


  Widget _buildNews(BuildContext context) {

    final provider = Provider.of<RestInfo>(context, listen: false);

    return FutureBuilder(
      future: NewsProvider().post(provider.homeInfo.accessToken),
      builder: (BuildContext context, AsyncSnapshot<NewsModel> snapshot) {
        if (snapshot.hasData) {
          final news = snapshot.data.news;

          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, i) => _card(context, news[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }


  Widget _card(BuildContext context, News news) {

    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        child: Column(
          children: <Widget>[
            (news.newImage == '')
              ? Image.asset('assets/images/placeholder.png')
              : FadeInImage(
                image: NetworkImage(news.newImage),
                placeholder: AssetImage('assets/images/placeholder.png'),
                height: 120.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ListTile(
              title: Text(news.newTitle),
              subtitle: Text(news.newPublicDate.toLocal().toString()),
            ),
          ],
        ),
        onTap: () => Navigator.pushNamed(context, 'news', arguments: news),
      ),
    );
  }

}