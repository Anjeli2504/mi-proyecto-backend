const pool = require('../config/db');

const Oferta = {
  crear: async (puesto, empresa, requerimientos, creado_por) => {

      if (!creado_por || isNaN(creado_por)) {
    return res.status(400).json({ mensaje: 'ID del creador inválido' });
  }
    const query = `
      INSERT INTO ofertas (puesto, empresa, requerimientos, creado_por)
      VALUES ($1, $2, $3, $4)
      RETURNING *;
    `;
    const result = await pool.query(query, [puesto, empresa, requerimientos, creado_por]);
    return result.rows[0];
  },

  obtenerTodas: async () => {
    const result = await pool.query('SELECT * FROM ofertas ORDER BY created_at DESC');
    return result.rows;
  }
};

module.exports = Oferta;