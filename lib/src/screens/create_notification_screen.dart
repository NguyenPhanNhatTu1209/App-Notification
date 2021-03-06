import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:todolist/src/repository/notification_repository.dart';
import 'package:todolist/src/services/storage_service.dart';

class CreateNotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreateNotificationScreenState();
  }
}

class _CreateNotificationScreenState extends State<CreateNotificationScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String title = "";
  String subTitle = "";
  String timeString = "";
  DateTime time = DateTime.now();
  File? _image;
  final _picker = ImagePicker();
  int check = 0;

  _imgFromCamera() async {
    PickedFile? image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      check = 1;
      _image = File(image!.path);
    });
  }

  _imgFromGallery() async {
    PickedFile? image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      check = 1;
      _image = File(image!.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Add Notification',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          title = val.trim();
                        });
                      },
                      validator: (val) =>
                          val!.trim().length == 0 ? 'Nh???p title v??!' : null,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: '',
                          labelText: 'Title',
                          icon: Icon(Icons.add_comment)))),
              Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          subTitle = val.trim();
                        });
                      },
                      validator: (val) =>
                          val!.trim().length == 0 ? 'Nh???p subTitle v??!' : null,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: '',
                          labelText: 'SubTitle',
                          icon: Icon(Icons.add_comment)))),
              Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      enabled: false,
                      decoration: InputDecoration(
                          hintText: '',
                          labelText: 'Time: $timeString',
                          icon: Icon(Icons.timer)))),
              Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextButton(
                      onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true, onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          if (date.compareTo(DateTime.now()) == 1) {
                            // -1 0 1
                            setState(() {
                              time = date;
                              timeString =
                                  DateFormat("HH:mm a dd/MM/yyyy").format(time);
                            });
                          }
                        }, currentTime: DateTime.now(), locale: LocaleType.vi);
                      },
                      child: Text(
                        'Click Add Time',
                        style: TextStyle(color: Colors.blue, fontSize: 18),
                      ))),
              Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: RaisedButton(
                    child: Text('Choose Image'),
                    shape: StadiumBorder(),
                    onPressed: () => null,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  )),
              Container(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xffFDCF09),
                      child: check == 1
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                _image!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // GestureDetector(
              //   onTap: () async {
              //     await FirebaseFirestore.instance.collection('todos').add({
              //       "title": title,
              //       "subTitle": subTitle,
              //       "status": "DOING",
              //       "createdAt": DateTime.now(),
              //     });
              //     // Navigator.of(context).pop();
              //     Navigator.pop(context);
              //   },
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              //     decoration: BoxDecoration(
              //         image: DecorationImage(
              //             image: NetworkImage(
              //                 'https://duhocvietglobal.com/wp-content/uploads/2018/12/dat-nuoc-va-con-nguoi-anh-quoc.jpg'),
              //             fit: BoxFit.cover),
              //         color: Colors.blue,
              //         border: Border.all(color: Colors.yellow, width: 2),
              //         borderRadius: BorderRadius.circular(5)),
              //     child: Text(
              //       'Add Task',
              //       style: TextStyle(fontSize: 20, color: Colors.red),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () async {
                        if (timeString != "" || _image == null) {
                          if (_formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) => Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blueAccent),
                                ),
                              ),
                              barrierColor: Color(0x80000000),
                              barrierDismissible: false,
                            );
                            String urlToImage = await StorageService()
                                .uploadImageToStorage(_image!);
                            await NotificationRepository().addNotification(
                              title: title,
                              body: subTitle,
                              urlToImage: urlToImage,
                              date: time,
                            );
                            Navigator.pop(context); // Pop cai screen loading
                            Navigator.pop(
                                context); // Pop cai screen add notification de ra man hinh home
                          }
                        } else {
                          _scaffoldKey.currentState!.showSnackBar(
                            SnackBar(
                              dismissDirection: DismissDirection.horizontal,
                              elevation: .0,
                              duration: Duration(seconds: 5),
                              content: Text(
                                _image == null
                                    ? 'Ch???n h??nh ??i loz Ngh??a'
                                    : 'Nh???p th???i gian th??ng b??o',
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('Add Notification'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
