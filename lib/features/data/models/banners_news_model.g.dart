// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banners_news_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BannersNewsModelAdapter extends TypeAdapter<BannersNewsModel> {
  @override
  final int typeId = 0;

  @override
  BannersNewsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BannersNewsModel(
      source: fields[6] as String,
      author: fields[1] as String,
      title: fields[0] as String,
      description: fields[2] as String,
      url: fields[7] as String,
      imageUrl: fields[4] as String,
      publishedAt: fields[5] as String,
      content: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BannersNewsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.publishedAt)
      ..writeByte(6)
      ..write(obj.source)
      ..writeByte(7)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BannersNewsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
