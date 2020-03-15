import 'dart:typed_data';

import 'package:hex/hex.dart';

import 'package:base_x/base_x.dart';
import 'package:test/test.dart';

var valid = <Map<String, String>>[
    {
      'alphabet': 'base2',
      'hex': '0f',
      'string': '1111'
    },
    {
      'alphabet': 'base16',
      'hex': '000fff',
      'string': '0fff'
    },
    {
      'alphabet': 'base58',
      'hex': '0efb18dccaeb61e855e56dbc35922b24f6ee6e37caa3a07ba923',
      'string': 'TcASfmyoFiNobNaCHeiPMkWgGmovoxk1sqk'
    }
];



void main() {
  var alphabets = {
    'base2': '01',
    'base16': '0123456789abcdef',
    'base58': '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'
  };
  var base = <String, BaseXCodec>{};
  alphabets.forEach((String key, String alphabet){
    base[key] = BaseXCodec(alphabet);
  });

  group('encode should return String', () {
    valid.forEach((Map<String, String> v){
      test('${v['alphabet']} encode ${v['string']}', () {
        var hex = base[v['alphabet']].encode(Uint8List.fromList(HEX.decode(v['hex'])));
        expect(v['string'], hex);
      });
    });
  });

  group('decode should return Uin8List', () {
    valid.forEach((Map<String, String> v){
      test('${v['alphabet']} decode ${v['hex']}',() {
        expect(HEX.decode(v['hex']), base[v['alphabet']].decode(v['string']));
      });
    });
  });
}
