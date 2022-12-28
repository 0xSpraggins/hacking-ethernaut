/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import type { Provider, TransactionRequest } from "@ethersproject/providers";
import type { PromiseOrValue } from "../../common";
import type {
  HackCoinFlip,
  HackCoinFlipInterface,
} from "../../solutions/HackCoinFlip";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "coinFlipContractAddress",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "guaranteeGuess",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x60806040527f800000000000000000000000000000000000000000000000000000000000000060005534801561003457600080fd5b5060405161048538038061048583398181016040528101906100569190610100565b80600160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055505061012d565b600080fd5b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b60006100cd826100a2565b9050919050565b6100dd816100c2565b81146100e857600080fd5b50565b6000815190506100fa816100d4565b92915050565b6000602082840312156101165761011561009d565b5b6000610124848285016100eb565b91505092915050565b6103498061013c6000396000f3fe608060405234801561001057600080fd5b506004361061002b5760003560e01c8063f608542714610030575b600080fd5b61003861003a565b005b600060014361004991906101eb565b4060001c9050600080548261005e919061024e565b90506001810361010d57600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16631d263f6760016040518263ffffffff1660e01b81526004016100c4919061029a565b6020604051808303816000875af11580156100e3573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061010791906102e6565b506101ae565b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16631d263f6760006040518263ffffffff1660e01b8152600401610169919061029a565b6020604051808303816000875af1158015610188573d6000803e3d6000fd5b505050506040513d601f19601f820116820180604052508101906101ac91906102e6565b505b5050565b6000819050919050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601160045260246000fd5b60006101f6826101b2565b9150610201836101b2565b9250828203905081811115610219576102186101bc565b5b92915050565b7f4e487b7100000000000000000000000000000000000000000000000000000000600052601260045260246000fd5b6000610259826101b2565b9150610264836101b2565b9250826102745761027361021f565b5b828204905092915050565b60008115159050919050565b6102948161027f565b82525050565b60006020820190506102af600083018461028b565b92915050565b600080fd5b6102c38161027f565b81146102ce57600080fd5b50565b6000815190506102e0816102ba565b92915050565b6000602082840312156102fc576102fb6102b5565b5b600061030a848285016102d1565b9150509291505056fea264697066735822122023f940aa1a4d0547dcbe96a7dda2450233336106c2eb0ed33e554e38cf8c784664736f6c63430008110033";

type HackCoinFlipConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: HackCoinFlipConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class HackCoinFlip__factory extends ContractFactory {
  constructor(...args: HackCoinFlipConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override deploy(
    coinFlipContractAddress: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<HackCoinFlip> {
    return super.deploy(
      coinFlipContractAddress,
      overrides || {}
    ) as Promise<HackCoinFlip>;
  }
  override getDeployTransaction(
    coinFlipContractAddress: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(coinFlipContractAddress, overrides || {});
  }
  override attach(address: string): HackCoinFlip {
    return super.attach(address) as HackCoinFlip;
  }
  override connect(signer: Signer): HackCoinFlip__factory {
    return super.connect(signer) as HackCoinFlip__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): HackCoinFlipInterface {
    return new utils.Interface(_abi) as HackCoinFlipInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): HackCoinFlip {
    return new Contract(address, _abi, signerOrProvider) as HackCoinFlip;
  }
}
