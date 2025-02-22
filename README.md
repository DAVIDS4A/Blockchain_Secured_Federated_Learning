# Federated Learning with Blockchain-Based Incentives

This project integrats **horizontal federated learning** with **blockchain smart contracts** to create a transparent, incentive-driven training environment. In this project, multiple clients collaboratively train a global model while keeping their data local, and a smart contract automatically validates contributions and distributes rewards based on performance.

---

## Overview

This repository contains:

- **Jupyter Notebook:**  
  A complete Python notebook that implements horizontal federated learning using PyTorch. The notebook divides data among clients, trains local models, aggregates them using federated averaging, and evaluates the global model.

- **Smart Contract (.sol):**  
  An advanced Solidity smart contract that manages:
  - **Consent Management:** Ensures each client grants consent before participation.
  - **Update Submission:** Allows clients to submit model performance scores.
  - **Reward Distribution:** Automatically calculates and distributes rewards proportionally based on each client’s contribution.
  - **Reward Claiming:** Enables clients to claim their allocated rewards.

- **Blockchain Integration:**  
  The project uses [Web3.py](https://github.com/ethereum/web3.py) to interact with a Ganache Ethereum blockchain environment, enabling smooth communication between the Python federated learning code and the smart contract.

---

## Features

- **Privacy-Preserving Federated Learning:**  
  Clients train on disjoint subsets of data without sharing raw data, improving privacy while still contributing to a robust global model.

- **Blockchain-Enabled Incentives:**  
  Smart contracts automatically manage consent, validate model updates, and distribute rewards—ensuring transparency and fairness in contributions.

- **Seamless Integration:**  
  The system combines Python’s deep learning libraries with Solidity smart contracts using Web3.py, providing a unique end-to-end solution for decentralized machine learning.

- **Real-Time Logging:**  
  Transaction hashes, performance scores, and reward allocations are logged and can be monitored via Ganache, enhancing auditability.

---

## Getting Started

### Prerequisites

- **Python 3.8+** with necessary packages:
  - PyTorch
  - Torchvision
  - Web3.py
  - Matplotlib
  - Numpy

- **Node.js and npm** (if you plan to deploy Ganache CLI).

- **Ganache:**  
  Either the [Ganache CLI](https://www.trufflesuite.com/ganache) or the [Ganache GUI](https://www.trufflesuite.com/ganache).  
  *Note:* Make sure to set the correct RPC port and network ID (e.g., port 7545 or 5777) in both Ganache and your notebook.

### Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/DAVIDS4A/Blockchain_Secured_Federated_Learning.git
   Blockchain_Secured_Federated_Learning
   ```

2. **Set Up Your Python Environment:**

   Create and activate a virtual environment, then install required packages:

   ```bash
   pip install -r requirements.txt
   ```

   *Alternatively, use your preferred package manager.*

3. **Deploy the Smart Contract:**

   - Open the Solidity file (`FederatedLearningRewards.sol`) in Remix or your preferred Solidity IDE.
   - Compile and deploy it to your local Ganache network.
   - Update the notebook with the deployed contract address and ABI.

4. **Configure Ganache Connection:**

   Ensure your notebook connects to Ganache using the correct RPC URL (e.g., `http://127.0.0.1:7545` or as configured). Adjust the code if needed.

---

## Running the Project

1. **Start Ganache:**  
   Run Ganache locally, ensuring it uses the appropriate port and network ID.

2. **Open the Notebook:**  
   Launch Jupyter Notebook and open the provided notebook. Follow the steps:
   - Initialize the Web3 connection.
   - Deploy and interact with the smart contract.
   - Run the federated training loop.
   - Evaluate the global model.
   - Distribute and claim rewards.

3. **Monitor Transactions:**  
   Ganache logs will show all blockchain transactions (consent submissions, update scores, reward deposits, distributions, and claims).  
   You can add screenshots from Ganache for a visual representation:

   ![Ganache Screenshot](path_to_your_screenshot.png)

---

## Results & Analysis

- **Model Performance:**  
  The global model achieved a validation accuracy of approximately **56.25%**. Experiment with different hyperparameters and architectures to improve performance.

- **Blockchain Activity:**  
  All key transactions (e.g., client consent, update submissions, reward distributions, reward claims) are logged with transaction hashes, ensuring full auditability of the reward mechanism.

- **Reward Mechanism:**  
  Each client’s reward is computed based on the performance score of their updates. The smart contract enforces rules to prevent duplicate consents and ensures that rewards are fairly allocated.

---

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests with improvements, bug fixes, or new features.

---

## License

This project is licensed under the [MIT License](LICENSE).
