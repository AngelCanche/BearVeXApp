import 'dart:math';
import 'dart:ui';

import 'package:bearvix/src/pages/conceptos.dart';
import 'package:bearvix/src/pages/pagesPrefer/home_page.dart';
import 'package:bearvix/src/pages/pagesPrefer/settings_page.dart';
import 'package:bearvix/src/pages/paralelogramo.dart';
import 'package:bearvix/src/pages/poligono.dart';

import 'package:bearvix/src/pages/vector.dart';
import 'package:bearvix/src/pages/vectores.dart';
import 'package:bearvix/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';

import 'informacion.dart';

class principal extends StatefulWidget {
  // const principal({super.key});

  @override
  State<principal> createState() => _principalState();
}

class _principalState extends State<principal> {
  bool _isDrawerExpanded = false;
  int _currentIndex = 0;
  final prefs = new PreferenciasUsario();
  Color getColorBasedOnPreference(int preference) {
  if (preference == 1) {
    return Color.fromARGB(255, 3, 15, 126); // Azul
  } else if (preference == 2) {
    return Colors.teal; // Verde
  } else if (preference == 3) {
    return Colors.red; // Naranja
  } else if (preference == 4) {
    return Colors.purple; // Morado
  } else {
    return Colors.pinkAccent; // Color por defecto en caso de que no coincida con ninguna preferencia
  }
}

// Usar la función en el código



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

//   @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      
      alignment: Alignment.topCenter,
      children: [

        Scaffold(
        
            backgroundColor: Color.fromARGB(255, 237, 236, 248),
            appBar: AppBar(
                backgroundColor: getColorBasedOnPreference(prefs.colores),
                automaticallyImplyLeading: false,
              title: Center(
          child: Image.asset(
            'assets/test1.png',
            height: 50.0,  // Ajustar el tamaño de la imagen según sea necesario
          ),
        ),
        centerTitle: true,
            ),
           body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              SizedBox(height: 10.0),
              titulo(),
              SizedBox(height: 15.0),
              crearCarta(),
              SizedBox(height: 15.0),
              _titulos(),
              _botonesRedondeados(),
            ],
          ),
        ],
      ),
    
            bottomNavigationBar: _bottomNavigationBar(context)),
      ],
    );
  }

  Widget titulo() {
    return Center(
      child: Text(
        'Buenos Dias, ${prefs.nombreUsuario}',
        style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 25,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget crearCarta() {
    return Column(children: const <Widget>[
      FadeInImage(
        image: AssetImage('assets/Logotiposinfondo.png'),
        height: 150,
        width: 150,
        placeholder: AssetImage('assets/17.1_jar-loading.gif'),
        fadeInDuration: Duration(milliseconds: 1),
      ),
    ]);
  }

  Widget _titulos() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centrar el texto horizontalmente
        children: const <Widget>[
          Center(
            // Centrar verticalmente en el `Center`
            child: Text(
              'Métodos de Vectores al Alcance de tu Mano',
              style: TextStyle(
                color: Color.fromARGB(216, 1, 63, 145),
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Alineación del texto
            ),
          ),
          SizedBox(height: 10.0),
          Center(
            child: Text(
              'Accede a una amplia gama de métodos para trabajar con vectores. Desde el método del polígono hasta la suma de vectores, todo explicado de forma clara y práctica',
              style: TextStyle(
                color: Color.fromARGB(255, 10, 102, 59),
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center, // Alineación del texto
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromARGB(255, 63, 73, 87),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
      ),
      child: BottomNavigationBar(
        onTap:
            onTabTapped,
        currentIndex: _currentIndex, 
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.house_rounded,
              color: _currentIndex == 0
                  ? Colors.pinkAccent
                  : Color.fromARGB(255, 254, 254, 255),
            ),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.feed,
              color: _currentIndex == 1
                  ? Colors.pinkAccent
                  : Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'Información',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: _currentIndex == 2
                  ? Colors.pinkAccent
                  : Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'Ajustes',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 3
                  ? Colors.pinkAccent
                  : Color.fromARGB(255, 255, 255, 255),
            ),
            label: 'Perfil de Usuario',
          ),
        ],
      ),
    );
  }

  Widget _botonesRedondeados() {
    return Table(
      children: [
        TableRow(children: [
          _crearBotonesRedondeado(
            Colors.blue,
            'assets/vectores-image.png',
            'Vectores',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Vector()),
              );
            },
          ),
          _crearBotonesRedondeado(
            Colors.purpleAccent,
            'assets/poligono-icon.png',
            'Metodo del Poligono',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Poligono()),
              );
            },
          ),
        ]),
        TableRow(children: [
          _crearBotonesRedondeado(
            Color.fromARGB(0, 255, 64, 128),
            'assets/sumavectores.png',
            'Suma de Vectores',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SumadeVectores()),
              );
            },
          ),
          _crearBotonesRedondeado(
            Colors.orange,
            'assets/metodo-paralelogramo-icon.png',
            'Paralelogramo',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Paralelogramo()),
              );
            },
          ),
        ]),
      ],
    );
  }

  Widget _crearBotonesRedondeado(
      Color color, String imagePath, String texto, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 185.0,
        margin: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration( gradient: LinearGradient( colors: [color1, color2],
               begin: Alignment.topLeft, 
               end: Alignment.bottomRight, 
               ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const SizedBox(
                    height: 5.0,
                  ),
                  Image.asset(
                    imagePath,
                    width: 153.0, // Definir el tamaño de la imagen
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    texto,
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 5.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
const Color color1 = Color(0xFF0097b2); // Azul 
const Color color2 = Color(0xFF7ed957); //
Widget _gradientBox(String label) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
