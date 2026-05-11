import 'package:ff_commons/flutter_flow/enums.dart';
export 'package:ff_commons/flutter_flow/enums.dart';

/// user gender
enum Gender {
  Male,
  Female,
  Animal,
}

/// Blood Types
enum Blood {
  DontKnow,
  APositif,
  ANegative,
  BPositif,
  BNegative,
  ABPositif,
  ABNegative,
  OPostif,
  ONegative,
}

/// Prefered Language
enum Language {
  Arabic,
  Francais,
  English,
}

enum Role {
  Patient,
  Doctor,
}

enum PlanDuration {
  quinze_minutes,
  trente_minutes,
  une_heure,
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (Gender):
      return Gender.values.deserialize(value) as T?;
    case (Blood):
      return Blood.values.deserialize(value) as T?;
    case (Language):
      return Language.values.deserialize(value) as T?;
    case (Role):
      return Role.values.deserialize(value) as T?;
    case (PlanDuration):
      return PlanDuration.values.deserialize(value) as T?;
    default:
      return null;
  }
}
