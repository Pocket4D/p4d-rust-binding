import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/types.dart' hide Call;

// /** @internal */
// decodeLatestSubstrate<Modules extends BaseCodec> (Registry registry, int version, String rpcData, Map<String,dynamic>staticSubstrate) {
//   test('decodes latest substrate properly', () {
//     final metadata = Metadata(registry, rpcData);

//     registry.setMetadata(metadata);

//     try {
//       expect(metadata.version).toBe(version);
//       expect((metadata[`asV${version}` as keyof Metadata] as unknown as MetadataInterface<Modules>).modules.length).not.toBe(0);
//       expect(metadata.toJSON()).toEqual(staticSubstrate);
//     } catch (error) {
//       console.error(JSON.stringify(metadata.toJSON()));

//       throw error;
//     }
//   });
// }

// /** @internal */
// export function toLatest<Modules extends Codec> (registry: Registry, version: number, rpcData: string, wtesthThrow = true): void {
//   it(`converts v${version} to latest`, (): void => {
//     const metadata = new Metadata(registry, rpcData);

//     registry.setMetadata(metadata);

//     const metadataInit = metadata[`asV${version}` as keyof Metadata];
//     const metadataLatest = metadata.asLatest;

//     expect(
//       getUniqTypes(registry, metadataInit as unknown as MetadataInterface<Modules>, withThrow)
//     ).toEqual(
//       getUniqTypes(registry, metadataLatest, withThrow)
//     );
//   });
// }

// /** @internal */
// export function defaultValues (registry: Registry, rpcData: string, withThrow = true): void {
//   describe('storage with default values', (): void => {
//     const metadata = new Metadata(registry, rpcData);

//     metadata.asLatest.modules.filter(({ storage }): boolean => storage.isSome).forEach((mod): void => {
//       mod.storage.unwrap().items.forEach(({ fallback, name, type }): void => {
//         const inner = unwrapStorageType(type);
//         const location = `${mod.name.toString()}.${name.toString()}: ${inner}`;

//         it(`creates default types for ${location}`, (): void => {
//           expect((): void => {
//             try {
//               registry.createType(inner, fallback);
//             } catch (error) {
//               const message = `${location}:: ${(error as Error).message}`;

//               if (withThrow) {
//                 throw new Error(message);
//               } else {
//                 console.warn(message);
//               }
//             }
//           }).not.toThrow();
//         });
//       });
//     });
//   });
// }
