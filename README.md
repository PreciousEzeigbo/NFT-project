# Foundry NFT Project

An NFT project built with Foundry that includes two different types of NFTs: a Basic NFT and a Dynamic Mood NFT with on-chain SVG generation.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Contracts](#contracts)
- [Usage](#usage)
- [Testing](#testing)
- [Deployment](#deployment)
- [Configuration](#configuration)git commit -m "feat: Implement dual NFT contracts with on-chain metadata and Base64 encoding

- BasicNft: Simple ERC721 with external URIs
- MoodNft: Dynamic SVG generation with mood states
- Full test coverage and deployment automation"

## 🎯 Overview

This project demonstrates two different approaches to NFT implementation:

1. **BasicNft**: A simple ERC721 token that accepts external metadata URIs
2. **MoodNft**: A dynamic NFT with on-chain SVG generation that can change between happy and sad states

## ✨ Features

- **BasicNft Contract**: Simple NFT minting with external metadata
- **MoodNft Contract**: Dynamic NFT with mood switching functionality
- **On-chain SVG Generation**: SVGs stored and generated entirely on-chain
- **Base64 Encoding**: Metadata encoded directly in the token URI
- **Foundry Testing Suite**: Comprehensive unit and integration tests
- **Deployment Scripts**: Automated deployment to local and testnet environments
- **Makefile Commands**: Simplified build, test, and deployment commands

## 🛠 Prerequisites

Before you begin, ensure you have the following installed:

- [Git](https://git-scm.com/)
- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- [Node.js](https://nodejs.org/) (optional, for additional tooling)

## 📥 Installation

1. **Clone the repository**

   ```bash
   git clone <your-repo-url>
   cd foundry-nft
   ```

2. **Install dependencies**

   ```bash
   make install
   ```

3. **Build the project**

   ```bash
   make build
   ```

4. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your actual values
   ```

## 📂 Project Structure

```
foundry-nft/
├── src/
│   ├── BasicNft.sol           # Simple NFT contract
│   └── MoodNft.sol           # Dynamic mood NFT contract
├── script/
│   ├── DeployBasicNft.s.sol  # BasicNft deployment script
│   ├── DeployMoodNft.s.sol   # MoodNft deployment script
│   └── Interactions.s.sol    # Interaction scripts for minting
├── test/
│   ├── unit/
│   │   ├── BasicNftTest.t.sol
│   │   └── DeployMoodTest.t.sol
│   └── integrations/
│       └── MoodNftIntegrations.t.sol
├── img/
│   ├── happy.svg             # Happy mood SVG
│   └── sad.svg               # Sad mood SVG
├── Makefile                  # Build and deployment commands
├── foundry.toml             # Foundry configuration
└── README.md
```

## 📜 Contracts

### BasicNft

A simple ERC721 implementation that allows minting NFTs with external metadata URIs.

**Key Features:**

- Standard ERC721 functionality
- Custom token URI mapping
- Simple minting function

**Functions:**

- `mintNft(string memory tokenUri)`: Mint an NFT with specified metadata URI
- `tokenURI(uint256 tokenId)`: Get the metadata URI for a token

### MoodNft

A dynamic NFT that changes its appearance based on mood state, with all metadata stored on-chain.

**Key Features:**

- Dynamic mood switching (Happy ↔ Sad)
- On-chain SVG generation
- Base64 encoded metadata
- Fully decentralized (no external dependencies)

**Functions:**

- `mintNft()`: Mint a new MoodNft (starts as Happy)
- `flipMood(uint256 tokenId)`: Toggle between Happy and Sad states
- `tokenURI(uint256 tokenId)`: Get the complete JSON metadata (Base64 encoded)

**Moods:**

- **HAPPY**: Yellow smiley face with upward curve
- **SAD**: Blue sad face with downward curve

## 🚀 Usage

### Local Development

1. **Start local blockchain**

   ```bash
   make anvil
   ```

2. **Deploy contracts locally**

   ```bash
   # Deploy BasicNft
   make deploy

   # Deploy MoodNft (if you have a deploy-mood target)
   forge script script/DeployMoodNft.s.sol:DeployMoodNft --rpc-url http://localhost:8545 --private-key $DEFAULT_ANVIL_KEY --broadcast
   ```

3. **Mint NFTs**
   ```bash
   # Mint BasicNft
   make mint
   ```

### Testnet Deployment

1. **Deploy to Sepolia**

   ```bash
   make deploy ARGS="--network sepolia"
   ```

2. **Mint on Sepolia**
   ```bash
   make mint ARGS="--network sepolia"
   ```

## 🧪 Testing

The project includes comprehensive testing suites:

### Run All Tests

```bash
make test
```

### Run Specific Test Files

```bash
# Unit tests
forge test --match-path test/unit/BasicNftTest.t.sol
forge test --match-path test/unit/DeployMoodTest.t.sol

# Integration tests
forge test --match-path test/integrations/MoodNftIntegrations.t.sol
```

### Test with Verbose Output

```bash
forge test -vvv
```

### Generate Coverage Report

```bash
forge coverage
```

## 🚀 Deployment

### Environment Setup

Create a `.env` file with the following variables:

```bash
PRIVATE_KEY=0x...                                    # Your private key
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/... # Alchemy/Infura RPC URL
ETHERSCAN_API_KEY=...                               # For contract verification
```

PUTTING YOUR PRIVATE KEY IN A .ENV FILE IS NOT ADVISABLE IF YOU STILL WISH TO GO AHEAD DO NOT USE AN ACCOUNT WITH REAL FUNDS

### Available Make Commands

```bash
# Build and test
make build          # Compile contracts
make test           # Run all tests
make coverage       # Generate coverage report

# Local development
make anvil          # Start local blockchain
make deploy         # Deploy to local network
make mint           # Mint BasicNft locally

# Testnet operations
make deploy ARGS="--network sepolia"  # Deploy to Sepolia
make mint ARGS="--network sepolia"    # Mint on Sepolia

# Utilities
make format         # Format code
make clean          # Clean build artifacts
make install        # Install dependencies
```

## ⚙️ Configuration

### Foundry Configuration

The `foundry.toml` file includes:

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
remappings = ["@openzeppelin/contracts=lib/openzeppelin-contracts/contracts"]
ffi = true
fs_permissions = [
    { access = "read", path = "./broadcast" },
    { access = "read", path = "./img" }
]
```

### Network Configuration

Networks are configured in the Makefile with conditional logic for different environments.

## 🔍 Key Features Explained

### On-Chain SVG Generation

The MoodNft contract stores SVG data directly on-chain and generates metadata dynamically:

1. SVG files are read during deployment
2. Converted to Base64 format
3. Stored as data URIs in the contract
4. Metadata generated on-demand with proper JSON structure

### Dynamic Metadata

Token metadata is generated dynamically based on the current mood:

```json
{
  "name": "Mood NFT",
  "description": "An NFT that reflects your mood!",
  "attributes": [{ "trait_type": "Mood", "value": 100 }],
  "image": "data:image/svg+xml;base64,..."
}
```

### Security Features

- **Access Control**: Only token owners or approved addresses can flip mood
- **Custom Errors**: Gas-efficient error handling
- **Reentrancy Protection**: Inherited from OpenZeppelin contracts

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Solidity style guide
- Add tests for new features
- Update documentation as needed
- Use conventional commit messages

## 🙏 Acknowledgments

- [OpenZeppelin](https://openzeppelin.com/) for secure smart contract libraries
- [Foundry](https://github.com/foundry-rs/foundry) for the excellent development framework

---

**Happy Building! 🎉**

## 🎨 SVG Examples

For reference, here are the Base64 encoded SVGs used in the project:

### Sad SVG

```
data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgcj0iODAiIGZpbGw9IiM4N0NFRUIiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iNCIgLz4KCiAgICA8Y2lyY2xlIGN4PSI3MCIgY3k9IjgwIiByPSIxMCIgZmlsbD0iYmxhY2siIC8+CgogICAgPGNpcmNsZSBjeD0iMTMwIiBjeT0iODAiIHI9IjEwIiBmaWxsPSJibGFjayIgLz4KCiAgICA8cGF0aCBkPSJNIDYwIDE0MCBRIDEwMCAxMDAgMTQwIDE0MCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSI0IiBmaWxsPSJub25lIiAvPgo8L3N2Zz4=
```

### Happy SVG

```
data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICAgIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgcj0iODAiIGZpbGw9IiNGRkQ3MDAiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iNCIgLz4KCiAgICA8Y2lyY2xlIGN4PSI3MCIgY3k9IjgwIiByPSIxMCIgZmlsbD0iYmxhY2siIC8+CgogICAgPGNpcmNsZSBjeD0iMTMwIiBjeT0iODAiIHI9IjEwIiBmaWxsPSJibGFjayIgLz4KCiAgICA8cGF0aCBkPSJNIDYwIDEyMCBRIDEwMCAxNjAgMTQwIDEyMCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSI0IiBmaWxsPSJub25lIiAvPgo8L3N2Zz4=
```
