# Building a Medical App using Flutter, Web3dart, Solidity, Truffle and Ganache

## Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Ganache](https://truffleframework.com/ganache)
- [Truffle](https://truffleframework.com/truffle)
- A text editor for writing Solidity contracts

## Step 1: Setting up the environment
1. Create a new Flutter project by running the following command in the terminal:
### flutter create <project_name>

2. Start Ganache to create a local blockchain network by running the following command in the terminal:
### ganache-cli

3. In a separate terminal window, navigate to the project directory and compile and deploy the Solidity contract using Truffle by running the following commands:
a. truffle init
b. truffle compile
c. truffle migrate


## Step 2: Integrating Web3dart
1. In the terminal, navigate to the project directory and add the web3dart package to the pubspec.yaml file:
 . web3dart: ^0.3.1

2. Run the following command to install the dependencies:
 . flutter pub get

3. In the Dart code, connect to the Ethereum blockchain by providing the endpoint of the local blockchain network created in step 1:
```dart
import 'package:web3dart/web3dart.dart';

final client = Web3Client(
  'http://localhost:7545',
  http.Client(),
);

## Step 3: Implementing the app functionality
1. Use the web3dart package to interact with the deployed contract on the Ethereum blockchain. For example, to call a function in the contract, you can use the client.call method:

final response = await client.call(
  contract: ContractAbi(...),
  function: FunctionAbi(...),
  params: [...],
);

2. Implement the user interface using Flutter widgets. For example, to display a list of medical records, you can use a ListView widget:
 ListView.builder(
  itemCount: records.length,
  itemBuilder: (context, index) {
    return Text(records[index]);
  },
);

3. Manage the state using Flutter provider pattern. For example, to store the medical records in the state, you can use a ChangeNotifier class:

class MedicalRecordModel with ChangeNotifier {
  List<String> records = [];

  void addRecord(String record) {
    records.add(record);
    notifyListeners();
  }
}

## Step 4: Testing and deploying
1. Test the app using Flutter built-in testing framework. For example, to test the MedicalRecordModel class, you can write a unit test:
    void main() {
  test('adding a medical record', 
  ...







# MedRec
