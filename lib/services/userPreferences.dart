import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserPreferencesService {
  final storage = FlutterSecureStorage();

  Future<void> setApiKey(String apiKey) async {
    await storage.write(key: 'api_key', value: apiKey);
  }

  Future<String?> getApiKey() async {
    return await storage.read(key: 'api_key');
  }

  Future<void> setDatabaseInfo(String databaseInfo) async {
    await storage.write(key: 'database_info', value: databaseInfo);
  }

  Future<String?> getDatabaseInfo() async {
    return await storage.read(key: 'database_info');
  }

  Future<void> configureFirebase(String userFirebaseConfig) async {
    // Parse the userFirebaseConfig to get Firebase options
    // Initialize Firebase with these options
    // This might require using FirebaseApp instances
  }

// Add more methods for other user preferences as needed
}
