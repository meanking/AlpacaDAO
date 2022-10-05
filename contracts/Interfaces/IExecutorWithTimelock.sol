// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.17;
pragma experimental ABIEncoderV2;

import {IAlpacaGovernance} from './IAlpacaGovernance.sol';

interface IExecutorWithTimelock {
  // function getQuorum() external view returns (uint256);

  // function getForVotesNeededForQuorum() external view returns (uint256);

  // function getVotesDifferential() external view returns (uint256);

  // function getForVotesNeededWithDifferential(uint256 against) external view returns (uint256);

  function getAdmin() external view returns (address);

  function getPendingAdmin() external view returns (address);

  function getDelay() external view returns (uint256);

  function isActionQueued(bytes32 actionHash) external view returns (bool);

  function isProposalOverGracePeriod(IAlpacaGovernance governance, uint256 proposalId)
    external
    view
    returns (bool);

  function GRACE_PERIOD() external view returns (uint256);

  function MINIMUM_DELAY() external view returns (uint256);

  function MAXIMUM_DELAY() external view returns (uint256);


  function queueTransaction(
    address target,
    uint256 value,
    string memory signature,
    bytes memory data,
    uint256 executionTime,
    bool withDelegatecall
  ) external returns (bytes32);

  function executeTransaction(
    address target,
    uint256 value,
    string memory signature,
    bytes memory data,
    uint256 executionTime,
    bool withDelegatecall
  ) external payable returns (bytes memory);

  function cancelTransaction(
    address target,
    uint256 value,
    string memory signature,
    bytes memory data,
    uint256 executionTime,
    bool withDelegatecall
  ) external;
}