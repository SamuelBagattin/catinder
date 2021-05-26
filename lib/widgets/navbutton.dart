import 'package:catinder/pages/edit_profil/edit_profil_widget.dart';
import 'package:catinder/pages/messagerie/messagerie_widget.dart';
import 'package:catinder/pages/visu_profil/visu_profil_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavButtonsBar extends StatelessWidget {
  const NavButtonsBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(),
      child: Align(
        alignment: Alignment(0, 0.5),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavButton(Pages.Main),
              NavButton(Pages.Chat),
              NavButton(Pages.EditProfile),
            ],
          ),
        ),
      ),
    );
  }
}


class NavButton extends StatelessWidget {
  final Pages page;

  NavButton(this.page);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
      onPressed: () async {
        await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              switch (this.page) {
                case Pages.Main:
                  return VisuProfilWidget();
                case Pages.EditProfile:
                  return EditProfilWidget();
                case Pages.Chat:
                  return MessagerieWidget();
                default:
                  return EditProfilWidget();
              }
            },
          ),
              (r) => false,
        );
      },
      child: this.page == Pages.Chat ? Icon(
        Icons.chat,
        color: Colors.amber,
        size: 30,
      ) : this.page == Pages.Main ? FaIcon(
        FontAwesomeIcons.cat,
        color: Colors.lightBlue,
        size: 30,
      ) : Icon(
        Icons.person,
        color: Colors.pink,
        size: 30,
      ),
      color: Colors.white,
    );
  }
}

enum Pages {
  Chat,
  Main,
  EditProfile
}
