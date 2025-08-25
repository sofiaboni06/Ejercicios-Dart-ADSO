
class Categoria {
	String nombre;
	Categoria(this.nombre);
}

class Ubicacion {
	String direccion;
	String ciudad;
	Ubicacion({required this.direccion, required this.ciudad});
	@override
	String toString() => '$direccion, $ciudad';
}

class Participante {
	String nombre;
	bool pago = false;
	bool checkIn = false;
	int? evaluacion; // 1-5

	Participante(this.nombre);

	void realizarPago() {
		pago = true;
	}

	void hacerCheckInQR() {
		if (pago) checkIn = true;
	}

	void evaluar(int calificacion) {
		if (calificacion >= 1 && calificacion <= 5) {
			evaluacion = calificacion;
		}
	}
}

class Organizador {
	String nombre;
	List<Evento> eventosCreados = [];

	Organizador(this.nombre);

	Evento crearEvento({
		required String titulo,
		required Categoria categoria,
		required Ubicacion ubicacion,
		required DateTime fecha,
		required double precio,
	}) {
		var evento = Evento(
			titulo: titulo,
			categoria: categoria,
			ubicacion: ubicacion,
			fecha: fecha,
			precio: precio,
			organizador: this,
		);
		eventosCreados.add(evento);
		print('$nombre creó el evento "$titulo".');
		return evento;
	}
}

class Evento {
	String titulo;
	Categoria categoria;
	Ubicacion ubicacion;
	DateTime fecha;
	double precio;
	Organizador organizador;
	List<Participante> participantes = [];
	List<String> notificaciones = [];

	Evento({
		required this.titulo,
		required this.categoria,
		required this.ubicacion,
		required this.fecha,
		required this.precio,
		required this.organizador,
	});

	void registrarParticipante(Participante p) {
		participantes.add(p);
		notificaciones.add('Nuevo registro: ${p.nombre}');
	}

	void procesarPago(Participante p) {
		p.realizarPago();
		notificaciones.add('Pago recibido de ${p.nombre}');
	}

	void checkInQR(Participante p) {
		p.hacerCheckInQR();
		if (p.checkIn) {
			notificaciones.add('Check-in exitoso de ${p.nombre}');
		}
	}

	void enviarNotificacion(String mensaje) {
		notificaciones.add(mensaje);
	}

	void evaluarParticipante(Participante p, int calificacion) {
		p.evaluar(calificacion);
	}

	void estadisticas() {
		int total = participantes.length;
		int pagos = participantes.where((p) => p.pago).length;
		int checkins = participantes.where((p) => p.checkIn).length;
		var evaluaciones = participantes.where((p) => p.evaluacion != null).map((p) => p.evaluacion!).toList();
		double promedioEval = evaluaciones.isNotEmpty ? evaluaciones.reduce((a, b) => a + b) / evaluaciones.length : 0.0;
		print('Asistentes registrados: $total');
		print('Pagos realizados: $pagos');
		print('Check-ins: $checkins');
		print('Promedio de evaluación: ${promedioEval.toStringAsFixed(2)}');
	}

	void mostrarNotificaciones() {
		print('Notificaciones del evento "$titulo":');
		for (var n in notificaciones) {
			print('- $n');
		}
	}
}

void main() {
	var catCultural = Categoria('Cultural');
	var ubic = Ubicacion(direccion: 'Av. Central 123', ciudad: 'Lima');
	var org = Organizador('Comité Vecinal');
	var evento = org.crearEvento(
		titulo: 'Feria de Libros',
		categoria: catCultural,
		ubicacion: ubic,
		fecha: DateTime(2025, 9, 10, 10, 0),
		precio: 10.0,
	);

	var p1 = Participante('Ana');
	var p2 = Participante('Luis');
	evento.registrarParticipante(p1);
	evento.registrarParticipante(p2);
	evento.procesarPago(p1);
	evento.procesarPago(p2);
	evento.checkInQR(p1);
	evento.evaluarParticipante(p1, 5);
	evento.evaluarParticipante(p2, 4);

	evento.enviarNotificacion('¡El evento inicia pronto!');

	print('\n--- Estadísticas del evento ---');
	evento.estadisticas();
	print('\n--- Notificaciones ---');
	evento.mostrarNotificaciones();
}
