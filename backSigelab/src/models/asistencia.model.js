const pool = require('../config/db');

const Asistencia = {
  registrar: async ({ usuario_id, evento_id, formulario, cedula }) => {
    const query = `
      INSERT INTO ferias_aplicadas (users_id, eventos_id, formulario, cedula)
      VALUES ($1, $2, $3, $4)
      RETURNING *;
    `;
    const valores = [usuario_id, evento_id, formulario, cedula];
    const resultado = await pool.query(query, valores);
    return resultado.rows[0];
  },

  obtenerPorUsuario: async (usuario_id) => {
    const resultado = await pool.query(`
      SELECT f.*, e.titulo, e.fecha
      FROM ferias_aplicadas f
      JOIN eventos e ON f.eventos_id = e.id
      WHERE f.users_id = $1
      ORDER BY e.fecha DESC
    `, [usuario_id]);
    
    return resultado.rows;
  }
};

module.exports = Asistencia;
