import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Viacep(),
        
    );
  }
}

class Viacep extends StatefulWidget {
  const Viacep({super.key});

  @override
  State<Viacep> createState() => _ViacepState();
}

class _ViacepState extends State<Viacep> {
  TextEditingController cepController = TextEditingController();

  String cep = '';
  String result = '';

 void chamaCep(String cep) async {
    String cep = cepController.text;
    final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        result = "CEP: ${data['cep']}\n"
                 "Logradouro: ${data['logradouro']}\n"
                 "Bairro: ${data['bairro']}\n"
                 "Cidade: ${data['localidade']}\n"
                 "Estado: ${data['uf']}\n";
               
                 
      });
    } else {
      setState(() {
        result = "CEP não encontrado";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return  
    Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Retorna cep"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Text("Digite um cep:", style: TextStyle(fontSize: 25),),
              ),
               TextField(
                  controller: cepController,
                decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 50)),
              ),
        
              TextButton(
                  onPressed: () {
                setState(() {
                  cepController.clear(); 
                  result = '';
                });
              },
              child: const Text("Limpar campo"),
            ),
            ElevatedButton(
              
              onPressed: () {
                setState(() {
                  chamaCep(cep);
                });
      
                
              },
              child: const Text("Obter endereço"),
            ),

            const SizedBox(height: 25,),

            Text(result, style: const TextStyle(fontSize: 20, color: Colors.blue),),
                        
            ],
          ),
        ),
      ),
 );
 }
}

