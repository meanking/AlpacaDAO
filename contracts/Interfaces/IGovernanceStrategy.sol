// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.17;
pragma abicoder v2;

interface IGovernanceStrategy {
  function getPropositionPowerAt(address user, uint256 blockNumber) external view returns (uint256);

  function getTotalPropositionSupplyAt(uint256 blockNumber) external view returns (uint256);

  function getTotalVotingSupplyAt(uint256 blockNumber) external view returns (uint256);

  function getVotingPowerAt(address user, uint256 blockNumber) external view returns (uint256);
}