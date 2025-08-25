class Resena {
	String usuario;
	int calificacion; // 1-5
	String comentario;
	DateTime fecha;
	int utilidad; // votos de utilidad

	Resena({
		required this.usuario,
		required this.calificacion,
		required this.comentario,
		DateTime? fecha,
		this.utilidad = 0,
	}) : fecha = fecha ?? DateTime.now();

	void marcarUtil() {
		utilidad++;
	}

	@override
	String toString() {
		return '[$calificacion★] $usuario: $comentario (Utilidad: $utilidad, ${fecha.toString().split(' ')[0]})';
	}
}

class SistemaResenas {
	List<Resena> resenas = [];

	void agregarResena(Resena r) {
		resenas.add(r);
	}

	double promedioCalificaciones() {
		if (resenas.isEmpty) return 0.0;
		return resenas.fold(0, (sum, r) => sum + r.calificacion) / resenas.length;
	}

	List<Resena> filtrarPorEstrellas(int estrellas) {
		return resenas.where((r) => r.calificacion == estrellas).toList();
	}

	List<Resena> masUtiles({int top = 3}) {
		var copia = List<Resena>.from(resenas);
		copia.sort((a, b) => b.utilidad.compareTo(a.utilidad));
		return copia.take(top).toList();
	}

	void mostrarEstadisticas() {
		print('Total de reseñas: ${resenas.length}');
		print('Promedio de calificación: ${promedioCalificaciones().toStringAsFixed(2)}');
		for (int i = 1; i <= 5; i++) {
			print('Reseñas de $i★: ${filtrarPorEstrellas(i).length}');
		}
	}

	void mostrarTodas() {
		for (var r in resenas) {
			print(r);
		}
	}
}

void main() {
	final sistema = SistemaResenas();
	sistema.agregarResena(Resena(usuario: 'Ana', calificacion: 5, comentario: 'Excelente app!'));
	sistema.agregarResena(Resena(usuario: 'Luis', calificacion: 3, comentario: 'Está bien, pero puede mejorar.'));
	sistema.agregarResena(Resena(usuario: 'Sofía', calificacion: 1, comentario: 'No funciona en mi dispositivo.'));
	sistema.resenas[0].marcarUtil();
	sistema.resenas[0].marcarUtil();
	sistema.resenas[2].marcarUtil();

	print('--- Reseñas ---');
	sistema.mostrarTodas();

	print('\nPromedio de calificaciones: ${sistema.promedioCalificaciones().toStringAsFixed(2)}');

	print('\nFiltrar por 5 estrellas:');
	var cinco = sistema.filtrarPorEstrellas(5);
	for (var r in cinco) {
		print(r);
	}

	print('\nReseñas más útiles:');
	var utiles = sistema.masUtiles();
	for (var r in utiles) {
		print(r);
	}

	print('\nEstadísticas:');
	sistema.mostrarEstadisticas();
}
