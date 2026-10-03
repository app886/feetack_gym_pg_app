class AgoraConfig {
  /// Your Agora App ID
  static const String appId = "abb7a4c011944b3f82e844fc14608b29";

  /// Your Agora Primary Certificate
  static const String primaryCertificate = "aeea9857fe8e4efaa01dc767b0aebd26";

  /// Temporary Token generated from Agora Console for testing channel
  /// Or leave empty if testing in dynamic token mode / token server.
  /// NOTE: Because Primary Certificate is enabled in your Console, 
  /// calls require a valid RTC token generated for the channel.
  static const String tempToken = "";

  /// Default channel name for testing
  static const String defaultChannel = "hospital_consultation";
}
