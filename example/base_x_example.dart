import 'dart:typed_data';

import 'package:base_x/base_x.dart';

void main() {
  var base58 = BaseXCodec('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');

  var hash = Uint8List.fromList([14, 251, 24, 220, 202, 235, 97, 232, 85, 229, 109, 188, 53, 146, 43, 36, 246, 238, 110, 55, 202, 163, 160, 123, 169, 35]);

  print(base58.encode(hash));
  
  print(base58.decode('TcASfmyoFiNobNaCHeiPMkWgGmovoxk1sqk'));

}
