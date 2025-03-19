import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      "Cargando Películas",
      "Comprando Canguil",
      "Cargando Populares",
      "Maquillando Actores",
      "Burlandonos de Marvel",
      "Te quiero Flow",
      "Limpiando las Salas",
      "Sirviendo la Soda",
      "Comprando Boletos",
      "Viendo Johan Sacreblu",
      "Esto está tardando un poco"
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Wait"),
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text("Cargando...");
              }
              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
