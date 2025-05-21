import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final Map<String, String> project;

  const ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(project['image'] ?? '', fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre del proyecto: ${project['nombre']}', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Ubicación: ${project['ubicacion']}'),
                Text('Descripción: ${project['descripcion']}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
