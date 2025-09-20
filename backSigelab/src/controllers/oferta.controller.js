const pool = require('../config/db');


async function aplicarOferta(req, res) {
  try {
    if (!req.file) {
      return res.status(400).json({ mensaje: 'Debes adjuntar un archivo PDF' });
    }

    const usuario_id = req.usuario.id;
    const oferta_id = parseInt(req.body.oferta_id, 10);
    const cv_url = `/uploads/cv/${req.file.filename}`;


    const yaExiste = await pool.query(
      'SELECT 1 FROM ofertas_aplicadas WHERE usuario_id = $1 AND oferta_id = $2',
      [usuario_id, oferta_id]
    );

    if (yaExiste.rows.length > 0) {
      return res.status(400).json({ mensaje: 'Ya has aplicado a esta oferta.' });
    }

    await pool.query(`
      INSERT INTO ofertas_aplicadas (usuario_id, oferta_id, cv_url)
      VALUES ($1, $2, $3)
    `, [usuario_id, oferta_id, cv_url]);

    res.status(201).json({ mensaje: 'Aplicación registrada' });
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al aplicar', error: error.message });
  }
}


async function obtenerMisOfertas(req, res) {
  try {
    const usuario_id = req.usuario.id;
    const rol = req.usuario.rol;

    if (rol === 'USUARIO') {
      const result = await pool.query(`
        SELECT o.*, a.cv_url
        FROM ofertas_aplicadas a
        JOIN ofertas o ON a.oferta_id = o.id
        WHERE a.usuario_id = $1
        ORDER BY o.created_at DESC
      `, [usuario_id]);

      res.json(result.rows);
    } else if (rol === 'EMPRESA') {
      const result = await pool.query(`
        SELECT * FROM ofertas
        WHERE creado_por = $1
        ORDER BY created_at DESC
      `, [usuario_id]);

      res.json(result.rows);
    } else {
      res.status(403).json({ mensaje: 'Rol no autorizado' });
    }
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al obtener tus ofertas', error: error.message });
  }
}


async function obtenerOfertaPorId(req, res) {
  try {
    const { id } = req.params;
    const usuario_id = req.usuario?.id || null;

    const ofertaResult = await pool.query('SELECT * FROM ofertas WHERE id = $1', [id]);
    if (ofertaResult.rows.length === 0) {
      return res.status(404).json({ mensaje: 'Oferta no encontrada' });
    }

    let yaAplicado = false;

    if (usuario_id) {
      const aplicadoResult = await pool.query(
        'SELECT 1 FROM ofertas_aplicadas WHERE usuario_id = $1 AND oferta_id = $2',
        [usuario_id, id]
      );
      yaAplicado = aplicadoResult.rows.length > 0;
    }

    res.json({ ...ofertaResult.rows[0], yaAplicado });
  } catch (error) {
    console.error('Error al buscar oferta:', error);
    res.status(500).json({ mensaje: 'Error interno del servidor' });
  }
}

async function obtenerOfertasDeEmpresa(req, res) {
  try {
    const empresa_id = req.usuario.id;

    const result = await pool.query(
      `SELECT * FROM ofertas WHERE creado_por = $1 ORDER BY created_at DESC`,
      [empresa_id]
    );

    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al obtener ofertas de la empresa', error: error.message });
  }
}

async function obtenerAplicantesPorOferta(req, res) {
  try {
    const ofertaId = parseInt(req.params.id, 10);
    const empresaId = req.usuario.id;

    // Verifica que la oferta haya sido creada por esta empresa
    console.log('Empresa:', empresaId, 'Oferta:', ofertaId);
    const oferta = await pool.query(
      'SELECT * FROM ofertas WHERE id = $1 AND creado_por = $2',
      [ofertaId, empresaId]
    );

    if (oferta.rows.length === 0) {
      return res.status(403).json({ mensaje: 'No tienes permisos sobre esta oferta' });
    }

    const resultado = await pool.query(`
      SELECT u.id, u.nombre, u.email, u.discapacidad, a.cv_url, a.applied_at
      FROM ofertas_aplicadas a
      JOIN users u ON a.usuario_id = u.id
      WHERE a.oferta_id = $1
      ORDER BY a.applied_at DESC
    `, [ofertaId]);

    res.json(resultado.rows);
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al obtener aplicantes', error: error.message });
  }
}


module.exports = {
obtenerMisOfertas,
aplicarOferta,
obtenerOfertaPorId,
obtenerAplicantesPorOferta,
obtenerOfertasDeEmpresa
};
