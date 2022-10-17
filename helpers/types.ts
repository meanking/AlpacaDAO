export enum eEthereumNetwork {
  buidlerevm = 'buidlerevm',
  kovan = 'kovan',
  ropsten = 'ropsten',
  main = 'main',
  coverage = 'coverage',
  hardhat = 'hardhat',
}

export enum EthereumNetworkNames {
  kovan = 'kovan',
  ropsten = 'ropsten',
  main = 'main',
}

export enum AlpacaPools {
  proto = 'proto',
  secondary = 'secondary',
}

export enum eContractid {
  AlpacaGovernance = 'AlpacaGovernance',
  GovernanceStrategy = 'GovernanceStrategy',
  Executor = 'Executor',
  InitializableAdminUpgradeabilityProxy = 'InitializableAdminUpgradeabilityProxy',
  AlpacaTokenMock = 'AlpacaTokenMock',
  AlpacaTokenMockImpl = 'AlpacaTokenMockImpl',
  AlpacaToken = 'AlpacaToken',
}

export type tEthereumAddress = string;