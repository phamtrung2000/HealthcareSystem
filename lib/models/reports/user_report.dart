class UserReport {
  final UserReportType type;
  final bool receiveEmail;

//<editor-fold desc="Data Methods">

  const UserReport({required this.type, required this.receiveEmail});

  @override
  String toString() {
    return 'UserReport{' +
        ' type: $type,' +
        ' receiveEmail: $receiveEmail,' +
        '}';
  }

  UserReport copyWith({
    UserReportType? type,
    bool? receiveEmail,
  }) {
    return UserReport(
      type: type ?? this.type,
      receiveEmail: receiveEmail ?? this.receiveEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': this.type,
      'receiveEmail': this.receiveEmail,
    };
  }

  factory UserReport.fromMap(Map<String, dynamic> map) {
    return UserReport(
      type: map['type'] as UserReportType,
      receiveEmail: map['receiveEmail'] as bool,
    );
  }

//</editor-fold>
}

enum UserReportType {
  fakeAccount,
  abuse,
  violateCommunityStandard,
  violateTermOfUse
}

extension UsereportTypeExtension on UserReportType {
  int get value {
    final values = {
      UserReportType.fakeAccount: 1,
      UserReportType.abuse: 2,
      UserReportType.violateCommunityStandard: 3,
      UserReportType.violateTermOfUse: 4,
    };
    return values[this]!;
  }
}
