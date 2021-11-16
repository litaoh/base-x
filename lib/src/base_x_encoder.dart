part of basex;

class BaseXEncoder extends Converter<Uint8List, String> {
  const BaseXEncoder(this.alphabet);

  final String alphabet;

  @override
  String convert(Uint8List bytes) {
    var zeroes = 0;
    var length = 0;
    var begin = 0;
    var end = bytes.length;
    while (begin != end && bytes[begin] == 0) {
      begin++;
      zeroes++;
    }

    /// Allocate enough space in big-endian base58 representation.
    var size = ((end - begin) * (log(256) / log(alphabet.length)) + 1).toInt();
    var b58 = Uint8List(size);

    /// Process the bytes.
    while (begin != end) {
      var carry = bytes[begin];

      /// Apply "b58 = b58 * 256 + ch".
      var i = 0;
      for (var it1 = size - 1;
          (carry != 0 || i < length) && (it1 != -1);
          it1--, i++) {
        carry += (256 * b58[it1]);
        b58[it1] = (carry % alphabet.length);
        carry = (carry ~/ alphabet.length);
      }
      if (carry != 0) {
        throw FormatException('Non-zero carry');
      }
      length = i;
      begin++;
    }

    /// Skip leading zeroes in base58 result.
    var it2 = size - length;
    while (it2 != size && b58[it2] == 0) {
      it2++;
    }

    /// Translate the result into a string.
    var str = ''.padLeft(zeroes, alphabet[0]);
    for (; it2 < size; ++it2) {
      str += alphabet[b58[it2]];
    }
    return str;
  }
}
