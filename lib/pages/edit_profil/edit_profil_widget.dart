import 'package:catinder/backend/auth/auth_util.dart';
import 'package:catinder/backend/backend.dart';
import 'package:catinder/utils/media.dart';
import 'package:catinder/widgets/FFButtonOptions.dart';
import 'package:catinder/widgets/FFButtonWidget.dart';
import 'package:catinder/widgets/navbutton.dart';
import 'package:uuid/uuid.dart';

import '../visu_profil/visu_profil_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfilWidget extends StatefulWidget {
  EditProfilWidget({Key key}) : super(key: key);

  @override
  _EditProfilWidgetState createState() => _EditProfilWidgetState();
}

class _EditProfilWidgetState extends State<EditProfilWidget> {
  String uploadedFileUrl;
  TextEditingController nameController;
  TextEditingController ageController;
  TextEditingController breedController;
  TextEditingController sexController;
  TextEditingController descriptionController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    ageController = TextEditingController();
    breedController = TextEditingController();
    sexController = TextEditingController();
    descriptionController = TextEditingController();
    getCatProfileFromUserId(getCurrentUser().uid).then((value) {
      if (value != null) {
        this.nameController.text = value.name;
        this.ageController.text = value.age.toString();
        this.breedController.text = value.breed;
        this.sexController.text = value.sexe;
        this.descriptionController.text = value.description;
        setState(() {
          this.uploadedFileUrl = value.picture;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NavButtonsBar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Color(0xFFF5F5F5),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: InkWell(
                  onTap: () async {
                    final selectedMedia = await selectMedia();
                    if (selectedMedia != null &&
                        validateFileFormat(selectedMedia.path, context)) {
                      showUploadMessage(context, 'Uploading file...',
                          showLoading: true, durationSeconds: 60);

                      final photoUid = Uuid().v1();
                      final task = uploadData(
                          storagePath: selectedMedia.path, filename: photoUid);
                      task.whenComplete(() async {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        final downloadUrl =
                            "https://firebasestorage.googleapis.com/v0/b/catinder-58997.appspot.com/o/$photoUid?alt=media";
                        print(downloadUrl);
                        if (downloadUrl != null) {
                          setState(() => uploadedFileUrl = downloadUrl);
                          showUploadMessage(context, 'Success!');
                        } else {
                          showUploadMessage(context, 'Failed to upload media');
                        }
                      });
                    }
                  },
                  child: Image.network(
                    this.uploadedFileUrl == null
                        ? 'https://picsum.photos/seed/682/600'
                        : this.uploadedFileUrl,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.45,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: Text(
                    'Name:',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: nameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: '[Some hint text...]',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: Text(
                    'Age:',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: ageController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: '[Some hint text...]',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: Text(
                    'Breed:',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: breedController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: '[Some hint text...]',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: Text(
                    'Sex:',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: sexController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: '[Some hint text...]',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(45, 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: Text(
                    'Description:',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: descriptionController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: '[Some hint text...]',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 16),
            child: FFButtonWidget(
              onPressed: () async {
                await addOrModifyCatProfile(InsertCatProfileQuery(
                    userId: getCurrentUser().uid,
                    sexe: this.sexController.value.text,
                    picture: this.uploadedFileUrl,
                    name: this.nameController.value.text,
                    description: this.descriptionController.value.text,
                    age: int.parse(this.ageController.value.text),
                    breed: this.breedController.value.text));
              },
              text: 'Submit',
              options: FFButtonOptions(
                width: 130,
                height: 40,
                color: Theme.of(context).primaryColor,
                textStyle: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
                elevation: 2,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
          )
        ],
      ),
    );
  }
}
