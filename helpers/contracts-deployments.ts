import {tEthereumAddress, eContractid} from './types';
import {getAlpacaMocked, getFirstSigner} from './contracts-getters';
import {
  AlpacaGovernance__factory,
  Executor__factory,
  GovernanceStrategy__factory,
} from '../typechain-types/factories/contracts/governance';
import {
  AlpacaTokenMock__factory,
  AlpacaToken__factory,
} from '../typechain-types/factories/contracts/mocks';
import {
  InitializableAdminUpgradeabilityProxy__factory,
} from '../typechain-types/factories/contracts/dependencies/open-zeppelin';
import {withSaveAndVerify} from './contracts-helpers';
import {waitForTx} from './misc-utils';
import {Interface} from 'ethers/lib/utils';
import { ethers } from 'hardhat';
import { PromiseOrValue } from '../typechain-types/common';
import { BigNumberish } from 'ethers';

export const deployAaveGovernanceV2 = async (
  governanceStrategy: tEthereumAddress,
  votingDelay: string,
  guardian: tEthereumAddress,
  executors: tEthereumAddress[],
  verify?: boolean
) => {
  const args: [tEthereumAddress, string, string, tEthereumAddress[]] = [
    governanceStrategy,
    votingDelay,
    guardian,
    executors,
  ];
  return withSaveAndVerify(
    await new AlpacaGovernance__factory(await getFirstSigner()).deploy(...args),
    eContractid.AlpacaGovernance,
    args,
    verify
  );
};

export const deployGovernanceStrategy = async (
  propositionToken: tEthereumAddress,
  votingToken: tEthereumAddress,
  propositionThreshold: string,
  verify?: boolean
) => {
  const args: [tEthereumAddress, tEthereumAddress, string] = [
    propositionToken,
    votingToken,
    propositionThreshold,
  ];
  return withSaveAndVerify(
    await new GovernanceStrategy__factory(await getFirstSigner()).deploy(...args),
    eContractid.GovernanceStrategy,
    args,
    verify
  );
};

export const deployExecutor = async (admin: tEthereumAddress, delay: string, verify?: boolean) => {
  const args: [tEthereumAddress, string] = [admin, delay];
  return withSaveAndVerify(
    await new Executor__factory(await getFirstSigner()).deploy(...args),
    eContractid.Executor,
    args,
    verify
  );
};

export const deployProxy = async (customId: string, verify?: boolean) =>
  await withSaveAndVerify(
    await new InitializableAdminUpgradeabilityProxy__factory(await getFirstSigner()).deploy(),
    eContractid.InitializableAdminUpgradeabilityProxy,
    [],
    verify,
    customId
  );

export const deployMockedAaveV2 = async (minter: tEthereumAddress, verify?: boolean) => {
  const provider = new ethers.providers.JsonRpcProvider(process.env.JSON_RPC_TEST_URL);
  let startReleaseBlock: PromiseOrValue<BigNumberish> = 0, endReleaseBlock: PromiseOrValue<BigNumberish> = 0;

  provider.getBlockNumber()
    .then(blockNumber => {
      startReleaseBlock = blockNumber;
      endReleaseBlock = blockNumber + 200000;
    })

  const proxy = await deployProxy(eContractid.AlpacaTokenMock);

  // const implementationV1 = await withSaveAndVerify(
  //   await new AlpacaTokenMock__factory().deploy(),
  //   eContractid.AlpacaTokenMock,
  //   [],
  //   verify,
  //   eContractid.AlpacaTokenMockImpl
  // );
  const implementationV2 = await withSaveAndVerify(
    await new AlpacaToken__factory(await getFirstSigner()).deploy(startReleaseBlock, endReleaseBlock),
    eContractid.AlpacaToken,
    [],
    verify,
    eContractid.AlpacaTokenMockImpl
  );
  const encodedPayload = new Interface([
    'function initialize(address minter)',
  ]).encodeFunctionData('initialize', [minter]);
  // await waitForTx(
  //   await proxy.functions['initialize(address,address,bytes)'](
  //     implementationV1.address,
  //     minter,
  //     encodedPayload
  //   )
  // );
  const encodedPayloadV2 = implementationV2.interface.encodeFunctionData('unlockedSupply');
  await waitForTx(await proxy.upgradeToAndCall(implementationV2.address, encodedPayloadV2));
  return await getAlpacaMocked(proxy.address);
};