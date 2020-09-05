import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:univeos/src/api/home_info_provider.dart';
import 'package:univeos/src/bloc/rest_info.dart';
import 'package:univeos/src/models/home_info_model.dart';
import 'package:univeos/src/models/user_info_model.dart';
import 'package:univeos/src/utils/palette.dart';
import 'package:univeos/src/utils/user_preferences.dart';
import 'package:univeos/src/utils/utils.dart';
import 'package:univeos/src/widgets/user_banner.dart';

class HomePage extends StatelessWidget {
  final _prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RestInfo>(context, listen: false);

    return FutureBuilder(
        future: HomeInfoProvider().post(_prefs.accessToken),
        builder: (BuildContext context, AsyncSnapshot<HomeInfoModel> snapshot) {
          if (snapshot.hasData) {
            final homeData = snapshot.data;

            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _header(context, provider.userInfo),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: ListView.builder(
                        primary: false,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: homeData.widgets.sortables.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _card(
                              context, homeData.widgets.sortables[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _header(BuildContext context, UserInfoModel info) {
    final size = MediaQuery.of(context).size;

    final background = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Palette.deepRed, Palette.lightRed])),
    );

    return Stack(
      children: <Widget>[
        background,
        Container(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.1, horizontal: 20),
            child: Text(
              'Universidad X',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontFamily: 'Gill Sans',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            )),
        Container(
          padding: EdgeInsets.only(top: size.height * 0.29, left: 25),
          child: UserBanner(
              firstName: info.firstName,
              lastName: info.lastName,
              url: info.avatar),
        )
      ],
    );
  }

  Widget _card(BuildContext context, Sortable sortable) {
    return Card(
        elevation: 3.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: _listTile(context, sortable));
  }

  Widget _listTile(BuildContext context, Sortable sortable) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(
        sortable.title,
        style: TextStyle(color: Colors.black87, fontFamily: 'Open Sans'),
      ),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        child: Image.network(
          sortable.icon,
          height: 30,
          width: 30,
        ),
      ),
      trailing: Container(
          decoration: BoxDecoration(
            color: Palette.deepRed,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 20.0)),
      onTap: () {
        print(sortable.title);

        if (sortable.url.contains('pdf')) {
          Utils.showPdf(context, sortable.title, sortable.url);
        } else {
          Utils.showWebview(context, sortable.title, sortable.url);
        }
      },
    );
  }
}
