part of basex;

class BaseXCodec extends Codec<Uint8List, String> {
  String alphabet;
  BaseXEncoder _encoder;
  BaseXDecoder _decoder;
  BaseXCodec(this.alphabet);

  @override
  Converter<Uint8List, String> get encoder {
    _encoder ??= BaseXEncoder(alphabet);
    return _encoder;
  }

  @override
  Converter<String, Uint8List> get decoder {
    _decoder ??= BaseXDecoder(alphabet);
    return _decoder;
  }
}
