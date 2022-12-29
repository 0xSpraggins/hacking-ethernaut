/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import type { Provider, TransactionRequest } from "@ethersproject/providers";
import type { PromiseOrValue } from "../../common";
import type { CoinFlip, CoinFlipInterface } from "../../ethernaut/CoinFlip";

const _abi = [
  {
    inputs: [],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "consecutiveWins",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bool",
        name: "_guess",
        type: "bool",
      },
    ],
    name: "flip",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x60806040527f800000000000000000000000000000000000000000000000000000000000000060025534801561003457600080fd5b506000808190555061032d8061004b6000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c80631d263f671461003b578063e6f334d71461006b575b600080fd5b61005560048036038101906100509190610161565b610089565b604051610062919061019d565b60405180910390f35b61007361011e565b60405161008091906101d1565b60405180910390f35b600080600143610099919061021b565b4060001c905080600154036100ad57600080fd5b806001819055506000600254826100c4919061027e565b90506000600182146100d75760006100da565b60015b90508415158115150361010a576000808154809291906100f9906102af565b919050555060019350505050610119565b60008081905550600093505050505b919050565b60005481565b600080fd5b60008115159050919050565b61013e81610129565b811461014957600080fd5b50565b60008135905061015b81610135565b92915050565b60006020828403121561017757610176610124565b5b60006101858482850161014c565b91505092915050565b61019781610129565b82525050565b60006020820190506101b2600083018461018e565b92915050565b6000819050919050565b6101cb816101b8565b82525050565b60006020820190506101e660008301846101c2565b92915050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b6000610226826101b8565b9150610231836101b8565b9250828203905081811115610249576102486101ec565b5b92915050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601260045260246000fd5b6000610289826101b8565b9150610294836101b8565b9250826102a4576102a361024f565b5b828204905092915050565b60006102ba826101b8565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff82036102ec576102eb6101ec565b5b60018201905091905056fea264697066735822122090b50b928ca90ad80f3300eefd364b7fcf1e5ac9d6b22668227a5a7e7565598364736f6c63430008110033";

type CoinFlipConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: CoinFlipConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class CoinFlip__factory extends ContractFactory {
  constructor(...args: CoinFlipConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override deploy(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<CoinFlip> {
    return super.deploy(overrides || {}) as Promise<CoinFlip>;
  }
  override getDeployTransaction(
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(overrides || {});
  }
  override attach(address: string): CoinFlip {
    return super.attach(address) as CoinFlip;
  }
  override connect(signer: Signer): CoinFlip__factory {
    return super.connect(signer) as CoinFlip__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): CoinFlipInterface {
    return new utils.Interface(_abi) as CoinFlipInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): CoinFlip {
    return new Contract(address, _abi, signerOrProvider) as CoinFlip;
  }
}
