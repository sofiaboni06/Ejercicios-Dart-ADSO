class Libro {
  String titulo;
  String autor;
  String genero;
  Usuario propietario;
  bool disponible;

  Libro({
    required this.titulo,
    required this.autor,
    required this.genero,
    required this.propietario,
    this.disponible = true,
  });

  @override
  String toString() =>
      '"$titulo" de $autor [$genero] (${disponible ? 'Disponible' : 'No disponible'})';
}

class Resena {
  Usuario usuario;
  int calificacion; // 1-5
  String comentario;
  DateTime fecha;

  Resena({
    required this.usuario,
    required this.calificacion,
    required this.comentario,
    DateTime? fecha,
  }) : fecha = fecha ?? DateTime.now();

  @override
  String toString() =>
      '[${calificacion}★] ${usuario.nombre}: ${comentario} (${fecha.toString().split(' ')[0]})';
}

class Intercambio {
  Usuario solicitante;
  Usuario receptor;
  Libro libro;
  DateTime fecha;
  bool completado;
  int? calificacion;
  String? comentario;

  Intercambio({
    required this.solicitante,
    required this.receptor,
    required this.libro,
    DateTime? fecha,
    this.completado = false,
  }) : fecha = fecha ?? DateTime.now();

  void completar(int calificacion, String comentario) {
    this.completado = true;
    this.calificacion = calificacion;
    this.comentario = comentario;
    libro.disponible = false;
    receptor.historialIntercambios.add(this);
    solicitante.historialIntercambios.add(this);
    receptor.reputacion.add(calificacion);
    solicitante.reputacion.add(calificacion);
  }

  @override
  String toString() =>
      '${solicitante.nombre} solicitó "${libro.titulo}" a ${receptor.nombre} (${completado ? 'Completado' : 'Pendiente'})';
}

class Usuario {
  String nombre;
  List<Libro> libros = [];
  List<Intercambio> historialIntercambios = [];
  List<int> reputacion = [];
  List<Resena> resenas = [];

  Usuario(this.nombre);

  void publicarLibro(Libro libro) {
    libros.add(libro);
    print('$nombre publicó: ${libro.titulo}');
  }

  void solicitarIntercambio(Libro libro, Usuario receptor) {
    if (libro.disponible && receptor.libros.contains(libro)) {
      print('$nombre solicitó el libro "${libro.titulo}" a ${receptor.nombre}');
      // Notificación simulada
      print(
        'Notificación: ${receptor.nombre}, tienes una nueva solicitud de intercambio.',
      );
    }
  }

  double reputacionPromedio() {
    if (reputacion.isEmpty) return 0.0;
    return reputacion.reduce((a, b) => a + b) / reputacion.length;
  }

  void escribirResena(Usuario aQuien, int calificacion, String comentario) {
    var resena = Resena(
      usuario: this,
      calificacion: calificacion,
      comentario: comentario,
    );
    aQuien.resenas.add(resena);
  }

  void mostrarHistorial() {
    print('Historial de ${nombre}:');
    for (var i in historialIntercambios) {
      print(i);
    }
  }

  void mostrarNotificaciones(List<Libro> nuevosLibros) {
    print('Notificaciones de nuevos libros para $nombre:');
    for (var libro in nuevosLibros) {
      print('- ${libro.titulo} de ${libro.autor}');
    }
  }

  List<Libro> buscarLibros(
    List<Libro> todos, {
    String? titulo,
    String? autor,
    String? genero,
  }) {
    return todos
        .where(
          (l) =>
              (titulo == null || l.titulo.contains(titulo)) &&
              (autor == null || l.autor.contains(autor)) &&
              (genero == null || l.genero == genero),
        )
        .toList();
  }
}

void main() {
  // Crear usuarios
  var ana = Usuario('Ana');
  var luis = Usuario('Luis');

  // Publicar libros
  var libro1 = Libro(
    titulo: '1984',
    autor: 'Orwell',
    genero: 'Ficción',
    propietario: ana,
  );
  var libro2 = Libro(
    titulo: 'Cien años de soledad',
    autor: 'García Márquez',
    genero: 'Realismo',
    propietario: luis,
  );
  ana.publicarLibro(libro1);
  luis.publicarLibro(libro2);

  // Buscar libros
  var todos = [libro1, libro2];
  print('\nBuscar libros de Ficción:');
  var ficcion = ana.buscarLibros(todos, genero: 'Ficción');
  for (var l in ficcion) print(l);

  // Solicitar intercambio
  ana.solicitarIntercambio(libro2, luis);

  // Simular intercambio completado
  var intercambio = Intercambio(
    solicitante: ana,
    receptor: luis,
    libro: libro2,
  );
  intercambio.completar(5, 'Transacción rápida y segura.');

  // Escribir reseña
  ana.escribirResena(luis, 5, 'Muy buen trato.');

  // Mostrar historial y reputación
  ana.mostrarHistorial();
  print('Reputación de Ana: ${ana.reputacionPromedio().toStringAsFixed(2)}');
  print('Reseñas de Luis:');
  for (var r in luis.resenas) print(r);

  // Notificaciones de nuevos libros
  var libro3 = Libro(
    titulo: 'El principito',
    autor: 'Saint-Exupéry',
    genero: 'Infantil',
    propietario: ana,
  );
  ana.mostrarNotificaciones([libro3]);
}
