abstract class Environment {
  final String kosaBaseUrl;

  Environment(this.kosaBaseUrl);
}

class StagingEnvironment extends Environment {
  StagingEnvironment() : super('https://kosa-staging.pariyatti.app');
}

class ProductionEnvironment extends Environment {
  ProductionEnvironment() : super('https://kosa.pariyatti.app');
}
