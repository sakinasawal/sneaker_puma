import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/contract_viewmodel.dart';

class ContractPage extends StatefulWidget {
  const ContractPage({super.key});

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<ContractViewModel>(context, listen: false).getContracts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contracts")),
      body: Consumer<ContractViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.error != null) {
            return Center(child: Text(vm.error!));
          }

          return ListView.builder(
            itemCount: vm.contracts.length,
            itemBuilder: (context, index) {
              final contract = vm.contracts[index];

              return ListTile(
                title: Text(contract.referenceNumber ?? "No ref"),
                subtitle: Text(contract.status),
              );
            },
          );
        },
      ),
    );
  }
}
