// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.17;
pragma abicoder v2;

import {IAlpacaGovernance} from './interfaces/IAlpacaGovernance.sol';
import {IGovernanceStrategy} from './interfaces/IGovernanceStrategy.sol';
import {IVoteValidator} from './interfaces/IVoteValidator.sol';
import {add256, sub256, mul256, div256} from './Helpers.sol';

contract VoteValidator is IVoteValidator {
  uint256 public constant override VOTING_DURATION = 86400; // Blocks in 14 days
  uint256 public constant override VOTE_DIFFERENTIAL = 500; // 5%
  uint256 public constant override MINIMUM_QUORUM = 20000; // With ONE_HUNDRED_WITH_PRECISION being 100%
  uint256 public constant override ONE_HUNDRED_WITH_PRECISION = 10000;

  function isProposalPassed(IAlpacaGovernance governance, uint256 proposalId)
    external
    view
    override
    returns (bool)
  {
    return (isQuorumValid(governance, proposalId) &&
      isVoteDifferentialValid(governance, proposalId));
  }

  function getMinimumVotingPowerNeeded(uint256 votingSupply)
    public
    pure
    override
    returns (uint256)
  {
    return div256(mul256(votingSupply, MINIMUM_QUORUM), ONE_HUNDRED_WITH_PRECISION);
  }

  function isQuorumValid(IAlpacaGovernance governance, uint256 proposalId)
    public
    view
    override
    returns (bool)
  {
    IAlpacaGovernance.ProposalWithoutVotes memory proposal = governance.getProposalById(proposalId);
    uint256 votingSupply = IGovernanceStrategy(proposal.strategy).getTotalVotingSupplyAt(
      proposal.startBlock
    );

    return proposal.forVotes > getMinimumVotingPowerNeeded(votingSupply);
  }

  function isVoteDifferentialValid(IAlpacaGovernance governance, uint256 proposalId)
    public
    view
    override
    returns (bool)
  {
    IAlpacaGovernance.ProposalWithoutVotes memory proposal = governance.getProposalById(proposalId);
    uint256 votingSupply = IGovernanceStrategy(proposal.strategy).getTotalVotingSupplyAt(
      proposal.startBlock
    );

    return (div256(mul256(proposal.forVotes, ONE_HUNDRED_WITH_PRECISION), votingSupply) >
      add256(
        div256(mul256(proposal.againstVotes, ONE_HUNDRED_WITH_PRECISION), votingSupply),
        VOTE_DIFFERENTIAL
      ));
  }
}