import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:/src/api/classes_provider.dart';
import 'package:/src/bloc/rest_info.dart';
import 'package:/src/models/classes_model.dart';
import 'package:/src/utils/palette.dart';
import 'package:/src/utils/utils.dart';

class SchoolPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Académico'),
      ),
      body: _buildSubjects(context),
    );
  }


  Widget _buildSubjects(BuildContext context) {

    final provider = Provider.of<RestInfo>(context, listen: false);

    return FutureBuilder(
      future: ClassesProvider().post(provider.homeInfo.accessToken),
      builder: (BuildContext context, AsyncSnapshot<ClassesModel> snapshot) {
        if (snapshot.hasData) {
          final subjects = snapshot.data.subjects;

          return ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, i) => _card(context, subjects[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }


  Widget _card(BuildContext context, Subject subject) {

    return Card(
      elevation: 2.0,
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
      child: _listTile(context, subject)
    );
  }

  Widget _listTile(BuildContext context, Subject subject) {

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      title: Text(
        subject.name,
        style: TextStyle(color: Colors.black, fontFamily: "Open Sans"),
      ),
      subtitle: Text(
        subject.groupName,
        style: TextStyle(color: Colors.black54, fontFamily: "Open Sans"),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Palette.deepRed,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 20.0)
      ),
      onTap: () {
        print(subject.subjectUrl);

        if (subject.subjectUrl != '') {
          Utils.showPdf(context, subject.name, subject.subjectUrl);
        }
      },
    );
  }

}