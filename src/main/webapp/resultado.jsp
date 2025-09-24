<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.DecimalFormat" %>
<html>
<head>
    <title>Resultado - Casuística 1</title>
</head>
<body>
<h1>Desarrollo de Aplicaciones Web: 4 C24 Sección A - B</h1>
<h2>CASUÍSTICA 01: Resultado del Cálculo</h2>

<%
    // Obtener los valores calculados
    String instituto = (String) request.getAttribute("instituto");
    String categoria = (String) request.getAttribute("categoria");
    Double costoOriginal = (Double) request.getAttribute("costoOriginal");
    Integer porcentajeDescuento = (Integer) request.getAttribute("porcentajeDescuento");
    Double descuento = (Double) request.getAttribute("descuento");
    Double importeFinal = (Double) request.getAttribute("importeFinal");

    // Formato para mostrar números con 2 decimales
    DecimalFormat df = new DecimalFormat("#0.00");
%>

<h3>Datos del Alumno:</h3>
<table border="1">
    <tr>
        <td><strong>Instituto de procedencia:</strong></td>
        <td><%= instituto %>
        </td>
    </tr>
    <tr>
        <td><strong>Categoría:</strong></td>
        <td><%= categoria %>
        </td>
    </tr>
    <tr>
        <td><strong>Porcentaje de descuento aplicado:</strong></td>
        <td><%= porcentajeDescuento %>%</td>
    </tr>
</table>

<h3>Detalle del Cálculo:</h3>
<table border="1">
    <tr>
        <td><strong>Costo original de la cuota:</strong></td>
        <td>S/. <%= df.format(costoOriginal) %>
        </td>
    </tr>
    <tr>
        <td><strong>Descuento aplicado (<%= porcentajeDescuento %>%):</strong></td>
        <td>S/. <%= df.format(descuento) %>
        </td>
    </tr>
    <tr style="background-color: #f0f0f0;">
        <td><strong>IMPORTE FINAL A PAGAR:</strong></td>
        <td><strong>S/. <%= df.format(importeFinal) %>
        </strong></td>
    </tr>
</table>

<h3>Fórmula aplicada:</h3>
<p>
    <strong>Descuento =</strong> Costo Original × (Porcentaje de Descuento ÷ 100)<br>
    <strong>Descuento =</strong> S/. <%= df.format(costoOriginal) %> × (<%= porcentajeDescuento %>% ÷ 100) =
    S/. <%= df.format(descuento) %><br><br>

    <strong>Importe Final =</strong> Costo Original - Descuento<br>
    <strong>Importe Final =</strong> S/. <%= df.format(costoOriginal) %> - S/. <%= df.format(descuento) %> =
    <strong>S/. <%= df.format(importeFinal) %>
    </strong>
</p>

<br>
<p>
    <a href="casuistica1.jsp">← Realizar otro cálculo</a> |
    <a href="index.jsp">Ir al menú principal</a>
</p>

<hr>
<p><strong>REPOSITORIO:</strong> https://github.com/rivera-legacy-projects/daw-laboratorio-4.git</p>
</body>
</html>