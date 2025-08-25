class Notificacion {
	String titulo;
	String mensaje;
	String tipo; // 'info', 'advertencia', 'error'
	DateTime fechaHora;
	bool leida;

	Notificacion({
		required this.titulo,
		required this.mensaje,
		required this.tipo,
		DateTime? fechaHora,
		this.leida = false,
	}) : fechaHora = fechaHora ?? DateTime.now();

	void marcarComoLeida() {
		leida = true;
	}

	@override
	String toString() {
		return '[${tipo.toUpperCase()}] ${leida ? "(Leída)" : "(No leída)"} $titulo - $mensaje (${fechaHora.toString()})';
	}
}

class SistemaNotificaciones {
	List<Notificacion> notificaciones = [];

	void crearNotificacion(String titulo, String mensaje, String tipo) {
		notificaciones.add(Notificacion(titulo: titulo, mensaje: mensaje, tipo: tipo));
	}

	void marcarComoLeida(int index) {
		if (index >= 0 && index < notificaciones.length) {
			notificaciones[index].marcarComoLeida();
		}
	}

	List<Notificacion> filtrarPorTipo(String tipo) {
		return notificaciones.where((n) => n.tipo == tipo).toList();
	}

	void mostrarEstadisticas() {
		int total = notificaciones.length;
		int leidas = notificaciones.where((n) => n.leida).length;
		int noLeidas = total - leidas;
		int info = notificaciones.where((n) => n.tipo == 'info').length;
		int advertencia = notificaciones.where((n) => n.tipo == 'advertencia').length;
		int error = notificaciones.where((n) => n.tipo == 'error').length;
		print('Total: $total | Leídas: $leidas | No leídas: $noLeidas');
		print('Info: $info | Advertencia: $advertencia | Error: $error');
	}

	void mostrarTodas() {
		for (int i = 0; i < notificaciones.length; i++) {
			print('[$i] ${notificaciones[i]}');
		}
	}
}

void main() {
	final sistema = SistemaNotificaciones();
	sistema.crearNotificacion('Bienvenido', 'Gracias por usar la app.', 'info');
	sistema.crearNotificacion('Actualización', 'Hay una nueva versión disponible.', 'advertencia');
	sistema.crearNotificacion('Error de conexión', 'No se pudo conectar al servidor.', 'error');

	print('--- Notificaciones ---');
	sistema.mostrarTodas();

	print('\nMarcando la notificación 1 como leída...');
	sistema.marcarComoLeida(1);
	sistema.mostrarTodas();

	print('\nFiltrar solo errores:');
	var errores = sistema.filtrarPorTipo('error');
	for (var n in errores) {
		print(n);
	}

	print('\nEstadísticas:');
	sistema.mostrarEstadisticas();
}
