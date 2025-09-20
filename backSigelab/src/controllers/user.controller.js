const pool = require('../config/db');

async function actualizarPerfil(req, res) {
  try {
    const { nombre, email } = req.body;
    const id = req.usuario.id;
    const query = 'UPDATE users SET nombre=$1, email=$2 WHERE id=$3 RETURNING id, nombre, email, rol';
    const result = await pool.query(query, [nombre, email, id]);
    res.json({ mensaje: 'Perfil actualizado', usuario: result.rows[0] });
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al actualizar perfil', error: error.message });
  }
}

module.exports = { actualizarPerfil };