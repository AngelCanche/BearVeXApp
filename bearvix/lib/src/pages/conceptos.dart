import 'package:bearvix/src/pages/pagesPrefer/home_page.dart';
import 'package:bearvix/src/pages/pagesPrefer/settings_page.dart';
import 'package:bearvix/src/pages/principal.dart';
import 'package:bearvix/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';

class Conceptos extends StatefulWidget {
  const Conceptos({super.key});

  @override
  _ConceptosState createState() => _ConceptosState();
}

class _ConceptosState extends State<Conceptos> {
  int _currentIndex = 0;
  final prefs = PreferenciasUsario();

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
      return Colors.pinkAccent; // Color por defecto
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => principal()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => Conceptos()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColorBasedOnPreference(prefs.colores),
        automaticallyImplyLeading: false,
        title: const Text('Conceptos, Teoría'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          _buildCard(
            'Tema 1 Vectores',
            'Te explicamos qué es un vector en física y matemáticas, su sentido, tipos, características y ejemplos. Además, otras acepciones de vector',
            'assets/ejemplos.png',
            '-¿Qué es un vector?\nDentro del área de la física, se le conoce como vector a un segmento de recta en el espacio que parte de un punto hacia otro, es decir, que tiene dirección y sentido.Los vectores en física tienen por función expresar las llamadas magnitudes vectoriales.\n\n'
            'Los vectores permiten representar magnitudes físicas dotadas no sólo de intensidad, sino de dirección, como es el caso de la fuerza, la velocidad o el desplazamiento.Ese rasgo de contar con dirección es el que distingue a las magnitudes vectoriales de las escalares.\n\n'
            '-Características de un vector\n\n'
            'Los vectores, representados gráficamente, poseen las siguientes características:\n\n'
            'Dirección. Definida como la recta sobre la cual se traza el vector, continuada infinitamente en el espacio.\n\n'
            'Módulo o amplitud. La longitud gráfica que equivale, dentro de un plano, a la magnitud del vector expresada numéricamente.\n\n'
            'Sentido. Representado por la punta de la flecha que gráficamente representa al vector, indica el lugar geométrico hacia el cual se dirige el vector.\n\n'
            'Punto de aplicación. Correspondiente al lugar o punto geométrico en donde inicia el vector gráficamente.\n\n'
            'Nombre o denominación. Representado mediante una letra que acompaña al vector gráficamente representado, y que coincide con la magnitud que expresa o con la suma de los puntos de inicio y fin de su valor. \n\n'
            '-Sentido de un vector\nEl sentido de los vectores se representa gráficamente mediante una punta de flecha apuntando en alguna dirección. Esto representa hacia qué lado de la línea de acción (dirección) se dirige el vector, o sea, hacia dónde apunta.\n'
            'El sentido es sumamente importante a la hora de expresar magnitudes vectoriales, ya que puede determinar el tipo de operación o cálculo que es posible realizar con las mismas. \n\n'
            '-Tipos de vectores\nSegún la ubicación de su punto de aplicación, los vectores se clasifican en:\n\n'
            'Vectores libres: Aquellos que no poseen un punto de aplicación particular.\n\n'
            'Vectores deslizantes: Aquellos cuyo punto de aplicación puede ser uno cualquiera a lo largo de la recta de aplicación.\n\n'
            'Vectores fijos o ligados: Aquellos que poseen un único y determinado punto de aplicación.Sin embargo, también es posible clasificar los vectores según otros elementos, de la siguiente manera:\n\n'
            'Vectores angulares o concurrentes: Aquellos que forman ángulos respecto de sus líneas de acción o direcciones.\n\n'
            'Vectores opuestos: Aquellos que poseen igual magnitud pero sentido contrario \n\n'
            'Vectores colineales: Aquellos que comparten recta de acción. \n\n'
            'Vectores paralelos: Aquellos cuyas líneas de acción sean, justamente, paralelas \n\n'
            'Vectores coplanarios: Aquellos cuyas rectas de acción estén situadas en un mismo plano.'
          ),
          _buildCard(
            'Tema 2 Método del polígono (cabeza y cola)',
            'Aplicamos el método del polígono, colocando los vectores uno a continuación del otro, siempre unidos mediante cabeza y cola',
            'assets/metododelpoligonoejemplo.jpg',
            'El método del polígono o también conocido como cabeza y cola, es un método que permite sumar vectores y consiste en colocar los vectores a sumar uno a continuación del otro, siempre la cabeza de un vector estará unida a la cola del siguiente; así, el vector resultante R se traza uniendo la cola del primer vector con la cabeza del último vector.\n\n'
            'Con este método podemos sumar 2, 3 o más vectores. Recuerda que los vectores no son simples números, por ello, solo los podemos sumar empleando ciertos métodos, como el método del polígono.\n\n'
            'El Método del Polígono lo podemos encontrar de dos formas, por medio del método gráfico o por medio del método analítico, en nuestro sitio web solamente hablaremos del método analítico, ya que para el método gráfico es necesario tener una regla, un transportador y una escala para determinar la resultante y el ángulo, pero en este caso solamente nos interesan los cálculos.'
          ),
          _buildCard(
            'Tema 3 Suma de Vectores',
            'Unión de vectores a través de juntar la parte delantera de un vector con la parte trasera del otro',
            'assets/sumadevectoresejemplo.png',
            'La operación de suma de dos o más vectores da como resultado otro vector. Para realizar la suma de vectores existen distintos métodos, ya sea de manera algebraica o mediante el uso de geometría analítica. El método algebraico es conocido como método directo.\n\n'
            'Los métodos usando geometría analítica son conocidos como, el método del polígono que es utilizado para sumar más de dos vectores, el método del triángulo es el caso particular del método del polígono cuando únicamente se suman dos vectores, y el método del paralelogramo igualmente para sumar dos vectores.'
          ),
          _buildCard(
            'Tema 4 Método del Paralelogramo',
            'El método del paralelogramo se puede aplicar para obtener la resultante de dos vectores separados un ángulo cualesquiera',
            'assets/metodoparalelogramoejemplo.png',
            'El método del paralelogramo es un procedimiento gráfico sencillo que permite hallar la suma de dos vectores.Primero se dibujan ambos vectores (a y b) a escala, con el punto de aplicación común. Seguidamente, se completa un paralelogramo, dibujando dos segmentos paralelos a ellos.\n\n'
            'El vector suma resultante (a+b) será la diagonal del paralelogramo con origen común a los dos vectores originales.El método del paralelogramo se desarrolla en la página de suma de vectores.\n\n'
            'La regla del paralelogramo dice que si colocamos dos vectores de manera que tengan el mismo punto inicial, y luego completamos los vectores en un paralelogramo, luego la suma de los vectores es la diagonal dirigida que comienza en el mismo punto que los vectores.'
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  // Método para construir un Card con título, imagen, texto y contenido adicional
  Widget _buildCard(String title, String description, String imagePath, String bodyText) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FadeInImage(
            image: AssetImage(imagePath),
            placeholder: AssetImage('assets/17.1_jar-loading.gif'),
            fadeInDuration: const Duration(milliseconds: 200),
            height: 250.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              bodyText,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color.fromRGBO(55, 57, 84, 1.0),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.white)),
      ),
      child: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.house_rounded, color: _currentIndex == 0 ? Colors.pinkAccent : Colors.white),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed, color: _currentIndex == 1 ? Colors.pinkAccent : Colors.white),
            label: 'Información',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: _currentIndex == 2 ? Colors.pinkAccent : Colors.white),
            label: 'Ajustes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: _currentIndex == 3 ? Colors.pinkAccent : Colors.white),
            label: 'Perfil de Usuario',
          ),
        ],
      ),
    );
  }
}
