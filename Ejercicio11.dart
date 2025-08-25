class Usuario {
	String nombre;
	List<Curso> cursosInscritos = [];
	Map<Curso, Progreso> progresos = {};

	Usuario(this.nombre);

	void inscribirse(Curso curso) {
		if (!cursosInscritos.contains(curso)) {
			cursosInscritos.add(curso);
			progresos[curso] = Progreso(curso: curso);
			print('$nombre inscrito en ${curso.titulo}');
		}
	}

	void verLeccion(Curso curso, int indice) {
		if (!cursosInscritos.contains(curso)) return;
		if (indice < 0 || indice >= curso.lecciones.length) return;
		progresos[curso]?.marcarCompletada(indice);
		print('$nombre completó la lección: ${curso.lecciones[indice].titulo}');
	}

	void calificarCurso(Curso curso, double calificacion) {
		if (cursosInscritos.contains(curso)) {
			curso.agregarCalificacion(calificacion);
		}
	}

	void mostrarProgreso() {
		for (var curso in cursosInscritos) {
			var prog = progresos[curso];
			print('${curso.titulo}: ${prog?.porcentajeCompletado().toStringAsFixed(1)}% completado');
			if (prog?.estaCompleto() ?? false) {
				print('¡Certificado obtenido!');
			}
		}
	}

	void recomendaciones(List<Curso> todosLosCursos) {
		print('Recomendaciones para $nombre:');
		for (var curso in todosLosCursos) {
			if (!cursosInscritos.contains(curso)) {
				print('- ${curso.titulo} (${curso.categoria})');
			}
		}
	}
}

class Curso {
	String titulo;
	String categoria;
	List<Leccion> lecciones;
	List<double> calificaciones = [];

	Curso({required this.titulo, required this.categoria, required this.lecciones});

	void agregarCalificacion(double calificacion) {
		if (calificacion >= 1 && calificacion <= 5) {
			calificaciones.add(calificacion);
		}
	}

	double promedioCalificaciones() {
		if (calificaciones.isEmpty) return 0.0;
		return calificaciones.reduce((a, b) => a + b) / calificaciones.length;
	}
}

class Leccion {
	String titulo;
	String contenido;

	Leccion({required this.titulo, required this.contenido});
}

class Progreso {
	Curso curso;
	List<bool> completadas;

	Progreso({required this.curso}) : completadas = List.filled(curso.lecciones.length, false);

	void marcarCompletada(int indice) {
		if (indice >= 0 && indice < completadas.length) {
			completadas[indice] = true;
		}
	}

	double porcentajeCompletado() {
		int completadasCount = completadas.where((c) => c).length;
		return (completadasCount / completadas.length) * 100;
	}

	bool estaCompleto() {
		return completadas.every((c) => c);
	}
}

void main() {
	// Crear cursos y lecciones
	var curso1 = Curso(
		titulo: 'Dart Básico',
		categoria: 'Programación',
		lecciones: [
			Leccion(titulo: 'Introducción', contenido: 'Bienvenido a Dart.'),
			Leccion(titulo: 'Variables', contenido: 'Tipos y declaración.'),
			Leccion(titulo: 'Funciones', contenido: 'Definición y uso.'),
		],
	);
	var curso2 = Curso(
		titulo: 'Flutter UI',
		categoria: 'Desarrollo Móvil',
		lecciones: [
			Leccion(titulo: 'Widgets', contenido: 'Estructura básica.'),
			Leccion(titulo: 'Layouts', contenido: 'Columnas y filas.'),
		],
	);
	var todosLosCursos = [curso1, curso2];

	// Crear usuario
	var usuario = Usuario('María');
	usuario.inscribirse(curso1);
	usuario.inscribirse(curso2);

	// Simular avance
	usuario.verLeccion(curso1, 0);
	usuario.verLeccion(curso1, 1);
	usuario.verLeccion(curso2, 0);

	// Calificar cursos
	usuario.calificarCurso(curso1, 5);
	usuario.calificarCurso(curso2, 4);

	print('\n--- Progreso de usuario ---');
	usuario.mostrarProgreso();

	print('\n--- Estadísticas de cursos ---');
	for (var curso in todosLosCursos) {
		print('${curso.titulo}: Promedio de calificación: ${curso.promedioCalificaciones().toStringAsFixed(2)}');
	}

	print('\n--- Recomendaciones ---');
	usuario.recomendaciones(todosLosCursos);
}
