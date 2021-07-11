import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  final String id;
  final String title;
  final String status;
  final String subTitle;
  final String createdAt;
  ToDo({
    required this.id,
    required this.title,
    required this.status,
    required this.subTitle,
    required this.createdAt,
  });

  ToDo copyWith({
    String? id,
    String? title,
    String? status,
    String? subTitle,
    String? createdAt,
  }) {
    return ToDo(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
      subTitle: subTitle ?? this.subTitle,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'subTitle': subTitle,
      'createdAt': createdAt.toString(),
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['_id'],
      title: map['title'],
      status: map['status'],
      subTitle: map['subTitle'],
      createdAt: map['createdAt'],
    );
  }
  factory ToDo.fromFirestore(dynamic map) {
    return ToDo(
      id: map['_id'],
      title: map['title'],
      status: map['status'],
      subTitle: map['subTitle'],
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDo.fromJson(String source) => ToDo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ToDo(title: $title, status: $status, subTitle: $subTitle, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ToDo &&
        other.title == title &&
        other.status == status &&
        other.subTitle == subTitle &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        status.hashCode ^
        subTitle.hashCode ^
        createdAt.hashCode;
  }
}
