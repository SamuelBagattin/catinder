import 'package:catinder/backend/auth/auth_util.dart';

import 'package:catinder/pages/visu_profil/visu_profil_widget.dart';
import 'package:catinder/widgets/FFButtonOptions.dart';
import 'package:catinder/widgets/FFButtonWidget.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF49498D),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment(0, 0),
              child: Image.network(
                'https://i.imgur.com/ifjnQyF.png',
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.3,
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment(0, 0),
              child: Container(
                width: 230,
                height: 44,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          final user = await signInWithGoogle(context);
                          if (user == null) {
                            return;
                          }
                          await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisuProfilWidget(),
                            ),
                            (r) => false,
                          );
                        },
                        text: 'Sign in with Google',
                        icon: Icon(
                          Icons.add,
                          color: Colors.transparent,
                          size: 20,
                        ),
                        options: FFButtonOptions(
                          width: 230,
                          height: 44,
                          color: Colors.white,
                          textStyle: GoogleFonts.getFont(
                            'Roboto',
                            color: Color(0xFF606060),
                            fontSize: 17,
                          ),
                          elevation: 4,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(-0.83, 0),
                      child: Container(
                        width: 22,
                        height: 22,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          'https://i0.wp.com/nanophorm.com/wp-content/uploads/2018/04/google-logo-icon-PNG-Transparent-Background.png?w=1000&ssl=1',
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
