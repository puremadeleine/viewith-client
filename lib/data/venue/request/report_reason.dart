enum ReportReason {
  offensive('OFFENSIVE', '욕설 및 비방 등 불쾌한 표현'),
  privacyViolation('PRIVACY_VIOLATION', '초상권 침해'),
  other('OTHER', '기타');

  const ReportReason(this.value, this.displayName);
  
  final String value;
  final String displayName;
}
