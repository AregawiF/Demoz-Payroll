// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String,
      email: fields[1] as String,
      companyName: fields[2] as String,
      companyAddress: fields[3] as String,
      phoneNumber: fields[4] as String,
      tinNumber: fields[5] as String,
      numberOfEmployees: fields[6] as int,
      companyBank: fields[7] as String,
      bankAccountNumber: fields[8] as String,
      role: fields[9] as String,
      createdAt: fields[10] as DateTime,
      isActive: fields[11] as bool,
      password: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.companyName)
      ..writeByte(3)
      ..write(obj.companyAddress)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.tinNumber)
      ..writeByte(6)
      ..write(obj.numberOfEmployees)
      ..writeByte(7)
      ..write(obj.companyBank)
      ..writeByte(8)
      ..write(obj.bankAccountNumber)
      ..writeByte(9)
      ..write(obj.role)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.isActive)
      ..writeByte(12)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
