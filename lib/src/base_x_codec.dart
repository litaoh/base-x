part of basex;

class BaseXCodec extends Codec<Uint8List, String> {
  BaseXCodec(this.alphabet)
      : encoder = BaseXEncoder(alphabet),
        decoder = BaseXDecoder(alphabet);

  final String alphabet;

  @override
  final BaseXEncoder encoder;

  @override
  final BaseXDecoder decoder;
}
