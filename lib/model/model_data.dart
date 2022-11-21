import 'dart:convert';

List<modelData> modelDataFromJson(String str) =>
    List<modelData>.from(json.decode(str).map((x) => modelData.fromJson(x)));

String modelDataToJson(List<modelData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class modelData {
  String? createdAt;
  String? authorId;
  String? authorName;
  String? description;
  String? media;
  int? likeCount;
  int? disLikeCount;
  String? authorProfileImage;
  String? id;
  List<Comments>? comments;

  modelData(
      {this.createdAt,
        this.authorId,
        this.authorName,
        this.description,
        this.media,
        this.likeCount,
        this.disLikeCount,
        this.authorProfileImage,
        this.id,
        this.comments});

  modelData.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    authorId = json['authorId'];
    authorName = json['authorName'];
    description = json['description'];
    media = json['media'];
    likeCount = json['likeCount'];
    disLikeCount = json['disLikeCount'];
    authorProfileImage = json['authorProfileImage'];
    id = json['id'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['authorId'] = this.authorId;
    data['authorName'] = this.authorName;
    data['description'] = this.description;
    data['media'] = this.media;
    data['likeCount'] = this.likeCount;
    data['disLikeCount'] = this.disLikeCount;
    data['authorProfileImage'] = this.authorProfileImage;
    data['id'] = this.id;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  String? createdAt;
  String? authorName;
  String? authorId;
  String? description;
  int? likeCount;
  int? disLikeCount;
  String? authorProfileImage;
  String? id;
  String? postId;

  Comments(
      {this.createdAt,
        this.authorName,
        this.authorId,
        this.description,
        this.likeCount,
        this.disLikeCount,
        this.authorProfileImage,
        this.id,
        this.postId});

  Comments.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    authorName = json['authorName'];
    authorId = json['authorId'];
    description = json['description'];
    likeCount = json['likeCount'];
    disLikeCount = json['disLikeCount'];
    authorProfileImage = json['authorProfileImage'];
    id = json['id'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['authorName'] = this.authorName;
    data['authorId'] = this.authorId;
    data['description'] = this.description;
    data['likeCount'] = this.likeCount;
    data['disLikeCount'] = this.disLikeCount;
    data['authorProfileImage'] = this.authorProfileImage;
    data['id'] = this.id;
    data['postId'] = this.postId;
    return data;
  }
}