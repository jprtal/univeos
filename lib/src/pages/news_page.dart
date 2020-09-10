import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:univeos/src/api/news_provider.dart';
import 'package:univeos/src/bloc/rest_info.dart';
import 'package:univeos/src/models/news_model.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  ScrollController _scrollController = ScrollController();
  List<News> _items = List();
  bool _isPerformingRequest = false;
  int _page = 1;

  @override
  void initState() {
    _getMoreData();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Noticias'),
        ),
        body: _buildList());
  }

  void _getMoreData() async {
    if (!_isPerformingRequest) {
      setState(() {
        _isPerformingRequest = true;
      });

      NewsModel newEntries = await NewsProvider().post(
          Provider.of<RestInfo>(context, listen: false).userInfo.accessToken,
          _page);
      _page++;

      newEntries.news.forEach((f) {
        _items.add(f);
      });

      setState(() {
        _isPerformingRequest = false;
      });
    }
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: _items.length + 1,
      itemBuilder: (context, index) {
        if (index == _items.length) {
          return _buildProgressIndicator();
        } else {
          return _card(context, _items[index]);
        }
      },
      controller: _scrollController,
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
            (news.imgWidget == '')
                ? Image.asset('assets/images/placeholder.png')
                : FadeInImage(
                    image: NetworkImage(news.imgWidget),
                    placeholder: AssetImage('assets/images/placeholder.png'),
                    height: 120.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
              title: Text(news.newTitle),
              subtitle:
                  Text(DateFormat("dd-MM-yyyy").format(news.newPublicDate)),
            ),
          ],
        ),
        onTap: () => Navigator.pushNamed(context, 'news', arguments: news),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: _isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
