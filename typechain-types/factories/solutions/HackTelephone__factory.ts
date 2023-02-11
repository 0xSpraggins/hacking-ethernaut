/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import { Signer, utils, Contract, ContractFactory, Overrides } from "ethers";
import type { Provider, TransactionRequest } from "@ethersproject/providers";
import type { PromiseOrValue } from "../../common";
import type {
  HackTelephone,
  HackTelephoneInterface,
} from "../../solutions/HackTelephone";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "telephoneContract",
        type: "address",
      },
      {
        internalType: "address",
        name: "desiredOwner",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "_desiredOwner",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "attack",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "owner",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
] as const;

const _bytecode =
  "0x608060405234801561001057600080fd5b506040516103863803806103868339818101604052810190610032919061011e565b81600160006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff16021790555080600260006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550505061015e565b600080fd5b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b60006100eb826100c0565b9050919050565b6100fb816100e0565b811461010657600080fd5b50565b600081519050610118816100f2565b92915050565b60008060408385031215610135576101346100bb565b5b600061014385828601610109565b925050602061015485828601610109565b9150509250929050565b6102198061016d6000396000f3fe608060405234801561001057600080fd5b50600436106100415760003560e01c80638da5cb5b146100465780638f698e29146100645780639e5faafc14610082575b600080fd5b61004e61008c565b60405161005b91906101c8565b60405180910390f35b61006c6100b0565b60405161007991906101c8565b60405180910390f35b61008a6100d6565b005b60008054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1681565b600160009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1663a6f9dae1600260009054906101000a900473ffffffffffffffffffffffffffffffffffffffff166040518263ffffffff1660e01b815260040161015391906101c8565b600060405180830381600087803b15801561016d57600080fd5b505af1158015610181573d6000803e3d6000fd5b50505050565b600073ffffffffffffffffffffffffffffffffffffffff82169050919050565b60006101b282610187565b9050919050565b6101c2816101a7565b82525050565b60006020820190506101dd60008301846101b9565b9291505056fea2646970667358221220695bf9f916152cf5054f10a80116e802a3218021d95f45d2c506d374cff4136d64736f6c63430008110033";

type HackTelephoneConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: HackTelephoneConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class HackTelephone__factory extends ContractFactory {
  constructor(...args: HackTelephoneConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override deploy(
    telephoneContract: PromiseOrValue<string>,
    desiredOwner: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): Promise<HackTelephone> {
    return super.deploy(
      telephoneContract,
      desiredOwner,
      overrides || {}
    ) as Promise<HackTelephone>;
  }
  override getDeployTransaction(
    telephoneContract: PromiseOrValue<string>,
    desiredOwner: PromiseOrValue<string>,
    overrides?: Overrides & { from?: PromiseOrValue<string> }
  ): TransactionRequest {
    return super.getDeployTransaction(
      telephoneContract,
      desiredOwner,
      overrides || {}
    );
  }
  override attach(address: string): HackTelephone {
    return super.attach(address) as HackTelephone;
  }
  override connect(signer: Signer): HackTelephone__factory {
    return super.connect(signer) as HackTelephone__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): HackTelephoneInterface {
    return new utils.Interface(_abi) as HackTelephoneInterface;
  }
  static connect(
    address: string,
    signerOrProvider: Signer | Provider
  ): HackTelephone {
    return new Contract(address, _abi, signerOrProvider) as HackTelephone;
  }
}