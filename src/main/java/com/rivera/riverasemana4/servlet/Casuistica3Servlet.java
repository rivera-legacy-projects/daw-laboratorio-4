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

@WebServlet("/casuistica3")
public class Casuistica3Servlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tipoPrenda = request.getParameter("tipoPrenda");
        String cantidadStr = request.getParameter("cantidad");
        String categoria = request.getParameter("categoria");

        try {
            int cantidad = Integer.parseInt(cantidadStr);

            // Obtener tarifa de la prenda
            double tarifa = obtenerTarifaPrenda(tipoPrenda);

            // Calcular sueldo base
            double sueldoBase = tarifa * cantidad;

            // Obtener bonificación por categoría
            double bonificacion = obtenerBonificacionCategoria(categoria);

            // Verificar bonificación adicional si confecciona más de 700 unidades
            if (cantidad > 700) {
                bonificacion = obtenerBonificacionCategoria(categoria);
            } else {
                bonificacion = 0.0; // Sin bonificación si no supera 700 unidades
            }

            // Calcular sueldo final
            double sueldoFinal = sueldoBase + bonificacion;

            // Guardar el cálculo en la base de datos
            guardarCalculoObrero(tipoPrenda, cantidad, categoria, sueldoBase, bonificacion, sueldoFinal);

            // Enviar resultados al JSP
            request.setAttribute("tipoPrenda", tipoPrenda);
            request.setAttribute("cantidad", cantidad);
            request.setAttribute("categoria", categoria);
            request.setAttribute("tarifa", tarifa);
            request.setAttribute("sueldoBase", sueldoBase);
            request.setAttribute("bonificacion", bonificacion);
            request.setAttribute("sueldoFinal", sueldoFinal);
            request.setAttribute("aplicaBonificacion", cantidad > 700);

            request.getRequestDispatcher("resultado3.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "La cantidad debe ser un número válido");
            request.getRequestDispatcher("casuistica3.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Error en la base de datos: " + e.getMessage());
            request.getRequestDispatcher("casuistica3.jsp").forward(request, response);
        }
    }

    private double obtenerTarifaPrenda(String tipoPrenda) throws SQLException {
        String sql = "SELECT tarifa FROM tarifas_prendas WHERE tipo_prenda = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, tipoPrenda);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("tarifa");
                } else {
                    throw new SQLException("No se encontró tarifa para el tipo de prenda especificado");
                }
            }
        }
    }

    private double obtenerBonificacionCategoria(String categoria) throws SQLException {
        String sql = "SELECT bonificacion FROM bonificaciones_categoria WHERE categoria = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, categoria);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("bonificacion");
                } else {
                    throw new SQLException("No se encontró bonificación para la categoría especificada");
                }
            }
        }
    }

    private void guardarCalculoObrero(String tipoPrenda, int cantidad, String categoria,
                                      double sueldoBase, double bonificacion, double sueldoFinal) throws SQLException {
        String sql = "INSERT INTO calculos_obrero (tipo_prenda, cantidad_prendas, categoria, " +
                "sueldo_base, bonificacion, sueldo_final) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, tipoPrenda);
            stmt.setInt(2, cantidad);
            stmt.setString(3, categoria);
            stmt.setDouble(4, sueldoBase);
            stmt.setDouble(5, bonificacion);
            stmt.setDouble(6, sueldoFinal);

            stmt.executeUpdate();
        }
    }
}