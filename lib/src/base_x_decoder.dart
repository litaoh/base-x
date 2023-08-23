part of basex;

class BaseXDecoder extends Converter<String, Uint8List> {
  final String alphabet;
  final _baseMap = Uint8List(256);

  BaseXDecoder(this.alphabet) {
    _baseMap.fillRange(0, _baseMap.length, 255);
    for (var i = 0; i < alphabet.length; i++) {
      var xc = alphabet.codeUnitAt(i);
      if (_baseMap[xc] != 255) {
        throw FormatException('${alphabet[i]} is ambiguous');
      }
      _baseMap[xc] = i;
    }
  }

  /// An exception is thrown if [input] starts or ends with a space or has a character whose codeUnit is greater than 255.
  @override
  Uint8List convert(String input) {
    if (input.isEmpty) {
      return Uint8List(0);
    }
    var psz = 0;

    /// Skip leading spaces.
    if (input[psz] == ' ') {
      throw ArgumentError.value(
          input, 'input', 'input cannot begin with a space.');
    }

    /// Skip and count leading '1's.
    var zeroes = 0;
    var length = 0;
    while (input.length > psz && input[psz] == alphabet[0]) {
      zeroes++;
      psz++;
    }

    /// Allocate enough space in big-endian base256 representation.
    var size = (((input.length - psz) * (log(alphabet.length) / log(256))) + 1)
        .toInt();
    var b256 = Uint8List(size);

    /// Process the characters.
    while (psz < input.length && input[psz].isNotEmpty) {
      /// Decode character
      var carry = _baseMap[input[psz].codeUnitAt(0)];

      /// Invalid character
      if (carry == 255) {
        throw ArgumentError.value(input, 'input',
            'The character "${input[psz]}" at index $psz is invalid.');
      }
      var i = 0;
      for (var it3 = size - 1;
          (carry != 0 || i < length) && (it3 != -1);
          it3--, i++) {
        carry += (alphabet.length * b256[it3]);
        b256[it3] = (carry % 256);
        carry = (carry ~/ 256);
      }
      if (carry != 0) {
        throw FormatException('Non-zero carry');
      }
      length = i;
      psz++;
    }

    /// Skip trailing spaces.
    if (psz < input.length && input[psz] == ' ') {
      throw ArgumentError.value(
          input, 'input', 'input cannot end with a space.');
    }

    /// Skip leading zeroes in b256.
    var it4 = size - length;
    while (it4 != size && b256[it4] == 0) {
      it4++;
    }
    var vch = Uint8List(zeroes + (size - it4));
    if (zeroes != 0) {
      vch.fillRange(0, zeroes, 0x00);
    }
    var j = zeroes;
    while (it4 != size) {
      vch[j++] = b256[it4++];
    }
    return vch;
  }
}
