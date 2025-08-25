import 'dart:math';

class Cancion {
	String titulo;
	String artista;
	int duracion; // en segundos
	String genero;
	double calificacion; // 1.0 a 5.0
	int reproducciones = 0;

	Cancion({
		required this.titulo,
		required this.artista,
		required this.duracion,
		required this.genero,
		required this.calificacion,
	});

	void reproducir() {
		reproducciones++;
		print('Reproduciendo: $titulo - $artista');
	}

	@override
	String toString() {
		return '$titulo - $artista [$genero] (${_formatoDuracion(duracion)}) Calificación: $calificacion, Reproducciones: $reproducciones';
	}

	String _formatoDuracion(int segundos) {
		int min = segundos ~/ 60;
		int seg = segundos % 60;
		return '${min}m ${seg}s';
	}
}

class Playlist {
	String nombre;
	List<Cancion> canciones = [];

	Playlist(this.nombre);

	void agregar(Cancion c) {
		canciones.add(c);
	}

	void quitar(String titulo) {
		canciones.removeWhere((c) => c.titulo == titulo);
	}

	void reproducirAleatoria() {
		if (canciones.isEmpty) {
			print('La playlist está vacía.');
			return;
		}
		var random = Random();
		var c = canciones[random.nextInt(canciones.length)];
		c.reproducir();
	}

	int duracionTotal() {
		return canciones.fold(0, (sum, c) => sum + c.duracion);
	}

	List<Cancion> filtrarPorGenero(String genero) {
		return canciones.where((c) => c.genero == genero).toList();
	}

	void mostrarEstadisticas() {
		int total = canciones.length;
		int totalReproducciones = canciones.fold(0, (sum, c) => sum + c.reproducciones);
		double promedioCalificacion = total > 0 ? canciones.fold(0.0, (sum, c) => sum + c.calificacion) / total : 0.0;
		print('Canciones: $total');
		print('Duración total: ${_formatoDuracion(duracionTotal())}');
		print('Reproducciones totales: $totalReproducciones');
		print('Calificación promedio: ${promedioCalificacion.toStringAsFixed(2)}');
	}

	void mostrarTodas() {
		for (var c in canciones) {
			print(c);
		}
	}

	String _formatoDuracion(int segundos) {
		int min = segundos ~/ 60;
		int seg = segundos % 60;
		return '${min}m ${seg}s';
	}
}

void main() {
	final playlist = Playlist('Favoritas');
	playlist.agregar(Cancion(titulo: 'Canción 1', artista: 'Artista A', duracion: 210, genero: 'Pop', calificacion: 4.5));
	playlist.agregar(Cancion(titulo: 'Canción 2', artista: 'Artista B', duracion: 180, genero: 'Rock', calificacion: 4.0));
	playlist.agregar(Cancion(titulo: 'Canción 3', artista: 'Artista C', duracion: 240, genero: 'Pop', calificacion: 5.0));

	print('--- Playlist ---');
	playlist.mostrarTodas();

	print('\nReproduciendo aleatoria:');
	playlist.reproducirAleatoria();

	print('\nFiltrar por género Pop:');
	var pop = playlist.filtrarPorGenero('Pop');
	for (var c in pop) {
		print(c);
	}

	print('\nEstadísticas:');
	playlist.mostrarEstadisticas();
}
