
class Servicio {
	String nombre;
	String descripcion;
	double precioBase;
	Prestador prestador;

	Servicio({required this.nombre, required this.descripcion, required this.precioBase, required this.prestador});
}

class Cliente {
	String nombre;
	List<Solicitud> historialSolicitudes = [];

	Cliente(this.nombre);

	Solicitud solicitarServicio(Servicio servicio, DateTime fecha) {
		var solicitud = Solicitud(
			cliente: this,
			servicio: servicio,
			fecha: fecha,
		);
		historialSolicitudes.add(solicitud);
		servicio.prestador.recibirSolicitud(solicitud);
		return solicitud;
	}
}

class Prestador {
	String nombre;
	List<Servicio> servicios = [];
	List<Solicitud> solicitudesRecibidas = [];
	List<Calificacion> calificaciones = [];

	Prestador(this.nombre);

	void agregarServicio(Servicio s) => servicios.add(s);

	void recibirSolicitud(Solicitud s) => solicitudesRecibidas.add(s);

	void agendarCita(Solicitud s, DateTime fecha) {
		s.fecha = fecha;
		s.estado = 'Agendada';
	}

	void actualizarEstado(Solicitud s, String estado) {
		s.estado = estado;
	}

	void calificarCliente(Cliente c, int estrellas, String comentario) {
		var cal = Calificacion(
			de: this.nombre,
			para: c.nombre,
			estrellas: estrellas,
			comentario: comentario,
		);
		c.historialSolicitudes.last.calificaciones.add(cal);
	}

	void mostrarEstadisticas() {
		print('--- Estadísticas de $nombre ---');
		print('Servicios ofrecidos: ${servicios.length}');
		print('Solicitudes recibidas: ${solicitudesRecibidas.length}');
		double promedio = calificaciones.isNotEmpty ? calificaciones.map((c) => c.estrellas).reduce((a, b) => a + b) / calificaciones.length : 0.0;
		print('Calificación promedio: ${promedio.toStringAsFixed(2)}');
	}
}

class Solicitud {
	Cliente cliente;
	Servicio servicio;
	DateTime fecha;
	String estado; // Pendiente, Agendada, En progreso, Completada
	List<Calificacion> calificaciones = [];
	Pago? pago;

	Solicitud({required this.cliente, required this.servicio, required this.fecha, this.estado = 'Pendiente'});

	void registrarPago(double monto) {
		pago = Pago(monto: monto, fecha: DateTime.now());
		estado = 'Completada';
	}

	void calificarPrestador(int estrellas, String comentario) {
		var cal = Calificacion(
			de: cliente.nombre,
			para: servicio.prestador.nombre,
			estrellas: estrellas,
			comentario: comentario,
		);
		servicio.prestador.calificaciones.add(cal);
		calificaciones.add(cal);
	}
}

class Pago {
	double monto;
	DateTime fecha;
	Pago({required this.monto, required this.fecha});
}

class Calificacion {
	String de;
	String para;
	int estrellas;
	String comentario;
	Calificacion({required this.de, required this.para, required this.estrellas, required this.comentario});
}

void main() {
	var prestador = Prestador('Juan');
	var servicio1 = Servicio(nombre: 'Plomería', descripcion: 'Reparaciones de cañerías', precioBase: 100, prestador: prestador);
	var servicio2 = Servicio(nombre: 'Electricista', descripcion: 'Instalaciones eléctricas', precioBase: 120, prestador: prestador);
	prestador.agregarServicio(servicio1);
	prestador.agregarServicio(servicio2);

	var cliente = Cliente('Ana');
	var solicitud = cliente.solicitarServicio(servicio1, DateTime(2025, 9, 15, 10, 0));
	prestador.agendarCita(solicitud, DateTime(2025, 9, 15, 10, 0));
	prestador.actualizarEstado(solicitud, 'En progreso');
	solicitud.registrarPago(120);
	solicitud.calificarPrestador(5, 'Excelente servicio');
	prestador.calificarCliente(cliente, 5, 'Cliente puntual y amable');

	print('--- Historial de servicios de Ana ---');
	for (var s in cliente.historialSolicitudes) {
		print('${s.servicio.nombre} | Estado: ${s.estado} | Pago: ${s.pago?.monto ?? 0}');
		for (var c in s.calificaciones) {
			print('Calificación: ${c.estrellas}★ de ${c.de} para ${c.para} - ${c.comentario}');
		}
	}

	prestador.mostrarEstadisticas();
}
