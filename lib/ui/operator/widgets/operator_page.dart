import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/operator_viewmodel.dart';

class OperatorPage extends StatefulWidget {
  const OperatorPage({super.key});

  @override
  State<OperatorPage> createState() => _OperatorPageState();
}

class _OperatorPageState extends State<OperatorPage>{

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OperatorViewmodel>().getOperators();
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Operators")),
        body: Consumer<OperatorViewmodel>(
            builder: (context, vm, child){

              if (vm.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (vm.error != null) {
                return Center(
                  child: Text(
                    vm.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (vm.operators.isEmpty) {
                return const Center(
                  child: Text("No operators found"),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: vm.operators.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index){
                    final operator = vm.operators[index];
                    return Card(
                        elevation: 2,
                        child: ListTile(
                          leading: const Icon(Icons.business),
                          title: Text(operator.name),
                          subtitle: Text("ID: ${operator.id}"),
                        )
                    );
                  }
              );
            }
        )
    );
  }
}