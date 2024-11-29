  import 'package:bearvix/src/pages/conceptos.dart';
  import 'package:bearvix/src/pages/pagesPrefer/settings_page.dart';
  import 'package:bearvix/src/pages/principal.dart';
  import 'package:bearvix/src/share_prefs/preferencias_usuario.dart';
  import 'package:bearvix/src/widgets/menu_widget.dart';
  import 'package:flutter/material.dart';

  class HomePage extends StatefulWidget {
    static final String routeName = 'home';

    @override
    _HomePageState createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    final prefs = PreferenciasUsario();
    int _currentIndex = 0;
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
      return Colors.pink; // Color por defecto en caso de que no coincida con ninguna preferencia
    }
  }

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

    @override
    Widget build(BuildContext context) {
      prefs.ultimatepage = HomePage.routeName;
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Preferencias de Usuario'),
          backgroundColor: getColorBasedOnPreference(prefs.colores)
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
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nombre de usuario: ${prefs.nombreUsuario}'),
            Divider(),
            Text('Color seleccionado: ${prefs.colores}'),
            Divider(),
            Text('Género: ${prefs.genero}'),
            Divider(),
          ]
            )
          ],
        ),
        bottomNavigationBar: _bottomNavigationBar(context),
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
          onTap: onTabTapped, // Establecer el método onTabTapped para manejar los taps
          currentIndex: _currentIndex, // Actualizar el índice actual
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
                color: _currentIndex == 3 ? Colors.pinkAccent : Color.fromARGB(255, 255, 255, 255),
              ),
              label: 'Perfil de Usuario',
            ),
          ],
        ),
      );
    }
  }



