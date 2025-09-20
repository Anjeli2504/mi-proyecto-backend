const autorizarRoles = require('../middlewares/roles.middleware');
router.get('/admin/reporte', verificarToken, autorizarRoles('ADMIN'), controladorReporte);