import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const FinanceiroApp());
}

class FinanceiroApp extends StatelessWidget {
  const FinanceiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Minhas Finanças',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const Financeiro(),
    );
  }
}

class Financeiro extends StatefulWidget {
  const Financeiro({super.key});

  @override
  State<Financeiro> createState() => _FinanceiroState();
}

class _FinanceiroState extends State<Financeiro> {
  final descricao = TextEditingController();
  final valor = TextEditingController();

  List<Map<String, dynamic>> despesas = [];

  @override
  void initState() {
    super.initState();
    carregarDespesas();
  }

  // Carrega as despesas salvas no aparelho
  Future<void> carregarDespesas() async {
    final prefs = await SharedPreferences.getInstance();

    final dados = prefs.getString('despesas');

    if (dados != null) {
      setState(() {
        despesas = List<Map<String, dynamic>>.from(
          jsonDecode(dados).map((item) => Map<String, dynamic>.from(item)),
        );
      });
    }
  }

  // Salva as despesas no aparelho
  Future<void> salvarDespesas() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'despesas',
      jsonEncode(despesas),
    );
  }

  // Adiciona uma nova despesa
  Future<void> adicionarDespesa() async {
    if (descricao.text.isEmpty || valor.text.isEmpty) {
      return;
    }

    final valorDigitado = double.tryParse(
      valor.text.replaceAll(',', '.'),
    );

    if (valorDigitado == null) {
      return;
    }

    setState(() {
      despesas.add({
        'descricao': descricao.text,
        'valor': valorDigitado,
        'data': DateTime.now().toString().substring(0, 10),
      });
    });

    await salvarDespesas();

    descricao.clear();
    valor.clear();
  }

  // Exclui uma despesa
  Future<void> excluirDespesa(int index) async {
    setState(() {
      despesas.removeAt(index);
    });

    await salvarDespesas();
  }

  // Calcula o total
  double total() {
    return despesas.fold(
      0,
      (soma, item) => soma + item['valor'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Finanças'),
        centerTitle: true,
      ),

      body: Column(
        children: [

          // Área para lançar despesa
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                TextField(
                  controller: descricao,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Ex.: Mercado',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.description),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: valor,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Valor',
                    hintText: 'Ex.: 50,00',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: adicionarDespesa,
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar despesa'),
                  ),
                ),
              ],
            ),
          ),

          // Total
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.green.shade50,
            child: Text(
              'Total: R\$ ${total().toStringAsFixed(2).replaceAll('.', ',')}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Lista de despesas
          Expanded(
            child: despesas.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhuma despesa cadastrada',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: despesas.length,
                    itemBuilder: (context, index) {
                      final despesa = despesas[index];

                      return Dismissible(
                        key: Key(index.toString()),
                        direction: DismissDirection.endToStart,

                        onDismissed: (_) {
                          excluirDespesa(index);
                        },

                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),

                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.shopping_cart),
                          ),

                          title: Text(
                            despesa['descricao'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          subtitle: Text(
                            'Data: ${despesa['data']}',
                          ),

                          trailing: Text(
                            'R\$ ${despesa['valor'].toStringAsFixed(2).replaceAll('.', ',')}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    descricao.dispose();
    valor.dispose();
    super.dispose();
  }
}