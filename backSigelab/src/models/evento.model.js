const pool = require('../config/db');

const Evento = {
  crear: async ({ titulo, descripcion, fecha, ubicacion, mapa}) => {
    const query = `
      INSERT INTO eventos (titulo, descripcion, fecha, ubicacion, mapa)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *;
    `;
    const valores = [titulo, descripcion, fecha, ubicacion, mapa];
    const resultado = await pool.query(query, valores);
    return resultado.rows[0];
  },

  listar: async () => {
    const resultado = await pool.query('SELECT * FROM eventos ORDER BY fecha DESC');
    return resultado.rows;
  },

  obtenerPorId: async (id) => {
    const resultado = await pool.query('SELECT * FROM eventos WHERE id = $1', [id]);
    return resultado.rows[0];
  }
};

module.exports = Evento;