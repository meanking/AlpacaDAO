// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.17;
pragma abicoder v2;

interface IDelegationAwareToken {
  enum DelegationType {VOTING_POWER, PROPOSITION_POWER}

  function getPowerAtBlock(
    address user,
    uint256 blockNumber,
    DelegationType delegationType
  ) external view returns (uint256);
}