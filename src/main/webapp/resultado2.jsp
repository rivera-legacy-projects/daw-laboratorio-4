<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.DecimalFormat" %>
<html>
<head>
    <title>Resultado - Casuística 2</title>
</head>
<body>
<h1>Desarrollo de Aplicaciones Web: 4 C24 Sección A - B</h1>
<h2>CASUÍSTICA 02: Resultado del Cálculo de Bonificación</h2>

<%
    // Obtener los valores calculados
    String estadoCivil = (String) request.getAttribute("estadoCivil");
    Integer numHijos = (Integer) request.getAttribute("numHijos");
    Double sueldoBase = (Double) request.getAttribute("sueldoBase");
    Integer porcentajeBonificacion = (Integer) request.getAttribute("porcentajeBonificacion");
    Double bonificacionEstado = (Double) request.getAttribute("bonificacionEstado");
    Double porcentajeHijos = (Double) request.getAttribute("porcentajeHijos");
    Double bonificacionHijos = (Double) request.getAttribute("bonificacionHijos");
    Double bonificacionTotal = (Double) request.getAttribute("bonificacionTotal");
    Double sueldoNeto = (Double) request.getAttribute("sueldoNeto");

    // Formato para mostrar números con 2 decimales
    DecimalFormat df = new DecimalFormat("#0.00");
%>

<h3>Datos del Trabajador:</h3>
<table border="1">
    <tr>
        <td><strong>Estado Civil:</strong></td>
        <td><%= estadoCivil %></td>
    </tr>
    <tr>
        <td><strong>Número de hijos:</strong></td>
        <td><%= numHijos %></td>
    </tr>
    <tr>
        <td><strong>Sueldo base:</strong></td>
        <td>S/. <%= df.format(sueldoBase) %></td>
    </tr>
</table>

<h3>Detalle del Cálculo de Bonificaciones:</h3>
<table border="1">
    <tr>
        <td><strong>Bonificación por estado civil (<%= porcentajeBonificacion %>%):</strong></td>
        <td>S/. <%= df.format(bonificacionEstado) %></td>
    </tr>
    <tr>
        <td><strong>Bonificación por hijos (<%= df.format(porcentajeHijos) %>%):</strong></td>
        <td>S/. <%= df.format(bonificacionHijos) %></td>
    </tr>
    <tr style="background-color: #e0e0e0;">
        <td><strong>BONIFICACIÓN TOTAL:</strong></td>
        <td><strong>S/. <%= df.format(bonificacionTotal) %></strong></td>
    </tr>
    <tr style="background-color: #f0f0f0;">
        <td><strong>SUELDO NETO A COBRAR:</strong></td>
        <td><strong>S/. <%= df.format(sueldoNeto) %></strong></td>
    </tr>
</table>

<h3>Fórmulas aplicadas:</h3>
<p>
    <strong>1. Bonificación por Estado Civil:</strong><br>
    Bonificación Estado = Sueldo Base × (Porcentaje Estado Civil ÷ 100)<br>
    Bonificación Estado = S/. <%= df.format(sueldoBase) %> × (<%= porcentajeBonificacion %>% ÷ 100) = <strong>S/. <%= df.format(bonificacionEstado) %></strong><br><br>

    <strong>2. Bonificación por Hijos:</strong><br>
    Porcentaje por Hijos = <%= numHijos %> hijos × 1.5% = <%= df.format(porcentajeHijos) %>% (máximo 6%)<br>
    Bonificación Hijos = S/. <%= df.format(sueldoBase) %> × (<%= df.format(porcentajeHijos) %>% ÷ 100) = <strong>S/. <%= df.format(bonificacionHijos) %></strong><br><br>

    <strong>3. Cálculo Final:</strong><br>
    Bonificación Total = Bonificación Estado + Bonificación Hijos<br>
    Bonificación Total = S/. <%= df.format(bonificacionEstado) %> + S/. <%= df.format(bonificacionHijos) %> = <strong>S/. <%= df.format(bonificacionTotal) %></strong><br><br>

    Sueldo Neto = Sueldo Base + Bonificación Total<br>
    Sueldo Neto = S/. <%= df.format(sueldoBase) %> + S/. <%= df.format(bonificacionTotal) %> = <strong>S/. <%= df.format(sueldoNeto) %></strong>
</p>

<br>
<p>
    <a href="casuistica2.jsp">← Realizar otro cálculo</a> |
    <a href="index.jsp">Ir al menú principal</a>
</p>

<hr>
<p><strong>REPOSITORIO:</strong> https://github.com/rivera-legacy-projects/daw-laboratorio-4.git</p>
</body>
</html>