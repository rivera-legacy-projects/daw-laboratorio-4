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

@WebServlet("/casuistica2")
public class Casuistica2Servlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String estadoCivil = request.getParameter("estadoCivil");
        String numHijosStr = request.getParameter("numHijos");

        try {
            int numHijos = Integer.parseInt(numHijosStr);

            // Sueldo base fijo (puedes cambiarlo si es necesario)
            double sueldoBase = 1000.00;

            // Obtener porcentaje de bonificación por estado civil
            int porcentajeBonificacion = obtenerPorcentajeBonificacion(estadoCivil);

            // Calcular bonificación por estado civil
            double bonificacionEstado = sueldoBase * porcentajeBonificacion / 100.0;

            // Calcular bonificación por hijos (1.5% por hijo, máximo 6%)
            double porcentajeHijos = Math.min(numHijos * 1.5, 6.0);
            double bonificacionHijos = sueldoBase * porcentajeHijos / 100.0;

            // Calcular bonificación total y sueldo neto
            double bonificacionTotal = bonificacionEstado + bonificacionHijos;
            double sueldoNeto = sueldoBase + bonificacionTotal;

            // Guardar el cálculo en la base de datos
            guardarCalculoTrabajador(estadoCivil, numHijos, sueldoBase,
                    bonificacionEstado, bonificacionHijos,
                    bonificacionTotal, sueldoNeto);

            // Enviar resultados al JSP
            request.setAttribute("estadoCivil", estadoCivil);
            request.setAttribute("numHijos", numHijos);
            request.setAttribute("sueldoBase", sueldoBase);
            request.setAttribute("porcentajeBonificacion", porcentajeBonificacion);
            request.setAttribute("bonificacionEstado", bonificacionEstado);
            request.setAttribute("porcentajeHijos", porcentajeHijos);
            request.setAttribute("bonificacionHijos", bonificacionHijos);
            request.setAttribute("bonificacionTotal", bonificacionTotal);
            request.setAttribute("sueldoNeto", sueldoNeto);

            request.getRequestDispatcher("resultado2.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "El número de hijos debe ser un número válido");
            request.getRequestDispatcher("casuistica2.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Error en la base de datos: " + e.getMessage());
            request.getRequestDispatcher("casuistica2.jsp").forward(request, response);
        }
    }

    private int obtenerPorcentajeBonificacion(String estadoCivil) throws SQLException {
        String sql = "SELECT porcentaje_bonificacion FROM bonificaciones_estado_civil WHERE estado_civil = ?";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, estadoCivil);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("porcentaje_bonificacion");
                } else {
                    throw new SQLException("No se encontró bonificación para el estado civil especificado");
                }
            }
        }
    }

    private void guardarCalculoTrabajador(String estadoCivil, int numHijos, double sueldoBase,
                                          double bonificacionEstado, double bonificacionHijos,
                                          double bonificacionTotal, double sueldoNeto) throws SQLException {
        String sql = "INSERT INTO calculos_trabajador (estado_civil, num_hijos, sueldo_base, " +
                "bonificacion_estado, bonificacion_hijos, bonificacion_total, sueldo_neto) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, estadoCivil);
            stmt.setInt(2, numHijos);
            stmt.setDouble(3, sueldoBase);
            stmt.setDouble(4, bonificacionEstado);
            stmt.setDouble(5, bonificacionHijos);
            stmt.setDouble(6, bonificacionTotal);
            stmt.setDouble(7, sueldoNeto);

            stmt.executeUpdate();
        }
    }
}