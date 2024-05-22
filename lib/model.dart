class PhotosModel {
   int? albumId;
   int? id;
   String? title;
   String? photos;
   String? thumbnail;

   PhotosModel.fromJson(var json){
     albumId = json["albumId"];
     id = json["id"];
     title = json["title"];
     photos = json["url"];
     thumbnail = json["thumbnailUrl"];
   }


}