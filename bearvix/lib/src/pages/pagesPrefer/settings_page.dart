import 'package:flutter/material.dart';
import 'package:bearvix/src/widgets/menu_widget.dart';
import 'package:bearvix/src/pages/principal.dart';
import 'package:bearvix/src/pages/conceptos.dart';
import 'package:bearvix/src/pages/pagesPrefer/home_page.dart';
import 'package:bearvix/src/share_prefs/preferencias_usuario.dart';

// Esta clase representa la pantalla de configuración de la app de matemáticas
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  
  static const String routeName = 'settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _colorSecundario;
  late int _genero;
  late int _colorRadio;
  final String _nombre = 'Angel';

  final prefs = PreferenciasUsario();
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    prefs.ultimatepage = SettingsPage.routeName;
    _genero = prefs.genero;
    _colorRadio = prefs.colores;
    _colorSecundario = prefs.colorSecundario;

    _textEditingController = TextEditingController(text: prefs.nombreUsuario);
  }

  int _currentIndex = 0;

 
  Color getColorBasedOnPreference(int preference) {
    if (preference == 1) {
      return const Color.fromARGB(255, 3, 15, 126);
    } else if (preference == 2) {
      return Colors.teal; 
    } else if (preference == 3) {
      return Colors.red;
    } else if (preference == 4) {
      return Colors.purple; 
    } else {
      return Colors.pinkAccent; 
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
          MaterialPageRoute(builder: (context) => const principal()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Conceptos()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
    }
  }

  // Cambiar género
  _setSelectedRadio(int? valor) {
    prefs.setnero = valor!;
    _genero = valor;
    setState(() {});
  }

  // Cambiar color
  _SetElegirRadio(int? valorColor) {
    prefs.setcolores = valorColor!;
    _colorRadio = valorColor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Ajustes', style: TextStyle(fontFamily: 'Roboto', fontSize: 24)),
        backgroundColor: getColorBasedOnPreference(prefs.colores),
      ),
     
      body: ListView(
        children: <Widget>[
          // Header con fondo matemático
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/image.png'), // Fondo de matemáticas
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text(
              'Ajustes',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: Colors.black,
              ),
            ),
          ),
          const Divider(),
          
          // Campo de texto para nombre
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  helperText: 'Introduce tu nombre',
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
                onChanged: (value) {
                  prefs.nomUsu = value;
                },
              ),
            ),
          ),
          
          // Configuración de género
          Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                RadioListTile(
                  value: 1,
                  title: const Text('Masculino'),
                  groupValue: _genero,
                  onChanged: _setSelectedRadio,
                ),
                RadioListTile(
                  value: 2,
                  title: const Text('Femenino'),
                  groupValue: _genero,
                  onChanged: _setSelectedRadio,
                ),
              ],
            ),
          ),
          
          // Elección de color de tema
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: const Text(
              'Elige un tema',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                RadioListTile(
                  value: 1,
                  title: const Text('Azul'),
                  groupValue: _colorRadio,
                  onChanged: _SetElegirRadio,
                ),
                RadioListTile(
                  value: 2,
                  title: const Text('Verde'),
                  groupValue: _colorRadio,
                  onChanged: _SetElegirRadio,
                ),
                RadioListTile(
                  value: 3,
                  title: const Text('Rojo'),
                  groupValue: _colorRadio,
                  onChanged: _SetElegirRadio,
                ),
                RadioListTile(
                  value: 4,
                  title: const Text('Morado'),
                  groupValue: _colorRadio,
                  onChanged: _SetElegirRadio,
                ),
                RadioListTile(
                  value: 5,
                  title: const Text('Rosado'),
                  groupValue: _colorRadio,
                  onChanged: _SetElegirRadio,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  // Barra de navegación inferior
  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color.fromRGBO(55, 57, 84, 1.0),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme.copyWith(
          bodySmall: const TextStyle(color: Colors.white),
        ),
      ),
      child: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.house_rounded),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Información',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
