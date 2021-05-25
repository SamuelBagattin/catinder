import '../../backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            child: Align(
              alignment: Alignment(0, 0.5),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
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
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<CatProfilesRecord> stackProfilesCatProfilesRecordList =
                      snapshot.data;
                  // Customize what your widget looks like with no query results.
                  if (snapshot.data.isEmpty) {
                    // return Container();
                    // For now, we'll just include some dummy data.
                    stackProfilesCatProfilesRecordList =
                        createDummyCatProfilesRecord(count: 4);
                  }
                  return Stack(
                    children:
                        List.generate(stackProfilesCatProfilesRecordList.length,
                            (stackProfilesIndex) {
                      final stackProfilesCatProfilesRecord =
                          stackProfilesCatProfilesRecordList[
                              stackProfilesIndex];
                      return Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: Color(0xFFF5F5F5),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment(0, 0),
                              child: Image.network(
                                'https://picsum.photos/seed/104/600',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment(0, 0),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 0, 16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 8, 0),
                                            child: Text(
                                              stackProfilesCatProfilesRecord
                                                  .name,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 30,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 8, 0),
                                            child: Text(
                                              stackProfilesCatProfilesRecord.age
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                                fontSize: 30,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            stackProfilesCatProfilesRecord
                                                .breed,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 30,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(8, 0, 0, 16),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            stackProfilesCatProfilesRecord
                                                .description,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
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
