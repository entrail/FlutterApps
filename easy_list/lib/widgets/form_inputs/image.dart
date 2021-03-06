import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ImageInputState();
  }
}

class ImageInputState extends State<ImageInput> {
  File _imageFile;

  void _getImage(BuildContext context, ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source, maxWidth: 400.0);

    Navigator.pop(context); //close the modal
  }

  void _openImagePicker(BuildContext context) {
    final buttonColor = Theme.of(context).primaryColor;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an Image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                FlatButton(
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                  child: Text('Use Camera'),
                  textColor: buttonColor,
                ),
                FlatButton(
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                  child: Text('Use Gallery'),
                  textColor: buttonColor,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).primaryColor;
    return Column(
      children: <Widget>[
        OutlineButton(
          onPressed: () {
            _openImagePicker(context);
          },
          borderSide: BorderSide(color: buttonColor, width: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                color: buttonColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Add Image',
                style: TextStyle(color: buttonColor),
              )
            ],
          ),
        )
      ],
    );
  }
}
