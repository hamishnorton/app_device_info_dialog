
import 'package:flutter/foundation.dart';

class BuildInfo {
  static const runMode = (kDebugMode)
      ? 'Debug'
      : (kProfileMode)
          ? 'Profile'
          : (kReleaseMode)
              ? 'Release'
              : 'Unknown';
}
