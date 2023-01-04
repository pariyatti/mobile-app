class Chanting {
  late Uri _audioUrl;
  late Uri _sngUrl;
  late bool _isSngChanting;

  Uri get audioUrl => _audioUrl;
  Uri get sngUrl => _sngUrl;
  bool get isSngChanting => _isSngChanting;

  final List<Uri> sngSupported = [Uri.parse("https://download.pariyatti.org/dwob/sutta_nipata_2_271.mp3"),
    Uri.parse("https://download.pariyatti.org/dwob/digha_nikaya_2_221.mp3"),
    Uri.parse("https://download.pariyatti.org/dwob/sutta_nipata_2_238.mp3"),
    Uri.parse("https://download.pariyatti.org/dwob/dhammapada_11_153_11_154.mp3")];

  Chanting(audioUrl, [isSngChanting = false]) {
    _audioUrl = audioUrl;
    _sngUrl = Uri.parse(audioUrl.toString().replaceFirst("/dwob", "/dwob/sng"));
    _isSngChanting = isSngChanting;
  }

  Chanting tryToggle() {
    print("list contains? ${sngSupported.contains(_audioUrl)}");
    if (!isSngChanting && sngSupported.contains(_audioUrl)) {
      return new Chanting(_audioUrl, true);
    }
    if (isSngChanting) {
      return new Chanting(_audioUrl, false);
    }
    return this;
  }


}