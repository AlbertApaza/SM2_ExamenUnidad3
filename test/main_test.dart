// test/main_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proyectomovilesii/main.dart';




void main() {
  group('Pruebas de Lógica de Validación de Formularios (Entorno Aislado)', () {


    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) return 'Por favor, ingresa tu correo';
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value))
        return 'Ingresa un correo valido';
      return null;
    }

    String? validatePassword(String? value) {
      if (value == null || value.isEmpty)
        return 'Por favor, ingresa una contrasena';
      if (value.length < 6)
        return 'La contrasena debe tener al menos 6 caracteres';
      return null;
    }

    String? validateName(String? value) {
      if (value == null || value.isEmpty) return 'Por favor, ingresa tu nombre';
      return null;
    }

    // --- INICIO DE LAS PRUEBAS UNITARIAS ---

    // PRUEBA 1: Probar el validador de email
    test('Validador de Email debe retornar error para un email vacío', () {
      // ARRANGE & ACT: Llamamos a la función de validación con un valor nulo/vacío
      var result = validateEmail('');
      // ASSERT: Verificamos que devuelve el mensaje de error esperado
      expect(result, 'Por favor, ingresa tu correo');
    });

    // PRUEBA 2: Probar el validador de email con formato incorrecto
    test('Validador de Email debe retornar error para un formato inválido', () {
      // ARRANGE & ACT
      var result = validateEmail('email-incorrecto');
      // ASSERT
      expect(result, 'Ingresa un correo valido');
    });

    // PRUEBA 3: Probar el validador de email con un formato correcto
    test('Validador de Email debe retornar nulo para un email válido', () {
      // ARRANGE & ACT
      var result = validateEmail('test@dominio.com');
      // ASSERT: Si la validación es exitosa, debe devolver nulo
      expect(result, isNull);
    });

    // PRUEBA 4: Probar el validador de contraseña
    test('Validador de Contraseña debe retornar error si es muy corta', () {
      // ARRANGE & ACT
      var result = validatePassword('123');
      // ASSERT
      expect(result, 'La contrasena debe tener al menos 6 caracteres');
    });

    // PRUEBA 5: Probar el validador de contraseña con un valor correcto
    test(
        'Validador de Contraseña debe retornar nulo para una contraseña válida',
        () {
      // ARRANGE & ACT
      var result = validatePassword('password123');
      // ASSERT
      expect(result, isNull);
    });

    // PRUEBA 6: Probar el validador de nombre
    test('Validador de Nombre debe retornar error si el nombre está vacío', () {
      // ARRANGE & ACT
      var result = validateName('');
      // ASSERT
      expect(result, 'Por favor, ingresa tu nombre');
    });

    // PRUEBA 7 (EXTRA): Probar que el validador de nombre acepta un nombre válido
    test('Validador de Nombre debe retornar nulo para un nombre válido', () {
      // ARRANGE & ACT
      var result = validateName('Juan Perez');
      // ASSERT
      expect(result, isNull);
    });
  });
}
