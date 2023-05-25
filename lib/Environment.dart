abstract class Environment {
  final String kosaBaseUrl;

  Environment(this.kosaBaseUrl);
}

class SandboxEnvironment extends Environment {
  SandboxEnvironment() : super('https://kosa-sandbox.pariyatti.app');
}

class ProductionEnvironment extends Environment {
  ProductionEnvironment() : super('https://kosa.pariyatti.app');
}
