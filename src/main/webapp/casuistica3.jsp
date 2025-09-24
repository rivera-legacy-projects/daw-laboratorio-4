<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Casuística 3 - Sueldo Mensual de Obrero</title>
</head>
<body>
<h1>Desarrollo de Aplicaciones Web: 4 C24 Sección A - B</h1>
<h2>CASUÍSTICA 03: Sueldo Mensual de Obrero</h2>

<p><strong>Problema:</strong> Calcular el sueldo mensual de un obrero que gana a destajo de acuerdo a las prendas que confecciona. La tarifa para el pago depende de la prenda que termina de acuerdo al siguiente cuadro.</p>

<!-- Mostrar tabla de tarifas -->
<h3>Tabla de Tarifas por Prenda:</h3>
<table border="1">
    <tr>
        <th>TIPO DE PRENDA</th>
        <th>TARIFA (S/.)</th>
    </tr>
    <tr>
        <td>POLO</td>
        <td>0.50</td>
    </tr>
    <tr>
        <td>CAMISA</td>
        <td>1.00</td>
    </tr>
    <tr>
        <td>PANTALON</td>
        <td>1.50</td>
    </tr>
</table>

<p><strong>Nota:</strong> Los obreros durante el mes pueden confeccionar solo un tipo de prenda. Si el obrero confecciona más de 700 unidades recibirá una bonificación de acuerdo a su categoría, como se indica en el cuadro siguiente:</p>

<h3>Tabla de Bonificaciones por Categoría:</h3>
<table border="1">
    <tr>
        <th>CATEGORIA</th>
        <th>BONIFICACIÓN (S/.)</th>
    </tr>
    <tr>
        <td>A</td>
        <td>250.00</td>
    </tr>
    <tr>
        <td>B</td>
        <td>150.00</td>
    </tr>
    <tr>
        <td>C</td>
        <td>100.00</td>
    </tr>
    <tr>
        <td>D</td>
        <td>50.00</td>
    </tr>
</table>

<br>

<!-- Formulario para ingresar datos -->
<form method="post" action="casuistica3">
    <h3>Ingrese los datos del obrero:</h3>

    <table>
        <tr>
            <td><label for="tipoPrenda">Tipo de prenda confeccionada:</label></td>
            <td>
                <select name="tipoPrenda" id="tipoPrenda" required>
                    <option value="">Seleccione un tipo de prenda</option>
                    <option value="POLO">POLO (S/. 0.50)</option>
                    <option value="CAMISA">CAMISA (S/. 1.00)</option>
                    <option value="PANTALON">PANTALON (S/. 1.50)</option>
                </select>
            </td>
        </tr>
        <tr>
            <td><label for="cantidad">Cantidad de prendas confeccionadas:</label></td>
            <td>
                <input type="number" name="cantidad" id="cantidad" min="1" required>
            </td>
        </tr>
        <tr>
            <td><label for="categoria">Categoría del obrero:</label></td>
            <td>
                <select name="categoria" id="categoria" required>
                    <option value="">Seleccione una categoría</option>
                    <option value="A">A (Bonificación: S/. 250.00)</option>
                    <option value="B">B (Bonificación: S/. 150.00)</option>
                    <option value="C">C (Bonificación: S/. 100.00)</option>
                    <option value="D">D (Bonificación: S/. 50.00)</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="Calcular Sueldo Mensual">
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