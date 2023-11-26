import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomFirebaseOptions {
  static final storage = FlutterSecureStorage();

  static Future<FirebaseOptions> get currentPlatform async {
    if (kIsWeb) {
      return web;
    }

    // Load the saved Firebase keys
    String apiKey =
        await storage.read(key: 'firebase_api_key') ?? 'default_api_key';
    String appId =
        await storage.read(key: 'firebase_app_id') ?? 'default_app_id';
    String messagingSenderId =
        await storage.read(key: 'firebase_sender_id') ?? 'default_sender_id';
    String projectId =
        await storage.read(key: 'firebase_project_id') ?? 'default_project_id';
    String storageBucket = await storage.read(key: 'firebase_storage_bucket') ??
        'default_storage_bucket';
    String iosBundleId =
        await storage.read(key: 'ios_bundle_id') ?? 'default_ios_bundle_id';
    String measurementId =
        await storage.read(key: 'measurement_id') ?? 'default_measurement_id';
    String authDomain =
        await storage.read(key: 'auth_domain') ?? 'default_auth_domain';

    // Create FirebaseOptions dynamically
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return FirebaseOptions(
          apiKey: apiKey,
          appId: appId,
          messagingSenderId: messagingSenderId,
          projectId: projectId,
          storageBucket: storageBucket,
          iosBundleId: iosBundleId,
          measurementId: measurementId,
          authDomain: authDomain,
          // ... other configuration values
        );
      default:
        throw UnsupportedError(
            'FirebaseOptions are not supported for this platform.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'default_api_key',
    appId: 'default_app_id',
    messagingSenderId: 'default_sender_id',
    projectId: 'default_project_id',
    authDomain: 'default_auth_domain',
    storageBucket: 'default_storage_bucket',
    measurementId: 'default_measurement_id',
  );

// ... other platform-specific options
}
