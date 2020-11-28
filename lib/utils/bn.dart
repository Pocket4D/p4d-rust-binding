import 'dart:typed_data';

import 'package:polkadot_dart/polkadot_dart.dart';
import 'package:polkadot_dart/utils/number.dart';

BigInt bnToBn(dynamic value) {
  if (value == null) {
    return BigInt.zero;
  }

  if (value is BigInt) {
    return value;
  } else if (value is num) {
    return BigInt.from(value);
  } else if (value is String) {
    return BigInt.parse(value, radix: 16);
  }

  throw Exception(" bnToBn " + value);
}

BigInt bitnot(BigInt bn, {int bitLength}) {
  // JavaScript's bitwise not doesn't work on negative BigInts (bn = ~bn; // WRONG!)
  // so we manually implement our own two's compliment (flip bits, add one)
  bn = -bn;
  var bin = (bn).toRadixString(2);

  var prefix = '';
  while (bin.length % 8 != 0) {
    bin = '0' + bin;
  }

  if ('1' == bin[0] && -1 != bin.substring(1).indexOf('1')) {
    prefix = '1' * 8;
  }

  if (bitLength != null && bitLength > 0 && bitLength > bin.length) {
    prefix = '1' * (bitLength - bin.length);
  }

  bin = bin.split('').map((i) {
    return '0' == i ? '1' : '0';
  }).join('');

  return BigInt.parse(prefix + bin, radix: 2) + BigInt.one;
}

String bnToHex(BigInt bn,
    {int bitLength = -1, Endian endian = Endian.big, bool isNegative = false}) {
  var u8a = bnToU8a(bn, bitLength: bitLength, endian: endian, isNegative: isNegative);
  return u8aToHex(u8a, include0x: true);

  // var pos = true;
  // bn = bnToBn(bn);

  // // I've noticed that for some operations BigInts can
  // // only be compared to other BigInts (even small ones).
  // // However, <, >, and == allow mix and match
  // if (bn.compareTo(BigInt.zero) < 0) {
  //   pos = false;
  //   bn = bitnot(bn);
  // }

  // var base = 16;
  // var hex = bn.toRadixString(base);
  // if (hex.length % 2 > 0) {
  //   hex = '0' + hex;
  // }

  // // Check the high byte _after_ proper hex padding
  // var highbyte = int.parse(hex.substring(0, 2), radix: 16);
  // var highbit = (0x80 & highbyte);

  // if (pos && highbit != 0) {
  //   // A 32-byte positive integer _may_ be
  //   // represented in memory as 33 bytes if needed
  //   hex = '00' + hex;
  // }

  // return hexAddPrefix(hex);
}

class Options {
  int bitLength;
  Endian endian;
  bool isNegative;
}

Uint8List bnToU8a(BigInt value,
    {int bitLength = -1, Endian endian = Endian.little, bool isNegative = false}) {
  BigInt valueBn = bnToBn(value);
  int byteLength;
  if (bitLength == -1) {
    byteLength = (valueBn.bitLength / 8).ceil();
  } else {
    byteLength = ((bitLength ?? 0) / 8).ceil();
  }

  if (value == null) {
    if (bitLength == -1) {
      return Uint8List.fromList([0]);
    } else {
      return Uint8List(byteLength);
    }
  }

  var newU8a = encodeBigInt(isNegative ? bitnot(value, bitLength: byteLength * 8) : value,
      endian: endian, bitLength: byteLength * 8);

  var ret = Uint8List(byteLength);

  ret.setAll(0, newU8a);
  return ret;
}

final bnZero = BigInt.zero;
final bnOne = BigInt.one;
final bnTen = BigInt.from(10);
final bnHundred = BigInt.from(100);
final bnThrousand = BigInt.from(1000);

BigInt bnMax(List<BigInt> list) {
  list.sort((a, b) => a.compareTo(b));
  return list.last;
}

BigInt bnMin(List<BigInt> list) {
  list.sort((a, b) => a.compareTo(b));
  return list.first;
}

BigInt bnSqrt(BigInt bn) {
  return bn < BigInt.from(2) ? bn : newtonIteration(bn, BigInt.from(1));
}

BigInt newtonIteration(BigInt n, BigInt x0) {
  var x1 = (BigInt.from(n / x0) + x0) >> 1;
  if (x0 == x1 || x0 == (x1 - BigInt.from(1))) {
    return x0;
  }
  return newtonIteration(n, x1);
}
