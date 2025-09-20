const pool = require('../config/db');

const Usuario = {
  crear: async (nombre, email, hashedPassword, rol, discapacidad) => {
    const query = `
  INSERT INTO users (nombre, email, password, rol, discapacidad)
  VALUES ($1, $2, $3, $4, $5)
  RETURNING id, nombre, email, rol, discapacidad, created_at
  `;
    const valores = [nombre, email, hashedPassword, rol, discapacidad];
    const resultado = await pool.query(query, valores);
    return resultado.rows[0];
  },

  buscarPorEmail: async (email) => {
    const query = `SELECT * FROM users WHERE email = $1`;
    const resultado = await pool.query(query, [email]);
    return resultado.rows[0];
  }
};

module.exports = Usuario;
