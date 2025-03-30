import { ethers } from "ethers";
import ScrollXRegistry from "./artifacts/contracts/ScrollXRegistry.sol/ScrollXRegistry.json";

const SCROLLX_REGISTRY_ADDRESS = "0xYourRegistryContractAddress"; // Ganti dengan alamat yang sesuai

export class RollupDeployer {
    constructor(provider, signer) {
        this.provider = provider;
        this.signer = signer;
        this.registry = new ethers.Contract(SCROLLX_REGISTRY_ADDRESS, ScrollXRegistry.abi, this.signer);
    }

    async registerRollup(rollupAddress, rollupType) {
        try {
            const tx = await this.registry.registerRollup(rollupAddress, rollupType);
            await tx.wait();
            console.log(`Rollup ${rollupAddress} registered as ${rollupType}`);
        } catch (error) {
            console.error("Registration failed:", error);
        }
    }

    async deactivateRollup(rollupAddress) {
        try {
            const tx = await this.registry.deactivateRollup(rollupAddress);
            await tx.wait();
            console.log(`Rollup ${rollupAddress} deactivated.`);
        } catch (error) {
            console.error("Deactivation failed:", error);
        }
    }
}
