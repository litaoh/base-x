# base-x

Fast base encoding / decoding of any given alphabet using bitcoin style leading zero compression.

**WARNING:** This module is **NOT RFC3548** compliant,  it cannot be used for base16 (hex), base32, or base64 encoding in a standards compliant manner. 

## Example

Base58

``` dart
import 'package:base_x/base_x.dart';


var base58 = BaseXCodec('123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz');

var hash = Uint8List.fromList([14, 251, 24, 220, 202, 235, 97, 232, 85, 229, 109, 188, 53, 146, 43, 36, 246, 238, 110, 55, 202, 163, 160, 123, 169, 35]);

print(base58.encode(hash));
///TcASfmyoFiNobNaCHeiPMkWgGmovoxk1sqk

print(base58.decode('TcASfmyoFiNobNaCHeiPMkWgGmovoxk1sqk'));
///[14, 251, 24, 220, 202, 235, 97, 232, 85, 229, 109, 188, 53, 146, 43, 36, 246, 238, 110, 55, 202, 163, 160, 123, 169, 35]

```

### Alphabets

See below for a list of commonly recognized alphabets, and their respective base.

Base | Alphabet
------------- | -------------
2 | `01`
8 | `01234567`
11 | `0123456789a`
16 | `0123456789abcdef`
32 | `0123456789ABCDEFGHJKMNPQRSTVWXYZ`
32 | `ybndrfg8ejkmcpqxot1uwisza345h769` (z-base-32)
36 | `0123456789abcdefghijklmnopqrstuvwxyz`
58 | `123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz`
62 | `0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`
64 | `ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/`
66 | `ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_.!~` 


## LICENSE [MIT](LICENSE)
A direct derivation of the base58 implementation from [`bitcoin/bitcoin`](https://github.com/bitcoin/bitcoin/blob/f1e2f2a85962c1664e4e55471061af0eaa798d40/src/base58.cpp),  generalized for variable length alphabets.
