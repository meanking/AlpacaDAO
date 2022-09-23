// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.17;
pragma experimental ABIEncoderV2;

interface IPropositionStrategy {
  // In per thousand of the total proposition power
  function getPropositionPower(address user) external view returns (uint256);
}