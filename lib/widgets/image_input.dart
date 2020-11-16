import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {

  final Function onSelectImage;
  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  File _storageImage;
  _takePicture()async{
    final ImagePicker _picker = ImagePicker();
    PickedFile imageFile = await _picker.getImage(source: ImageSource.camera,maxHeight: 600);

    //testando para ver ser o user não abriu e saiu da camera
    if(imageFile == null){
      return ;
    }
    setState(() {
      _storageImage = File(imageFile.path);
    });
    //pasta para armazenar dentro da aplicação
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(_storageImage.path);
    final savedImage = await _storageImage.copy("${appDir.path}/$fileName");
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.grey)
          ),
          alignment: Alignment.center,
          child: _storageImage != null ?
              Image.file(
                  _storageImage,
                width: double.infinity,
                fit: BoxFit.cover,
              )
              :Text("Nenhuma imagem"),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: FlatButton.icon(
              onPressed: _takePicture,
              icon: Icon(Icons.camera),
              label: Text("Tirar Foto"),
            textColor: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
