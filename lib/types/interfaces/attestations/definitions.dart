final defs = {
  "rpc": {},
  "types": {
    "BlockAttestations": {
      "receipt": 'CandidateReceipt',
      "valid": 'Vec<AccountId>',
      "invalid": 'Vec<AccountId>'
    },
    "IncludedBlocks": {
      "actualNumber": 'BlockNumber',
      "session": 'SessionIndex',
      "randomSeed": 'H256',
      "activeParachains": 'Vec<ParaId>',
      "paraBlocks": 'Vec<Hash>'
    },
    "MoreAttestations": {}
  }
};