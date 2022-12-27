class Post {
  int? id;
  String? title;
  String? description;
  String? image;
  String? avatar;
  String? name;
  int? isLike;
  int? isFile;
  Post(
      {this.id,
      this.title,
      this.description,
      this.image,
      this.avatar,
      this.isLike = 0,
      this.name,
      this.isFile = 0});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'avatar': avatar,
      'name': name,
      'isLike': isLike,
      'isFile': isFile
    };
    return map;
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      avatar: json['avatar'],
      name: json['name'],
      isLike: json['isLiked'],
      isFile: json['isFile'],
    );
  }
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      image: map['image'],
      avatar: map['avatar'],
      name: map['name'],
      isLike: map['isLiked'],
      isFile: map['isFile'],
    );
  }
  @override
  String toString() {
    return "id:$id-title:$title-description:$description-image:$image-avatar:$avatar-name:$name-isLike:$isLike-isFile:$isFile";
  }
}
