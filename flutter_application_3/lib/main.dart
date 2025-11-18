import 'package:flutter/material.dart';
import 'package:flutter_application_3/Worker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Gestión de Trabajadores'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Worker> trabajadores = [];

  final TextEditingController _idCtrl = TextEditingController();
  final TextEditingController _nombreCtrl = TextEditingController();
  final TextEditingController _apellidosCtrl = TextEditingController();
  final TextEditingController _edadCtrl = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _addWorker() {
    final id = _idCtrl.text.trim();
    final nombre = _nombreCtrl.text.trim();
    final apellidos = _apellidosCtrl.text.trim();
    final edadText = _edadCtrl.text.trim();

    if (id.isEmpty || nombre.isEmpty || apellidos.isEmpty || edadText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Todos los campos son obligatorios")),
      );
      return;
    }

    if (trabajadores.any((w) => w.id == id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("El ID ya está registrado")),
      );
      return;
    }

    final edad = int.tryParse(edadText);
    if (edad == null || edad < 18) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Solo se permiten mayores de edad")),
      );
      return;
    }

    setState(() {
      trabajadores.add(Worker(id, nombre, apellidos, edad));
    });

    _idCtrl.clear();
    _nombreCtrl.clear();
    _apellidosCtrl.clear();
    _edadCtrl.clear();
  }

  void _removeWorker() {
    if (trabajadores.isNotEmpty) {
      setState(() {
        trabajadores.removeLast();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No hay trabajadores para eliminar")),
      );
    }
  }

  Widget getWorkers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        const Text("Lista de Trabajadores:"),
        const SizedBox(height: 10),
        ...trabajadores.map(
          (w) =>
              Text("- ${w.id} | ${w.nombre} ${w.apellidos} | Edad: ${w.edad}"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
              const Divider(thickness: 2),
              const SizedBox(height: 10),
              const Text("Gestión de Trabajadores",
                  style: TextStyle(fontWeight: FontWeight.bold)),

              // Campos para Worker
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _idCtrl,
                  decoration: const InputDecoration(
                    labelText: 'ID',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _nombreCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _apellidosCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Apellidos',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _edadCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Edad',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // Botones para Worker
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _addWorker,
                    child: const Text("Agregar Trabajador"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _removeWorker,
                    child: const Text("Eliminar Último"),
                  ),
                ],
              ),

              // Lista de trabajadores
              getWorkers(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
