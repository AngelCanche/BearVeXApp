import 'package:bearvix/src/pages/conceptos.dart';
import 'package:bearvix/src/pages/informacion.dart';
import 'package:bearvix/src/pages/pagesPrefer/home_page.dart';
import 'package:bearvix/src/pages/pagesPrefer/settings_page.dart';

import 'package:bearvix/src/pages/principal.dart';
import 'package:bearvix/src/share_prefs/preferencias_usuario.dart';
import 'package:bearvix/src/widgets/colores.dart';
import 'package:flutter/material.dart';
import 'dart:math';


import 'package:flutter/material.dart';
import 'dart:math';

class Paralelogramo extends StatelessWidget {
  final prefs = PreferenciasUsario();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Método del Paralelogramo',
      theme: ThemeData(
        primarySwatch: getMaterialColorBasedOnPreference(prefs.colores),
      ),
      home: VectorDrawer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VectorDrawer extends StatefulWidget {
  @override
  _VectorDrawerState createState() => _VectorDrawerState();
}

class _VectorDrawerState extends State<VectorDrawer> {
  double angleA = 0;
  double angleB = 0;
  double lengthA = 100;
  double lengthB = 100;
  double zoom = 1.0;
  Offset offset = Offset(0, 0);
  int _currentIndex = 0;

  double resultantLength = 0;
  double resultantAngle = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => principal()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Conceptos()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
    }
  }

  void _increaseZoom() {
    setState(() {
      zoom += 0.1;
    });
  }

  void _decreaseZoom() {
    setState(() {
      if (zoom > 0.1) {
        zoom -= 0.1;
      }
    });
  }

  void _calculateResultant() {
    double angleRadianA = angleA * pi / 180;
    double angleRadianB = angleB * pi / 180;

    // Calculamos la resultante
    double cosAlpha = cos(angleRadianB - angleRadianA);
    resultantLength = sqrt(pow(lengthA, 2) + pow(lengthB, 2) + 2 * lengthA * lengthB * cosAlpha);

    // Calculamos el ángulo de la resultante
    resultantAngle = atan2(lengthB * sin(angleRadianB - angleRadianA), lengthA + lengthB * cos(angleRadianB - angleRadianA)) * 180 / pi;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      appBar: AppBar(
        title: Text('Método del Paralelogramo'),
        centerTitle: true,
      ),
      body: isWideScreen
          ? Row(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomPaint(
                        painter: CartesianGridAndVectorPainter(angleA, lengthA, angleB, lengthB, resultantLength, resultantAngle, zoom),
                        child: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: 250,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _buildControls(),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomPaint(
                        painter: CartesianGridAndVectorPainter(angleA, lengthA, angleB, lengthB, resultantLength, resultantAngle, zoom),
                        child: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight*0.6,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(child: SingleChildScrollView(
                  child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _buildControls(),
                ),
                )
                )
              ],
            ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _buildControls() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Información actual',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(labelText: 'Ángulo A'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              angleA = double.tryParse(value) ?? 0;
              _calculateResultant();
            });
          },
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(labelText: 'Longitud A'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              lengthA = double.tryParse(value) ?? 100;
              _calculateResultant();
            });
          },
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(labelText: 'Ángulo B'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              angleB = double.tryParse(value) ?? 0;
              _calculateResultant();
            });
          },
        ),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(labelText: 'Longitud B'),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              lengthB = double.tryParse(value) ?? 100;
              _calculateResultant();
            });
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _increaseZoom,
          child: Text('+ Zoom'),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _decreaseZoom,
          child: Text('- Zoom'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Resultante: $resultantLength, Ángulo: $resultantAngle'),
        ),
      ],
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color.fromRGBO(55, 57, 84, 1.0),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme.copyWith(
          caption: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      child: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.house_rounded,
              color: _currentIndex == 0 ? Colors.pinkAccent : Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.feed,
              color: _currentIndex == 1 ? Colors.pinkAccent : Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'Información',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: _currentIndex == 2 ? Colors.pinkAccent : Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'Ajustes',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 2 ? Colors.pinkAccent : Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'Perfil de Usuario',
          ),
        ],
      ),
    );
  }
}

class CartesianGridAndVectorPainter extends CustomPainter {
  final double angleA;
  final double lengthA;
  final double angleB;
  final double lengthB;
  final double resultantLength;
  final double resultantAngle;
  final double zoom;

  CartesianGridAndVectorPainter(
      this.angleA, this.lengthA, this.angleB, this.lengthB, 
      this.resultantLength, this.resultantAngle, this.zoom);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint gridPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 0.5;

    final double step = 40 * zoom;  // Hacer la cuadrícula más espaciosa

    // Dibuja la cuadrícula
    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    final Paint axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    // Dibuja los ejes X y Y
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      axisPaint,
    );
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      axisPaint,
    );

    // Dibuja el vector A (más grande)
    double radiansA = angleA * pi / 180;
    double endXA = lengthA * cos(radiansA) * zoom * 1.5;  // Aumentar el tamaño del vector A
    double endYA = lengthA * sin(radiansA) * zoom * 1.5;
    Paint vectorPaint = Paint()..color = Colors.blue..strokeWidth = 3.0;
    Offset startA = Offset(size.width / 2, size.height / 2);
    Offset endA = Offset(size.width / 2 + endXA, size.height / 2 - endYA);
    canvas.drawLine(startA, endA, vectorPaint);

    // Dibuja el vector B (más grande)
    double radiansB = angleB * pi / 180;
    double endXB = lengthB * cos(radiansB) * zoom * 1.5;  // Aumentar el tamaño del vector B
    double endYB = lengthB * sin(radiansB) * zoom * 1.5;
    vectorPaint.color = Colors.green;
    Offset startB = Offset(size.width / 2, size.height / 2);
    Offset endB = Offset(size.width / 2 + endXB, size.height / 2 - endYB);
    canvas.drawLine(startB, endB, vectorPaint);

    // Dibuja las líneas que cierran el paralelogramo
    vectorPaint.color = Colors.purple;  // Color para las líneas que cierran el paralelogramo
    canvas.drawLine(
        Offset(size.width / 2 + endXA, size.height / 2 - endYA),
        Offset(size.width / 2 + endXA + endXB, size.height / 2 - endYA - endYB),
        vectorPaint);
    canvas.drawLine(
        Offset(size.width / 2 + endXB, size.height / 2 - endYB),
        Offset(size.width / 2 + endXA + endXB, size.height / 2 - endYA - endYB),
        vectorPaint);

    // Dibuja la resultante (más grande)
    double radiansResultant = resultantAngle * pi / 180;
    double endXResultant = resultantLength * cos(radiansResultant) * zoom * 1.5;  // Aumentar la resultante
    double endYResultant = resultantLength * sin(radiansResultant) * zoom * 1.5;
    vectorPaint.color = Colors.red;
    canvas.drawLine(
      Offset(size.width / 2, size.height / 2),
      Offset(size.width / 2 + endXResultant, size.height / 2 - endYResultant),
      vectorPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
