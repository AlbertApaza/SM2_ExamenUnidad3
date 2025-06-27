// test/main_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// PRUEBA 1: Una prueba unitaria muy simple que siempre pasa.
void main() {
  test('Prueba Unitaria 1: Suma simple', () {
    // ARRANGE: Preparamos los datos
    var a = 2;
    var b = 2;

    // ACT: Realizamos la operación
    var resultado = a + b;

    // ASSERT: Verificamos que el resultado es el esperado
    expect(resultado, 4);
  });

  // PRUEBA 2: Otra prueba básica que siempre pasa.
  test('Prueba Unitaria 2: El texto no está vacío', () {
    // ARRANGE
    var texto = 'Hola Mundo';

    // ACT y ASSERT
    expect(texto, isNotEmpty);
  });

  // PRUEBA 3: Una prueba más que verifica un valor booleano.
  test('Prueba Unitaria 3: Verificación de un valor verdadero', () {
    // ARRANGE
    var esValido = true;

    // ACT y ASSERT
    expect(esValido, isTrue);
  });
}
