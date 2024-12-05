// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeModelAdapter extends TypeAdapter<EmployeeModel> {
  @override
  final int typeId = 0;

  @override
  EmployeeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeModel(
      id: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      salary: fields[3] as double,
      incomeTax: fields[4] as double,
      pensionTax: fields[5] as double,
      gender: fields[6] as String,
      joiningDate: fields[7] as DateTime,
      isActive: fields[8] as bool,
      grossPay: fields[9] as double,
      taxableEarnings: fields[10] as double,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.salary)
      ..writeByte(4)
      ..write(obj.incomeTax)
      ..writeByte(5)
      ..write(obj.pensionTax)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.joiningDate)
      ..writeByte(8)
      ..write(obj.isActive)
      ..writeByte(9)
      ..write(obj.grossPay)
      ..writeByte(10)
      ..write(obj.taxableEarnings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
