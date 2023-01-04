class Chanting {
  late Uri _audioUrl;
  late Uri _sngUrl;
  late bool _isSngChanting;

  Uri get audioUrl => _audioUrl;
  Uri get specialUrl => _sngUrl;
  bool get isSpecialVisible => _isSngChanting;

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
    if (!isSpecialVisible && sngSupported.contains(_audioUrl)) {
      return new Chanting(_audioUrl, true);
    }
    if (isSpecialVisible) {
      return new Chanting(_audioUrl, false);
    }
    return this;
  }


}