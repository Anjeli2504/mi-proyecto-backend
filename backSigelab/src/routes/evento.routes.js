const express = require('express');
const router = express.Router();
const { crearEvento, listarEventos, obtenerMisFerias, aplicarAFeria } = require('../controllers/evento.controller');
const verificarToken = require('../middlewares/auth.middleware');

router.get('/', listarEventos);
router.post('/', verificarToken, (req, res, next) => {
  if (req.usuario.rol !== 'ADMIN') {
    return res.status(403).json({ mensaje: 'Acceso restringido a administradores' });
  }
  next();
}, crearEvento);

router.post('/aplicar/:id', verificarToken, aplicarAFeria);



module.exports = router;