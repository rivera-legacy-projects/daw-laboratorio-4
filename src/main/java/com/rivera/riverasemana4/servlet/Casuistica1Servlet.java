package com.rivera.riverasemana4.servlet;

import com.rivera.riverasemana4.util.ConexionDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/casuistica1")
public class Casuistica1Servlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String instituto = request.getParameter("instituto");
        String categoria = request.getParameter("categoria");
        String costoStr = request.getParameter("costo");

        try {
            double costoOriginal = Double.parseDouble(costoStr);

            // Obtener porcentaje de descuento de la base de datos
            int porcentajeDescuento = obtenerPorcentajeDescuento(instituto, categoria);

            // Calcular descuento e importe final
            double descuento = costoOriginal * porcentajeDescuento / 100.0;
            double importeFinal = costoOriginal - descuento;

            // Guardar el cálculo en la base de datos (opcional)
            guardarCalculo(instituto, categoria, costoOriginal, descuento, importeFinal);

            // Enviar resultados al JSP
            request.setAttribute("instituto", instituto);
            request.setAttribute("categoria", categoria);
            request.setAttribute("costoOriginal", costoOriginal);
            request.setAttribute("porcentajeDescuento", porcentajeDescuento);
            request.setAttribute("descuento", descuento);
            request.setAttribute("importeFinal", importeFinal);

            request.getRequestDispatcher("resultado.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "El costo debe ser un número válido");
            request.getRequestDispatcher("casuistica1.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Error en la base de datos: " + e.getMessage());
            request.getRequestDispatcher("casuistica1.jsp").forward(request, response);
        }
    }

    private int obtenerPorcentajeDescuento(String instituto, String categoria) throws SQLException {
        String sql = "SELECT porcentaje_descuento FROM descuentos WHERE instituto = ? AND categoria = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, instituto);
            stmt.setString(2, categoria);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("porcentaje_descuento");
                } else {
                    throw new SQLException("No se encontró descuento para el instituto y categoría especificados");
                }
            }
        }
    }

    private void guardarCalculo(String instituto, String categoria, double costoOriginal,
                                double descuento, double importeFinal) throws SQLException {
        String sql = "INSERT INTO calculos (instituto, categoria, costo_original, descuento, importe_final) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, instituto);
            stmt.setString(2, categoria);
            stmt.setDouble(3, costoOriginal);
            stmt.setDouble(4, descuento);
            stmt.setDouble(5, importeFinal);

            stmt.executeUpdate();
        }
    }
}