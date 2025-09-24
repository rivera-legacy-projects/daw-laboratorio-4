<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Casuística 2 - Bonificación por Estado Civil y Número de Hijos</title>
</head>
<body>
<h1>Desarrollo de Aplicaciones Web: 4 C24 Sección A - B</h1>
<h2>CASUÍSTICA 02: Bonificación de Trabajador</h2>

<p><strong>Problema:</strong> Determinar el neto a cobrar por un trabajador sabiendo que tiene derecho a una bonificación dependiendo de su estado civil y del número de hijos.</p>

<!-- Mostrar tabla de referencia -->
<h3>Tabla de Bonificaciones por Estado Civil:</h3>
<table border="1">
    <tr>
        <th>ESTADO CIVIL</th>
        <th>PORCENTAJE</th>
    </tr>
    <tr>
        <td>Casado</td>
        <td>13%</td>
    </tr>
    <tr>
        <td>Viudo</td>
        <td>15%</td>
    </tr>
    <tr>
        <td>Soltero</td>
        <td>5%</td>
    </tr>
</table>

<p><strong>Nota:</strong> Adicionalmente se le abonará el 1.5% por cada hijo con un máximo de 6%.</p>

<br>

<!-- Formulario para ingresar datos -->
<form method="post" action="casuistica2">
    <h3>Ingrese los datos del trabajador:</h3>

    <table>
        <tr>
            <td><label for="estadoCivil">Estado Civil:</label></td>
            <td>
                <select name="estadoCivil" id="estadoCivil" required>
                    <option value="">Seleccione un estado civil</option>
                    <option value="Casado">Casado</option>
                    <option value="Viudo">Viudo</option>
                    <option value="Soltero">Soltero</option>
                </select>
            </td>
        </tr>
        <tr>
            <td><label for="numHijos">Número de hijos:</label></td>
            <td>
                <input type="number" name="numHijos" id="numHijos" min="0" max="20" required>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p><strong>Sueldo base:</strong> S/. 1,000.00 (fijo)</p>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="Calcular Bonificación y Sueldo Neto">
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

<br>
<p>
    <a href="index.jsp">← Volver al menú principal</a>
</p>

<hr>
<p><strong>REPOSITORIO:</strong> https://github.com/rivera-legacy-projects/daw-laboratorio-4.git</p>
</body>
</html>