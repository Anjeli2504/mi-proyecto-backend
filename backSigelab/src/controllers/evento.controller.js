const Evento = require('../models/evento.model');

async function crearEvento(req, res) {
  try {
    const nuevo = await Evento.crear(req.body);
    res.status(201).json(nuevo);
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al crear evento', error: error.message });
  }

}

  async function listarEventos(req, res) {
  try {
    const eventos = await Evento.listar();
    res.json(eventos);
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al listar eventos', error: error.message });
  }
}

async function aplicarAFeria(req, res) {
  try {
    const usuario_id = req.usuario.id;
    const evento_id = parseInt(req.params.id, 10);
    const formulario = req.body.formulario;
    const cedula = parseInt(formulario?.cedula, 10);


    if (!formulario || typeof formulario !== 'object' || !cedula) {
      return res.status(400).json({ mensaje: 'Formulario inválido o cédula faltante' });
    }

    // Validar si ya se registró
    const existe = await pool.query(
      'SELECT 1 FROM ferias_aplicadas WHERE users_id = $1 AND eventos_id = $2',
      [usuario_id, evento_id]
    );

    if (existe.rows.length > 0) {
      return res.status(409).json({ mensaje: 'Ya estás registrado a esta feria' });
    }

    await pool.query(
      `INSERT INTO ferias_aplicadas (users_id, eventos_id, formulario, cedula)
       VALUES ($1, $2, $3, $4)`,
      [usuario_id, evento_id, formulario, cedula]
    );

    res.status(201).json({ mensaje: 'Registro exitoso' });
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al registrar', error: error.message });
  }
}


module.exports = {
  crearEvento,
  listarEventos,
  aplicarAFeria
};
