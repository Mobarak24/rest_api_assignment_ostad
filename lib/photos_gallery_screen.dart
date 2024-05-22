import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photosapp/model.dart';
import 'package:photosapp/photos_details_screen.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({super.key});

  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  bool _photosListInProgressing = false;

  List<dynamic> photoList = [];

  @override
  void initState() {
    _getPhotosList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery App'),
      ),
      body: Visibility(
        visible: _photosListInProgressing == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: photoList.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotosDetailsScreen(
                        photosModel: photoList[index],
                      ),
                    ),
                  );
                },
                child: _buildPhotoslist(photoList[index]));
          },
        ),
      ),
    );
  }

  Future<void> _getPhotosList() async {
    _photosListInProgressing = true;
    setState(() {});

    const String photosListUrl = "https://jsonplaceholder.typicode.com/photos";
    Uri uri = Uri.parse(photosListUrl);
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);

    _photosListInProgressing = false;
    setState(() {});

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      for (final json in jsonData) {
        PhotosModel photosModel = PhotosModel.fromJson(json);
        photoList.add(photosModel);
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('fail')));
    }
  }

  Widget _buildPhotoslist(PhotosModel photosModel) {
    return ListTile(
      leading: SizedBox(
        child: Image.network(photosModel.photos.toString()),
      ),
      title: Wrap(
        children: [Text(photosModel.title.toString())],
      ),
    );
  }
}
