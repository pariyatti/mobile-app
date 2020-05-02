abstract class Environment {
  final String kosaBaseUrl;

  Environment(this.kosaBaseUrl);
}

class SandboxEnvironment extends Environment {
  SandboxEnvironment() : super(
      'http://kosa-sandbox.pariyatti.org'
  );
}

class ProductionEnvironment extends Environment {
  ProductionEnvironment() : super(
    'http://kosa.pariyatti.org'
  );
}
