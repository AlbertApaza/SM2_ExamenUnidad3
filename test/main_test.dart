// test/main_test.dart

import 'package:proyectomovilesii/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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

  group('Pruebas Unitarias de Lógica de Validación', () {
    test('Validador de Email debe retornar error para un email vacío', () {
      expect(validateEmail(''), 'Por favor, ingresa tu correo');
    });

    test('Validador de Email debe retornar error para un formato inválido', () {
      expect(validateEmail('email-incorrecto'), 'Ingresa un correo valido');
    });

    test('Validador de Email debe retornar nulo para un email válido', () {
      expect(validateEmail('test@dominio.com'), isNull);
    });

    test('Validador de Contraseña debe retornar error si es muy corta', () {
      expect(validatePassword('123'),
          'La contrasena debe tener al menos 6 caracteres');
    });

    test(
        'Validador de Contraseña debe retornar nulo para una contraseña válida',
        () {
      expect(validatePassword('password123'), isNull);
    });

    test('Validador de Nombre debe retornar error si el nombre está vacío', () {
      expect(validateName(''), 'Por favor, ingresa tu nombre');
    });

    test('Validador de Nombre debe retornar nulo para un nombre válido', () {
      expect(validateName('Juan Perez'), isNull);
    });
  });

  group('Pruebas de Interacción con Widgets de Formulario', () {
    testWidgets('Campo de Email debe mostrar error si está vacío y se valida',
        (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: TextFormField(validator: validateEmail),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Por favor, ingresa tu correo'), findsOneWidget);
    });

    testWidgets(
        'Campo de Email debe mostrar error al insertar formato inválido',
        (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: TextFormField(validator: validateEmail),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'formato-invalido');
      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Ingresa un correo valido'), findsOneWidget);
    });

    testWidgets(
        'Campo de Contraseña debe mostrar error al insertar texto corto',
        (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: TextFormField(validator: validatePassword),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), '1234');
      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('La contrasena debe tener al menos 6 caracteres'),
          findsOneWidget);
    });

    testWidgets('Formulario completo no debe mostrar errores con datos válidos',
        (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: Column(children: [
                TextFormField(validator: validateName),
                TextFormField(validator: validateEmail),
                TextFormField(validator: validatePassword),
              ]),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'Nombre Válido');
      await tester.enterText(
          find.byType(TextFormField).at(1), 'email@valido.com');
      await tester.enterText(
          find.byType(TextFormField).at(2), 'contraseñavalida');

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Por favor, ingresa tu nombre'), findsNothing);
      expect(find.text('Ingresa un correo valido'), findsNothing);
      expect(find.text('La contrasena debe tener al menos 6 caracteres'),
          findsNothing);
    });
  });
}
