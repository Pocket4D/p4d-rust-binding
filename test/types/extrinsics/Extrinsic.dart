import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/metadata/Metadata.dart';
import 'package:polkadot_dart/types/extrinsic/Extrinsic.dart';
import 'package:polkadot_dart/types/types.dart' hide Metadata;
import '../../metadata/v12/v12.dart' as rpcMetadata;

void main() {
  extrinsicTest(); // rename this test name
}

void extrinsicTest() {
  final registry = new TypeRegistry();
  final metadata = new Metadata(registry, rpcMetadata.v12);
  registry.setMetadata(metadata);
  group('Extrinsic', () {
    group('V4', () {
      test('decodes an actual transaction', () {
        final extrinsic = GenericExtrinsic(
            registry,
            '0x' +
                '5d02' + // length
                '84' + // V4, signing bit set
                'ff' + // lookup, AccountId of sender follows
                'fcc4910cb536b4333db4bccb40e2cf6427b4766518e754b91e70c97e4a87dbb3' + // sender
                '00' + // multisig, type ed25519
                'd99ffe3e610ad234e1414bda5831395a6df9098bf80b01561ce89a5065ae89d5' + // sig first 32
                'c10e1619c6c99131b0bea4fb73ef04d07c07770e2ae9df5c325c331769ccb300' + // sig last 32
                'a90b' + // mortal era
                '1101' + // nonce, compact 68
                '0700ac23fc06' + // tip, 0.03 KSM
                '0600' + // balances.transfer (on Kusama this was 0400, changed here to match metadata)
                'ff' + // lookup, AccountId of recipient follows
                '495e1e506f266418af07fa0c5c108dd436f2faa59fe7d9e54403779f5bbd7718' + // recipient
                '0bc01eb1fc185f' // value, 104.560 KSM
            );

        expect(extrinsic.era.toHuman(), {
          "MortalEra": {"period": '1,024', "phase": '186'}
        });
        expect(extrinsic.nonce.toNumber(), 68);
        expect(extrinsic.tip.toHuman(), '30.0000 mUnit');
        expect(extrinsic.callIndex, Uint8List.fromList([6, 0]));
        expect(extrinsic.args[0].toHex(),
            '0xff495e1e506f266418af07fa0c5c108dd436f2faa59fe7d9e54403779f5bbd7718');
        expect(extrinsic.args[1].toHuman(), '104.5609 Unit');
      });
    });
  });
}
