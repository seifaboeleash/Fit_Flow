enum EnvType { dev, prod }

class AppConfig {
  final EnvType envType;
  final String baseUrl;
  final String appName;

  AppConfig({required this.envType, required this.baseUrl, required this.appName});

  factory AppConfig.fromEnv(EnvType envType) {
    switch (envType) {
      case EnvType.dev:
        return AppConfig(
          envType: envType,
          baseUrl: "https://api.example.com",
          appName: "FitFlow (Dev)",
        );
      case EnvType.prod:
        return AppConfig(
          envType: envType,
          baseUrl: "https://api.example.com",
          appName: "FitFlow",
        );
    }
  }
}