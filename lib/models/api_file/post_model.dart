// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
    Post({
        this.ownerId,
        this.fileTypeId,
        this.file,
    });

    String? ownerId;
    int? fileTypeId;
    String? file;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        ownerId: json["ownerId"],
        fileTypeId: json["fileTypeId"],
        file: json["file"],
    );

    Map<String, dynamic> toJson() => {
        "ownerId": ownerId,
        "fileTypeId": fileTypeId,
        "file": file,
    };
}
