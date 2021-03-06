import 'package:polkadot_dart/types/scale_codec/scale_codec_reader.dart';
import 'package:polkadot_dart/types/scale_codec/scale_reader.dart';
import 'package:polkadot_dart/types/scale_codec/union_value.dart';

class UnionReader<T> implements ScaleReader<UnionValue<T>> {
  List<ScaleReader<T>> mapping;

  UnionReader(List<ScaleReader<T>> mapping) {
    this.mapping = mapping;
  }

  UnionValue<T> read(ScaleCodecReader rdr) {
    int index = rdr.readUByte();
    if (mapping.length <= index) {
      throw "Unknown type index: $index";
    }
    T value = mapping[index].read(rdr);
    return UnionValue(index, value);
  }
}
