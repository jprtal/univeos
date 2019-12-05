import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:/src/api/home_info_provider.dart';
import 'package:/src/api/user_info_provider.dart';
import 'package:/src/bloc/rest_info.dart';
import 'package:/src/models/home_info_model.dart';
import 'package:/src/models/user_info_model.dart';
import 'package:/src/utils/palette.dart';
import 'package:/src/utils/user_preferences.dart';
import 'package:/src/utils/utils.dart';
import 'package:/src/widgets/user_banner.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _prefs = new UserPreferences();

  @override
  void initState() {
    super.initState();

    // TODO: improve token handling at startup
    UserInfoProvider().post(_prefs.accessToken).then((value) {
      if (value == null) {
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        Provider.of<RestInfo>(context, listen: false).userInfo = value;
      }
    });
    HomeInfoProvider().post(_prefs.accessToken).then((value) {
      if (value == null) {
        Navigator.pushReplacementNamed(context, 'login');
      } else {
        Provider.of<RestInfo>(context, listen: false).homeInfo = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<RestInfo>(context);

    if (provider.userInfo != null && provider.homeInfo != null) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _header(provider.userInfo),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                  primary: false,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: provider.homeInfo.widgets.sortables.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _card(provider.homeInfo.widgets.sortables[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold( body: Center(child: CircularProgressIndicator()));
    }
  }

  Widget _header(UserInfoModel info) {
    
    final size = MediaQuery.of(context).size;

    final background = Container(
      height: size.height * 0.35,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color> [
            Palette.deepRed,
            Palette.lightRed
          ]
        )
      ),
    );

    return Stack(
      children: <Widget>[
        background,
        Container(
          padding: EdgeInsets.symmetric(vertical: 70.0, horizontal: 20),
          child: Text("Universidad X", 
            style: TextStyle(
              color: Colors.white, 
              fontSize: 36, 
              fontFamily: 'Gill Sans', 
              fontWeight: FontWeight.bold,
              letterSpacing: 2),)
        ),
        Container(
          padding: EdgeInsets.only(top: 190.0, left: 20),
          child: UserBanner(firstName: info.firstName, lastName: info.lastName, url: info.avatar),
        )
      ],
    );
  }

  Widget _card(Sortable sortable) {

    return Card(
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: _listTile(sortable)
    );
  }

  Widget _listTile(Sortable sortable) {

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(
        sortable.title,
        style: TextStyle(color: Colors.black87, fontFamily: "Open Sans"),
      ),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        child: Image.network(sortable.icon, height: 30, width: 30,),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Palette.deepRed,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 20.0)
      ),
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