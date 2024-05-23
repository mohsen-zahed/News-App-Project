// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_news_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeneralNewsModelAdapter extends TypeAdapter<GeneralNewsModel> {
  @override
  final int typeId = 2;

  @override
  GeneralNewsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneralNewsModel(
      source: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      author: fields[3] as String,
      url: fields[4] as String,
      imageUrl: fields[5] as String,
      publishedAt: fields[6] as String,
      content: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GeneralNewsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.source)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.publishedAt)
      ..writeByte(7)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneralNewsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
