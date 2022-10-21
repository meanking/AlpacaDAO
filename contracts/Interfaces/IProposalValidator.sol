// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.17;
pragma abicoder v2;

import {IAlpacaGovernance} from './IAlpacaGovernance.sol';

interface IProposalValidator {
  function validateCreatorOfProposal(
    IAlpacaGovernance governance,
    address user,
    uint256 blockNumber
  ) external view;

  function isPropositionPowerEnough(
    IAlpacaGovernance governance,
    address user,
    uint256 blockNumber
  ) external view returns (bool);

  function getMinimumPropositionPowerNeeded(IAlpacaGovernance governance, uint256 blockNumber)
    external
    view
    returns (uint256);

  function isProposalPassed(IAlpacaGovernance governance, uint256 proposalId)
    external
    view
    returns (bool);
  function isQuorumValid(IAlpacaGovernance governance, uint256 proposalId)
    external
    view
    returns (bool);
  function isVoteDifferentialValid(IAlpacaGovernance governance, uint256 proposalId)
    external
    view
    returns (bool);

  function getMinimumVotingPowerNeeded(uint256 votingSupply) external view returns (uint256);

  function PROPOSITION_THRESHOLD() external view returns (uint256);

  function VOTING_DURATION() external view returns (uint256);

  function VOTE_DIFFERENTIAL() external view returns (uint256);
  function MINIMUM_QUORUM() external view returns (uint256);
  function ONE_HUNDRED_WITH_PRECISION() external view returns (uint256);
}