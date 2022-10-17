import {
  AlpacaGovernance__factory,
  Executor__factory,
  GovernanceStrategy__factory,
} from '../typechain-types/factories/contracts/governance';
import {
  AlpacaToken__factory,
} from '../typechain-types/factories/contracts/mocks';
import {DRE, getDb} from './misc-utils';
import {eContractid, tEthereumAddress} from './types';

export const getFirstSigner = async () => (await DRE.ethers.getSigners())[0];
export const getAlpacaGovernance = async (address?: tEthereumAddress) =>
  await AlpacaGovernance__factory.connect(
    address ||
      (await getDb().get(`${eContractid.AlpacaGovernance}.${DRE.network.name}`).value()).address,
    await getFirstSigner()
  );

export const getAlpacaMocked = async (address?: tEthereumAddress) =>
  await AlpacaGovernance__factory.connect(
    address ||
      (await getDb().get(`${eContractid.AlpacaTokenMock}.${DRE.network.name}`).value()).address,
    await getFirstSigner()
  );

export const getGovernanceStrategy = async (address?: tEthereumAddress) =>
  await GovernanceStrategy__factory.connect(
    address ||
      (await getDb().get(`${eContractid.GovernanceStrategy}.${DRE.network.name}`).value()).address,
    await getFirstSigner()
  );

export const getExecutor = async (address?: tEthereumAddress) =>
  await Executor__factory.connect(
    address || (await getDb().get(`${eContractid.Executor}.${DRE.network.name}`).value()).address,
    await getFirstSigner()
  );