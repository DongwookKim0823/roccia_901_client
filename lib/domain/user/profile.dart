import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/constants/app_enum.dart';

import '../../utils/app_logger.dart';

part 'profile.g.dart';

typedef RecordStatistics = List<({BoulderLevel level, int count})>;

@JsonSerializable(
  checked: true,
  includeIfNull: false,
  fieldRename: FieldRename.snake,
)
class MyPageModel {
  final ProfileModel profile;
  final int totalWorkoutTime;
  @JsonKey(fromJson: _recordStatisticsFromJson, includeToJson: false)
  final RecordStatistics records;
  final MyPageCount attendanceStats;

  const MyPageModel({
    required this.profile,
    required this.totalWorkoutTime,
    required this.records,
    required this.attendanceStats,
  });

// ------------------------------------------------------------------------ //
//                      JSON SERIALIZATION                                  //
// ------------------------------------------------------------------------ //
  factory MyPageModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$MyPageModelFromJson(json);
    } on CheckedFromJsonException catch (e) {
      logger.w('MyPage.fromJson: $e');
      rethrow;
    }
  }

  static RecordStatistics _recordStatisticsFromJson(List<dynamic> json) {
    return RecordStatistics.from(
      json.map(
        (e) => (level: BoulderLevel.fromName[e["workout_level"] as String], count: e["total_count"] as int),
      ),
    );
  }
}

@JsonSerializable(
  checked: true,
  includeIfNull: false,
  fieldRename: FieldRename.snake,
)
class ProfileModel {
  @JsonKey(name: "username")
  final String name;
  final String generation;
  final UserRole role;
  @JsonKey(name: "workout_location")
  final Location location;
  @JsonKey(name: "workout_level")
  final BoulderLevel level;
  @JsonKey(name: "profile_number")
  final int profileImageNumber;
  final String introduction;

  const ProfileModel({
    required this.name,
    required this.generation,
    required this.role,
    required this.location,
    required this.level,
    required this.profileImageNumber,
    required this.introduction,
  });

  // ------------------------------------------------------------------------ //
  //                      JSON SERIALIZATION                                  //
  // ------------------------------------------------------------------------ //
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$ProfileModelFromJson(json);
    } on CheckedFromJsonException catch (e) {
      logger.w('ProfileModel.fromJson: $e');
      rethrow;
    }
  }
}

@JsonSerializable(
  checked: true,
  includeIfNull: false,
  fieldRename: FieldRename.snake,
)
class ProfileUpdateModel {
  @JsonKey(name: "workout_location")
  final Location? location;
  @JsonKey(name: "workout_level")
  final BoulderLevel? level;
  @JsonKey(name: "profile_number")
  final int? profileImageNumber;
  @JsonKey()
  final String? introduction;

  const ProfileUpdateModel({
    this.location,
    this.level,
    this.profileImageNumber,
    this.introduction,
  });

  // ------------------------------------------------------------------------ //
  //                      JSON SERIALIZATION                                  //
  // ------------------------------------------------------------------------ //
  Map<String, dynamic> toJson() => _$ProfileUpdateModelToJson(this);
}

@JsonSerializable(
  checked: true,
  fieldRename: FieldRename.snake,
)
class MyPageCount {
  @JsonKey(fromJson: _countFromJson)
  final int attendance;
  @JsonKey(fromJson: _countFromJson)
  final int late;
  @JsonKey(fromJson: _countFromJson)
  final int absence;

  MyPageCount({
    required this.attendance,
    required this.late,
    required this.absence,
  });

  // ------------------------------------------------------------------------ //
  //                      JSON SERIALIZATION                                  //
  // ------------------------------------------------------------------------ //
  factory MyPageCount.fromJson(Map<String, dynamic> json) => _$MyPageCountFromJson(json);

  static int _countFromJson(dynamic json) {
    if (json == null) {
      return 0;
    }
    return json as int;
  }
}
