<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.DecimalFormat" %>
<html>
<head>
    <title>Resultado - Casuística 3</title>
</head>
<body>
<h1>Desarrollo de Aplicaciones Web: 4 C24 Sección A - B</h1>
<h2>CASUÍSTICA 03: Resultado del Cálculo de Sueldo de Obrero</h2>

<%
    // Obtener los valores calculados
    String tipoPrenda = (String) request.getAttribute("tipoPrenda");
    Integer cantidad = (Integer) request.getAttribute("cantidad");
    String categoria = (String) request.getAttribute("categoria");
    Double tarifa = (Double) request.getAttribute("tarifa");
    Double sueldoBase = (Double) request.getAttribute("sueldoBase");
    Double bonificacion = (Double) request.getAttribute("bonificacion");
    Double sueldoFinal = (Double) request.getAttribute("sueldoFinal");
    Boolean aplicaBonificacion = (Boolean) request.getAttribute("aplicaBonificacion");

    // Formato para mostrar números con 2 decimales
    DecimalFormat df = new DecimalFormat("#0.00");
%>

<h3>Datos del Obrero:</h3>
<table border="1">
    <tr>
        <td><strong>Tipo de prenda confeccionada:</strong></td>
        <td><%= tipoPrenda %></td>
    </tr>
    <tr>
        <td><strong>Cantidad de prendas:</strong></td>
        <td><%= cantidad %> unidades</td>
    </tr>
    <tr>
        <td><strong>Categoría del obrero:</strong></td>
        <td><%= categoria %></td>
    </tr>
    <tr>
        <td><strong>Tarifa por prenda:</strong></td>
        <td>S/. <%= df.format(tarifa) %></td>
    </tr>
</table>

<h3>Detalle del Cálculo de Sueldo:</h3>
<table border="1">
    <tr>
        <td><strong>Sueldo base (tarifa × cantidad):</strong></td>
        <td>S/. <%= df.format(sueldoBase) %></td>
    </tr>
    <tr>
        <td><strong>¿Aplica bonificación? (> 700 unidades):</strong></td>
        <td>
            <% if (aplicaBonificacion) { %>
            <span style="color: green;"><strong>SÍ</strong> - Confeccionó <%= cantidad %> unidades</span>
            <% } else { %>
            <span style="color: red;"><strong>NO</strong> - Confeccionó <%= cantidad %> unidades (≤ 700)</span>
            <% } %>
        </td>
    </tr>
    <tr>
        <td><strong>Bonificación por categoría <%= categoria %>:</strong></td>
        <td>
            <% if (aplicaBonificacion) { %>
            S/. <%= df.format(bonificacion) %>
            <% } else { %>
            S/. 0.00 (No aplica)
            <% } %>
        </td>
    </tr>
    <tr style="background-color: #f0f0f0;">
        <td><strong>SUELDO FINAL A COBRAR:</strong></td>
        <td><strong>S/. <%= df.format(sueldoFinal) %></strong></td>
    </tr>
</table>

<h3>Fórmulas aplicadas:</h3>
<p>
    <strong>1. Cálculo del Sueldo Base:</strong><br>
    Sueldo Base = Tarifa por Prenda × Cantidad de Prendas<br>
    Sueldo Base = S/. <%= df.format(tarifa) %> × <%= cantidad %> = <strong>S/. <%= df.format(sueldoBase) %></strong><br><br>

    <strong>2. Evaluación de Bonificación:</strong><br>
    <% if (aplicaBonificacion) { %>
    Como el obrero confeccionó <%= cantidad %> unidades (> 700), <strong>SÍ aplica bonificación</strong><br>
    Bonificación por categoría <%= categoria %> = <strong>S/. <%= df.format(bonificacion) %></strong><br><br>
    <% } else { %>
    Como el obrero confeccionó <%= cantidad %> unidades (≤ 700), <strong>NO aplica bonificación</strong><br>
    Bonificación = <strong>S/. 0.00</strong><br><br>
    <% } %>

    <strong>3. Cálculo Final:</strong><br>
    Sueldo Final = Sueldo Base + Bonificación<br>
    Sueldo Final = S/. <%= df.format(sueldoBase) %> + S/. <%= df.format(bonificacion) %> = <strong>S/. <%= df.format(sueldoFinal) %></strong>
</p>

<% if (!aplicaBonificacion) { %>
<div style="background-color: #fff3cd; padding: 10px; border: 1px solid #ffeaa7; margin: 20px 0;">
    <strong>Nota:</strong> Para recibir bonificación, el obrero debe confeccionar más de 700 unidades durante el mes.
</div>
<% } %>

<br>
<p>
    <a href="casuistica3.jsp">← Realizar otro cálculo</a> |
    <a href="index.jsp">Ir al menú principal</a>
</p>

<hr>
<p><strong>REPOSITORIO:</strong> https://github.com/rivera-legacy-projects/daw-laboratorio-4.git</p>
</body>
</html>