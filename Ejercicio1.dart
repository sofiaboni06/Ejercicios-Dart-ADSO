import 'dart:io';

void main() {
	print('--- Calculadora de Propinas para Delivery ---');

	// Solicitar valor del pedido
	stdout.write('Ingrese el valor del pedido: ');
	double? valorPedido = double.tryParse(stdin.readLineSync() ?? '');
	if (valorPedido == null || valorPedido <= 0) {
		print('Valor del pedido inválido.');
		return;
	}

	// Seleccionar tipo de servicio
	print('Seleccione el tipo de servicio:');
	print('1. Comida');
	print('2. Farmacia');
	print('3. Supermercado');
	stdout.write('Opción (1-3): ');
	int? tipoServicio = int.tryParse(stdin.readLineSync() ?? '');
	String tipoServicioStr;
	switch (tipoServicio) {
		case 1:
			tipoServicioStr = 'Comida';
			break;
		case 2:
			tipoServicioStr = 'Farmacia';
			break;
		case 3:
			tipoServicioStr = 'Supermercado';
			break;
		default:
			print('Tipo de servicio inválido.');
			return;
	}

	// Seleccionar calidad del servicio
	print('Calidad del servicio:');
	print('1. Excelente (20%)');
	print('2. Bueno (15%)');
	print('3. Regular (10%)');
	stdout.write('Opción (1-3): ');
	int? calidad = int.tryParse(stdin.readLineSync() ?? '');
	double porcentajePropina;
	String mensaje;
	switch (calidad) {
		case 1:
			porcentajePropina = 0.20;
			mensaje = '¡Gracias por reconocer un servicio excelente!';
			break;
		case 2:
			porcentajePropina = 0.15;
			mensaje = '¡Gracias por tu valoración positiva!';
			break;
		case 3:
			porcentajePropina = 0.10;
			mensaje = '¡Gracias por tu opinión, seguiremos mejorando!';
			break;
		default:
			print('Calidad de servicio inválida.');
			return;
	}

	double propina = valorPedido * porcentajePropina;
	double total = valorPedido + propina;

	print('\nResumen del pedido:');
	print('Tipo de servicio: $tipoServicioStr');
	print('Valor del pedido: S/ ${valorPedido.toStringAsFixed(2)}');
	print('Propina sugerida: S/ ${propina.toStringAsFixed(2)}');
	print('Total a pagar: S/ ${total.toStringAsFixed(2)}');
	print(mensaje);
}
