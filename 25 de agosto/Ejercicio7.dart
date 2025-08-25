import 'dart:math';

class Ubicacion {
	String nombre;
	double latitud;
	double longitud;
	String categoria; // casa, trabajo, restaurante, hospital
	String notas;

	Ubicacion({
		required this.nombre,
		required this.latitud,
		required this.longitud,
		required this.categoria,
		this.notas = '',
	});

	@override
	String toString() {
		return '$nombre [$categoria] (Lat: $latitud, Lon: $longitud) - $notas';
	}
}

class GestorUbicaciones {
	List<Ubicacion> ubicaciones = [];

	void agregar(Ubicacion u) {
		ubicaciones.add(u);
	}

	void eliminar(String nombre) {
		ubicaciones.removeWhere((u) => u.nombre == nombre);
	}

	List<Ubicacion> buscarPorCategoria(String categoria) {
		return ubicaciones.where((u) => u.categoria == categoria).toList();
	}

	double distancia(Ubicacion a, Ubicacion b) {
		// Fórmula de Haversine
		const R = 6371; // Radio de la Tierra en km
		double dLat = _gradosARadianes(b.latitud - a.latitud);
		double dLon = _gradosARadianes(b.longitud - a.longitud);
		double lat1 = _gradosARadianes(a.latitud);
		double lat2 = _gradosARadianes(b.latitud);
		double aHav = pow(sin(dLat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);
		double c = 2 * atan2(sqrt(aHav), sqrt(1 - aHav));
		return R * c;
	}

	double _gradosARadianes(double grados) => grados * pi / 180;

	void mostrarTodas() {
		for (var u in ubicaciones) {
			print(u);
		}
	}
}

void main() {
	final gestor = GestorUbicaciones();
	gestor.agregar(Ubicacion(nombre: 'Casa', latitud: -12.05, longitud: -77.05, categoria: 'casa', notas: 'Mi hogar.'));
	gestor.agregar(Ubicacion(nombre: 'Trabajo', latitud: -12.08, longitud: -77.03, categoria: 'trabajo', notas: 'Oficina central.'));
	gestor.agregar(Ubicacion(nombre: 'Restaurante Rico', latitud: -12.07, longitud: -77.04, categoria: 'restaurante', notas: 'Comida favorita.'));

	print('--- Ubicaciones guardadas ---');
	gestor.mostrarTodas();

	print('\nBuscando restaurantes:');
	var restaurantes = gestor.buscarPorCategoria('restaurante');
	for (var r in restaurantes) {
		print(r);
	}

	print('\nDistancia entre Casa y Trabajo:');
	var casa = gestor.ubicaciones.firstWhere((u) => u.nombre == 'Casa');
	var trabajo = gestor.ubicaciones.firstWhere((u) => u.nombre == 'Trabajo');
	print('${gestor.distancia(casa, trabajo).toStringAsFixed(2)} km');

	print('\nEliminando "Restaurante Rico"...');
	gestor.eliminar('Restaurante Rico');
	gestor.mostrarTodas();
}
