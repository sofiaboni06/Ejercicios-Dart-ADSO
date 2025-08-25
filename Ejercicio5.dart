import 'dart:io';

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
	print('--- Calculadora de Descuentos por Volumen ---');
	stdout.write('Ingrese el monto de la compra: ');
	double? monto = double.tryParse(stdin.readLineSync() ?? '');
	if (monto == null || monto < 0) {
		print('Monto inválido.');
		return;
	}

	double descuento = 0;
	if (monto > 200) {
		descuento = 0.15;
	} else if (monto > 100) {
		descuento = 0.10;
	} else if (monto > 50) {
		descuento = 0.05;
	}

	double ahorro = monto * descuento;
	double subtotal = monto - ahorro;
	double iva = subtotal * 0.19;
	double total = subtotal + iva;

	print('\nResumen de la compra:');
	print('Monto de compra:   \$${monto.toStringAsFixed(2)}');
	print('Descuento aplicado: ${descuento * 100}%');
	print('Ahorro:            \$${ahorro.toStringAsFixed(2)}');
	print('Subtotal:          \$${subtotal.toStringAsFixed(2)}');
	print('IVA (19%):         \$${iva.toStringAsFixed(2)}');
	print('Total a pagar:     \$${total.toStringAsFixed(2)}');
}
