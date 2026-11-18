import 'package:hive/hive.dart';

class ShowModel extends HiveObject {
  final int id;
  final String name;
  final String image;
  final double rating;
  final List<String> genres;
  final String summary;

  ShowModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.genres,
    required this.summary,
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) {
    // Parse image
    String imgUrl = '';
    if (json['image'] != null && json['image'] is Map) {
      imgUrl = json['image']['medium'] ?? json['image']['original'] ?? '';
    }

    // Parse rating
    double rate = 0.0;
    if (json['rating'] != null && json['rating']['average'] != null) {
      rate = (json['rating']['average'] as num).toDouble();
    }

    // Parse genres
    List<String> genreList = [];
    if (json['genres'] != null && json['genres'] is List) {
      genreList = (json['genres'] as List).map((e) => e.toString()).toList();
    }

    // Parse summary and strip HTML tags
    String rawSummary = (json['summary'] ?? '').toString();
    String cleanSummary = rawSummary.replaceAll(RegExp(r'<[^>]*>'), '').trim();
    if (cleanSummary.isEmpty) {
      cleanSummary = 'Tidak ada deskripsi tersedia.';
    }

    return ShowModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? 'Untitled',
      image: imgUrl,
      rating: rate,
      genres: genreList,
      summary: cleanSummary,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'genres': genres,
      'summary': summary,
    };
  }
}

// Hive TypeAdapter for ShowModel
class ShowAdapter extends TypeAdapter<ShowModel> {
  @override
  final int typeId = 0;

  @override
  ShowModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShowModel(
      id: fields[0] as int? ?? 0,
      name: fields[1] as String? ?? '',
      image: fields[2] as String? ?? '',
      rating: (fields[3] as num?)?.toDouble() ?? 0.0,
      genres: (fields[4] as List?)?.cast<String>() ?? <String>[],
      summary: fields[5] as String? ?? '',
    );
  }

  @override
  void write(BinaryWriter writer, ShowModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.genres)
      ..writeByte(5)
      ..write(obj.summary);
  }
}

// Alias for flexibility
typedef ProductModel = ShowModel;
