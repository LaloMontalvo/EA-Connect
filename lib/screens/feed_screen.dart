import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      _showExitDialog();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("¿Salir de la aplicación?"),
        content: Text("¿Estás seguro que deseas salir?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text("Salir"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EA CONNECT", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text("Iniciar Sesión"),
          ),
          SizedBox(width: 7),
        ],
      ),
      body: _selectedIndex == 0 ? FeedPage() : SizedBox.shrink(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            label: 'Salir',
          ),
        ],
      ),
    );
  }
}

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Map<String, dynamic>> publicaciones = [
    {
      'imagen': 'assets/proyecto1.jpg',
      'nombre': 'Construcción Casa Residencial',
      'ubicacion': 'Córdoba, Veracruz',
      'descripcion': 'Casa hecha con materiales de alta calidad y acabados modernos.',
      'fecha': DateTime.now(),
      'likes': 15,
      'liked': false,
    },
    {
      'imagen': 'assets/proyecto2.jpg',
      'nombre': 'Construcción de Unidad Deportiva 30 de abril',
      'ubicacion': 'Cuitláhuac, Veracruz',
      'descripcion': 'Espacio público diseñado para cancha de fútbol siete.',
      'fecha': DateTime.now().subtract(Duration(days: 1)),
      'likes': 23,
      'liked': false,
    },
    {
      'imagen': 'assets/proyecto3.jpg',
      'nombre': 'Construcción de Casa residencial',
      'ubicacion': 'Cuitláhuac, Veracruz',
      'descripcion': 'Casa hecha con diseño de tabique aparente.',
      'fecha': DateTime.now().subtract(Duration(days: 2)),
      'likes': 13,
      'liked': false,
    },
  ];

  void _toggleLike(int index) {
    setState(() {
      if (publicaciones[index]['liked']) {
        publicaciones[index]['likes'] -= 1;
      } else {
        publicaciones[index]['likes'] += 1;
      }
      publicaciones[index]['liked'] = !publicaciones[index]['liked'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: publicaciones.length,
      itemBuilder: (context, index) {
        final publicacion = publicaciones[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del proyecto
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  publicacion['imagen'],
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre del proyecto
                    Text(
                      publicacion['nombre'],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    // Ubicación con ícono
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red, size: 18),
                        SizedBox(width: 4),
                        Text(
                          publicacion['ubicacion'],
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Descripción
                    Text(
                      publicacion['descripcion'],
                      style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                    ),
                    SizedBox(height: 10),
                    // Fecha y corazones alineados
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy').format(publicacion['fecha']),
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                        InkWell(
                          onTap: () => _toggleLike(index),
                          child: Row(
                            children: [
                              Icon(
                                publicacion['liked']
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                                size: 18,
                              ),
                              SizedBox(width: 4),
                              Text('${publicacion['likes']}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
