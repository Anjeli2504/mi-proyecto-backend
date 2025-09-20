const express = require('express');
const router = express.Router();
const { confirmarAsistencia, listarMisAsistencias } = require('../controllers/asistencia.controller');
const verificarToken = require('../middlewares/auth.middleware');

router.post('/:id', verificarToken, confirmarAsistencia);
router.get('/mis-ferias', verificarToken, listarMisAsistencias);

module.exports = router;