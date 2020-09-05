import 'package:flutter/material.dart';
import 'package:univeos/src/api/classes_provider.dart';
import 'package:univeos/src/models/classes_model.dart';
import 'package:univeos/src/utils/palette.dart';
import 'package:univeos/src/utils/user_preferences.dart';
import 'package:univeos/src/utils/utils.dart';

class SchoolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Académico'),
        ),
        body: _buildAcademic(context));
  }

  Widget _buildAcademic(BuildContext context) {
    return FutureBuilder(
      future: ClassesProvider().post(UserPreferences().accessToken),
      builder: (BuildContext context, AsyncSnapshot<ClassesModel> snapshot) {
        if (snapshot.hasData) {
          final classesData = snapshot.data;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _widgetsListView(context, classesData.widgets),
                Container(
                    padding: EdgeInsets.only(left: 15.0, bottom: 20.0),
                    child: Text('MIS ASIGNATURAS',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Open Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w700))),
                _subjectsListView(context, classesData.subjects),
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _widgetsListView(BuildContext context, List<ClassWidget> classes) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.only(right: 20.0),
        itemCount: classes.length,
        itemBuilder: (context, i) => Container(
            padding: EdgeInsets.only(left: 20.0, top: 25.0),
            child: _widgetsCard(context, classes[i])),
      ),
    );
  }

  Widget _widgetsCard(BuildContext context, ClassWidget classWidget) {
    final background = Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1.0,
              offset: Offset(0.0, 2.0),
              // spreadRadius: 1.0
            )
          ]),
    );

    return InkWell(
      child: Stack(
        children: <Widget>[
          background,
          Container(
            padding: EdgeInsets.only(top: 20.0, left: 20),
            child: Image.network(classWidget.icon,
                height: 20.0,
                width: 20.0,
                color: Colors.red,
                colorBlendMode: BlendMode.srcIn),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
            child: Text(
              classWidget.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      onTap: () {
        print(classWidget.title);

        Utils.showWebview(context, classWidget.title, classWidget.url);
      },
    );
  }

  Widget _subjectsListView(BuildContext context, List<Subject> subjects) {
    return ListView.builder(
      primary: false,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 50.0),
      itemCount: subjects.length,
      itemBuilder: (context, i) => _subjectCard(context, subjects[i]),
    );
  }

  Widget _subjectCard(BuildContext context, Subject subject) {
    return Card(
        elevation: 2.0,
        margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
        child: _subjectListTile(context, subject));
  }

  Widget _subjectListTile(BuildContext context, Subject subject) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      title: Text(
        subject.name,
        style: TextStyle(color: Colors.black, fontFamily: 'Open Sans'),
      ),
      subtitle: Text(
        subject.groupName,
        style: TextStyle(color: Colors.black54, fontFamily: 'Open Sans'),
      ),
      trailing: Container(
          decoration: BoxDecoration(
            color: Palette.deepRed,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 20.0)),
      onTap: () {
        print(subject.subjectUrl);

        if (subject.subjectUrl != '') {
          Utils.showPdf(context, subject.name, subject.subjectUrl);
        }
      },
    );
  }
}
