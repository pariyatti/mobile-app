class EnvironmentConfig {
  static const BUILD_ENV = String.fromEnvironment(
    'BUILD_ENV',
    defaultValue: 'local'
  );
}