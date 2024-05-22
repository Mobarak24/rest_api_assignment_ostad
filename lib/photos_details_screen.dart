import 'package:flutter/material.dart';
import 'package:photosapp/model.dart';

class PhotosDetailsScreen extends StatefulWidget {

   final PhotosModel photosModel;

  const PhotosDetailsScreen({
    super.key,
    required this.photosModel,
  });

  @override
  State<PhotosDetailsScreen> createState() => _PhotosDetailsScreen();
}

class _PhotosDetailsScreen extends State<PhotosDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos Details Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(widget.photosModel.photos.toString()),
              const SizedBox(
                height: 10,
              ),
               Wrap(
                children: [
                  Text("title: ${widget.photosModel.title} "),
                ],
              ),
               Text('Id: ${widget.photosModel.id.toString()}'),
            ],
          ),
        ),
      ),
    );
  }
}
