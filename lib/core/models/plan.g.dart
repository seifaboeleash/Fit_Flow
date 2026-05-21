// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlanAdapter extends TypeAdapter<Plan> {
  @override
  final int typeId = 0;

  @override
  Plan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Plan(
      id: fields[0] as String,
      name: fields[1] as String,
      goal: fields[2] as String,
      daysPerWeek: fields[3] as int,
      days: (fields[4] as List).cast<PlanDay>(),
    );
  }

  @override
  void write(BinaryWriter writer, Plan obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.goal)
      ..writeByte(3)
      ..write(obj.daysPerWeek)
      ..writeByte(4)
      ..write(obj.days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlanDayAdapter extends TypeAdapter<PlanDay> {
  @override
  final int typeId = 1;

  @override
  PlanDay read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlanDay(
      dayNumber: fields[0] as int,
      exercises: (fields[1] as List).cast<PlanExercise>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlanDay obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dayNumber)
      ..writeByte(1)
      ..write(obj.exercises);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanDayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlanExerciseAdapter extends TypeAdapter<PlanExercise> {
  @override
  final int typeId = 2;

  @override
  PlanExercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlanExercise(
      name: fields[0] as String,
      sets: fields[1] as int,
      reps: fields[2] as int,
      durationMinutes: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PlanExercise obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.sets)
      ..writeByte(2)
      ..write(obj.reps)
      ..writeByte(3)
      ..write(obj.durationMinutes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
