const SLOT_RANGE_COUNT = 10;

const proposeTypes = {
  "ParachainProposal": {
    "proposer": "AccountId",
    "validationFunction": "ValidationCode",
    "initialHeadState": "HeadData",
    "validators": "Vec<ValidatorId>",
    "name": "Vec<u8>",
    "balance": "Balance"
  },
  "RegisteredParachainInfo": {"validators": "Vec<ValidatorId>", "proposer": "AccountId"}
};

const defs = {
  "rpc": {},
  "types": {
    ...proposeTypes,
    "AbridgedCandidateReceipt": {
      "parachainIndex": "ParaId",
      "relayParent": "Hash",
      "headData": "HeadData",
      "collator": "CollatorId",
      "signature": "CollatorSignature",
      "povBlockHash": "Hash",
      "commitments": "CandidateCommitments"
    },
    "AttestedCandidate": {
      "candidate": "AbridgedCandidateReceipt",
      "validityVotes": "Vec<ValidityAttestation>",
      "validatorIndices": "BitVec"
    },
    "AuctionIndex": "u32",
    "BackedCandidate": {
      "candidate": "CommittedCandidateReceipt",
      "validityVotes": "Vec<ValidityAttestation>",
      "validatorIndices": "BitVec"
    },
    "Bidder": {
      "_enum": {"New": "NewBidder", "Existing": "ParaId"}
    },
    "CandidateCommitments": {
      "upwardMessages": "Vec<UpwardMessage>",
      "horizontalMessages": "Vec<OutboundHrmpMessage>",
      "newValidationCode": "Option<ValidationCode>",
      "headData": "HeadData",
      "processedDownwardMessages": "u32",
      "hrmpWatermark": "BlockNumber"
    },
    "CandidateDescriptor": {
      "paraId": "u32",
      "relayParent": "Hash",
      "collatorId": "Hash",
      "persistedValidationDataHash": "Hash",
      "povHash": "Hash",
      "erasureRoot": "Hash",
      "signature": "Signature"
    },
    "CandidatePendingAvailablility": {
      "core": "u32",
      "descriptor": "CandidateDescriptor",
      "availabilityVotes": "BitVec",
      "relayParentNumber": "BlockNumber",
      "backedInNumber": "BlockNumber"
    },
    "CandidateReceipt": {"descriptor": "CandidateDescriptor", "commitmentsHash": "Hash"},
    "CollatorId": "[u8; 32]",
    "CollatorSignature": "Signature",
    "CommittedCandidateReceipt": {
      "descriptor": "CandidateDescriptor",
      "commitments": "CandidateCommitments"
    },
    "DoubleVoteReport": {
      "identity": "ValidatorId",
      "first": "(Statement, ValidatorSignature)",
      "second": "(Statement, ValidatorSignature)",
      "proof": "MembershipProof",
      "signingContext": "SigningContext"
    },
    "DownwardMessage": {
      "_enum": {"TransferInto": "(AccountId, Balance, Remark)", "Opaque": "Vec<u8>"}
    },
    "GlobalValidationSchedule": {
      "maxCodeSize": "u32",
      "maxHeadDataSize": "u32",
      "blockNumber": "BlockNumber"
    },
    "HeadData": "Bytes",
    "HrmpChannelId": {"sender": "u32", "receiver": "u32"},
    "IncomingParachain": {
      "_enum": {
        "Unset": "NewBidder",
        "Fixed": "IncomingParachainFixed",
        "Deploy": "IncomingParachainDeploy"
      }
    },
    "IncomingParachainFixed": {
      "codeHash": "Hash",
      "codeSize": "u32",
      "initialHeadData": "HeadData"
    },
    "IncomingParachainDeploy": {"code": "ValidationCode", "initialHeadData": "HeadData"},
    "LeasePeriod": "BlockNumber",
    "LeasePeriodOf": "LeasePeriod",
    "LocalValidationData": {
      "parentHead": "HeadData",
      "balance": "Balance",
      "codeUpgradeAllowed": "Option<BlockNumber>"
    },
    "NewBidder": {"who": "AccountId", "sub": "SubId"},
    "OutboundHrmpMessage": {"recipient": "u32", "data": "Bytes"},
    "ParachainDispatchOrigin": {
      "_enum": ["Signed", "Parachain", "Root"]
    },
    "ParaId": "u32",
    "ParaInfo": {"scheduling": "Scheduling"},
    "ParaPastCodeMeta": {"upgradeTimes": "Vec<BlockNumber>", "lastPruned": "Option<BlockNumber>"},
    "ParaScheduling": {
      "_enum": ["Always", "Dynamic"]
    },
    "RelayChainBlockNumber": "BlockNumber",
    "Remark": "[u8; 32]",
    "Retriable": {
      "_enum": {"Never": "Null", "WithRetries": "u32"}
    },
    "Scheduling": {
      "_enum": ["Always", "Dynamic"]
    },
    "SignedAvailabilityBitfield": {
      "payload": "BitVec",
      "validatorIndex": "u32",
      "signature": "Signature"
    },
    "SignedAvailabilityBitfields": "Vec<SignedAvailabilityBitfield>",
    "SigningContext": {"sessionIndex": "SessionIndex", "parentHash": "Hash"},
    "SlotRange": {
      "_enum": [
        "ZeroZero",
        "ZeroOne",
        "ZeroTwo",
        "ZeroThree",
        "OneOne",
        "OneTwo",
        "OneThree",
        "TwoTwo",
        "TwoThree",
        "ThreeThree"
      ]
    },
    "Statement": {
      "_enum": {"Never": "Null", "Candidate": "Hash", "Valid": "Hash", "Invalid": "Hash"}
    },
    "SubId": "u32",
    "UpwardMessage": "Bytes",
    "ValidationFunctionParams": {
      "maxCodeSize": "u32",
      "relayChainHeight": "RelayChainBlockNumber",
      "codeUpgradeAllowed": "Option<RelayChainBlockNumber>"
    },
    "ValidationCode": "Bytes",
    "ValidatorSignature": "Signature",
    "ValidityAttestation": {
      "_enum": {"Never": "Null", "Implicit": "ValidatorSignature", "Explicit": "ValidatorSignature"}
    },
    "WinningData": "[WinningDataEntry; $SLOT_RANGE_COUNT]",
    "WinningDataEntry": "Option<Bidder>"
  }
};
