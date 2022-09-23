// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.17;
pragma experimental ABIEncoderV2;

import {Ownable} from './Ownable.sol';
import {IVotingStrategy} from './Interfaces/IVotingStrategy.sol';
import {IPropositionStrategy} from './Interfaces/IPropositionStrategy.sol';
import {IExecutorWithTimelock} from './Interfaces/IExecutorWithTimelock.sol';
import {isContract, add256, sub256, getChainId} from './Helpers.sol';

// TODO review if cancelled state is needed
// TODO review if nonce is needed for vote with signature, in order to allow overriding of votes
// TODO review if it's important to validate that the creator doesn't have other proposals in parallel (on creation) If so, needed to recover the
//     mapping (address => uint) public latestProposalIds;
// TODO should validate the quorum and voting durations coming from the timelock on creation?
// TODO review if needed to NOT allow to override votes  (hasVote on Vote struct)
// TODO review if it's a problem to start proposals from id 0
// TODO add getters
// TODO add events
contract AlpacaGovernance is Ownable {
  struct Vote {
    bool support;
    uint248 votingPower;
  }

  struct Proposal {
    uint256 id;
    address creator;
    IExecutorWithTimelock executor;
    address payload;
    uint256 startBlock;
    uint256 endBlock;
    uint256 executionBlock;
    uint256 forVotes;
    uint256 againstVotes;
    bool executed;
    address strategy;
    bytes32 ipfsHash;
    mapping(address => Vote) votes;
  }

  enum ProposalState {Pending, Active, Failed, Succeeded, Queued, Expired, Executed}

  address private _governanceStrategy;
  uint256 private _propositionPowerThreshold;
  uint256 private _votingDelay;
}