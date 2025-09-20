const router = require('express').Router();
const verificarToken = require('../middlewares/auth.middleware');
const { actualizarPerfil } = require('../controllers/user.controller');

router.put('/perfil', verificarToken, actualizarPerfil);
module.exports = router;