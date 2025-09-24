<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Casuística 1 - Cálculo de Importe con Descuento</title>
</head>
<body>
<h1>Desarrollo de Aplicaciones Web: 4 C24 Sección A - B</h1>
<h2>CASUÍSTICA 01: Cálculo de Importe con Descuento por Instituto</h2>

<p><strong>Problema:</strong> Determinar el importe a pagar por un alumno de un instituto cuya cuota tiene un porcentaje de descuento que se establece según el instituto de procedencia del alumno y su categoría.</p>

<!-- Mostrar tabla de referencia -->
<h3>Tabla de Descuentos por Instituto y Categoría:</h3>
<table border="1">
    <tr>
        <th>COLEGIO</th>
        <th colspan="3">CATEGORIA</th>
    </tr>
    <tr>
        <th></th>
        <th>A</th>
        <th>B</th>
        <th>C</th>
    </tr>
    <tr>
        <td>Nacional</td>
        <td>50%</td>
        <td>40%</td>
        <td>30%</td>
    </tr>
    <tr>
        <td>Particular</td>
        <td>25%</td>
        <td>20%</td>
        <td>15%</td>
    </tr>
</table>

<br>

<!-- Formulario para ingresar datos -->
<form method="post" action="casuistica1">
    <h3>Ingrese los datos del alumno:</h3>

    <table>
        <tr>
            <td><label for="instituto">Instituto de procedencia:</label></td>
            <td>
                <select name="instituto" id="instituto" required>
                    <option value="">Seleccione un instituto</option>
                    <option value="Nacional">Nacional</option>
                    <option value="Particular">Particular</option>
                </select>
            </td>
        </tr>
        <tr>
            <td><label for="categoria">Categoría del alumno:</label></td>
            <td>
                <select name="categoria" id="categoria" required>
                    <option value="">Seleccione una categoría</option>
                    <option value="A">A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                </select>
            </td>
        </tr>
        <tr>
            <td><label for="costo">Costo original de la cuota (S/.):</label></td>
            <td>
                <input type="number" name="costo" id="costo" step="0.01" min="0" required>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="Calcular Importe a Pagar">
            </td>
        </tr>
    </table>
</form>

<!-- Mostrar errores si existen -->
<% String error = (String) request.getAttribute("error"); %>
<% if (error != null) { %>
<div style="color: red; margin-top: 20px;">
    <strong>Error:</strong> <%= error %>
</div>
<% } %>

<hr>
<p><strong>REPOSITORIO:</strong> https://github.com/rivera-legacy-projects/daw-laboratorio-4.git</p>
</body>
</html>