
import '../../../mode/configuration/configuration_response.dart';

abstract class ConfigurationLocalApi {

  /// Save Current logged in AllCategory
  Future<void> save(ConfigurationResponse mConfigurationResponse);

  /// Get Current logged in AllCategory
  Future<ConfigurationResponse?> getConfigurationResponse();

  /// Delete the current AllCategory
  Future<bool> deleteAllConfiguration();

  Future<void> clearBox();
}
