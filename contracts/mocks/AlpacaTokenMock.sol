// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;
import {AlpacaToken} from './AlpacaToken.sol';

abstract contract AlpacaTokenMock is AlpacaToken {
  /**
   * @dev initializes the contract upon assignment to the InitializableAdminUpgradeabilityProxy
   * @param minter the address of the LEND -> AAVE migration contract
   */
  function initialize() external {
    uint256 chainId;

    //solium-disable-next-line
    assembly {
      chainId := chainid()
    }
  }
}