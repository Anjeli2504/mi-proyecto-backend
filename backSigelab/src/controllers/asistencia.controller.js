const Asistencia = require('../models/asistencia.model');

async function confirmarAsistencia(req, res) {
  try {
    const usuario_id = req.usuario.id;
    const evento_id = parseInt(req.params.id, 10);
    const formulario = req.body.formulario || {};
    const cedula = req.body.cedula;

    const asistencia = await Asistencia.registrar({
      usuario_id,
      evento_id,
      formulario,
      cedula
    });

    res.status(201).json(asistencia);
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al registrar asistencia', error: error.message });
  }
}


async function listarMisAsistencias(req, res) {
  try {
    const usuario_id = req.usuario.id;
    const asistencias = await Asistencia.obtenerPorUsuario(usuario_id);
    res.json(asistencias);
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al listar asistencias', error: error.message });
  }
}

module.exports = {
  confirmarAsistencia,
  listarMisAsistencias
};
