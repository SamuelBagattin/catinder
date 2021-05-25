import 'dart:convert';

import '../backend/backend.dart';

// import '../../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class VisuProfilWidget extends StatefulWidget {
  VisuProfilWidget({Key key}) : super(key: key);

  @override
  _VisuProfilWidgetState createState() => _VisuProfilWidgetState();
}

class _VisuProfilWidgetState extends State<VisuProfilWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.cat,
                    color: Colors.black,
                    size: 30,
                  ),
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                  icon: Icon(
                    Icons.chat,
                    color: Colors.black,
                    size: 30,
                  ),
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 30,
                  ),
                  iconSize: 30,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
              ),
              child: StreamBuilder<List<CatProfilesRecord>>(
                stream: queryCatProfilesRecord(),
                builder: (context, snapshot) {
                  print(snapshot.connectionState);
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text(jsonEncode(snapshot.error));
                  }
                  List<CatProfilesRecord> stackCatProfilesRecordList =
                      snapshot.data;
                  // Customize what your widget looks like with no query results.
                  if (snapshot.data.isEmpty) {
                    return Container();
                    // For now, we'll just include some dummy data.
                    // stackCatProfilesRecordList =
                    //     createDummyCatProfilesRecord(count: 4);
                  }
                  return Stack(
                    children: List.generate(stackCatProfilesRecordList.length,
                        (stackIndex) {
                      final stackCatProfilesRecord =
                          stackCatProfilesRecordList[stackIndex];
                      return Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xFFF5F5F5),
                        child: Image.network(
                          stackCatProfilesRecord.picture,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                  icon: Icon(
                    Icons.clear_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                  iconSize: 30,
                ),
                IconButton(
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                  icon: Icon(
                    Icons.check_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                  iconSize: 30,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
