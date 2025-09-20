const express = require('express');
const router = express.Router();
const Oferta = require('../models/oferta.model');
const verificarToken = require('../middlewares/auth.middleware');
const autorizarRoles = require('../middlewares/roles.middleware');
const { obtenerMisOfertas } = require('../controllers/oferta.controller');
const upload = require('../middlewares/upload.middleware');
const { aplicarOferta } = require('../controllers/oferta.controller');
const controladorOferta = require('../controllers/oferta.controller');
const { obtenerAplicantesPorOferta } = require('../controllers/oferta.controller');

// GET: Listar todas las ofertas (público o autenticado)
router.get('/', async (req, res) => {
  try {
    const ofertas = await Oferta.obtenerTodas();
    res.json(ofertas);
  } catch (error) {
    res.status(500).json({ mensaje: 'Error al obtener ofertas', error: error.message });
  }
});

router.get('/mis-aplicadas', verificarToken, controladorOferta.obtenerMisOfertas);

router.get(
  '/empresa/mis-ofertas',
  verificarToken,
  autorizarRoles('EMPRESA'),
  controladorOferta.obtenerOfertasDeEmpresa
);
router.get('/:id', controladorOferta.obtenerOfertaPorId);

router.get('/:id/aplicaciones', verificarToken, autorizarRoles('EMPRESA'), obtenerAplicantesPorOferta);

// POST: Crear oferta (solo para ADMIN)
router.post(
  '/empresa',
  verificarToken,
  autorizarRoles('EMPRESA'),
  async (req, res) => {
    try {
      const { puesto, empresa, requerimientos } = req.body;
      const creado_por = req.usuario.id; // ⚠️ el id viene desde el token

      console.log('Datos recibidos:', { puesto, empresa, requerimientos });
      console.log('Usuario ID (creado_por):', req.usuario?.id);
      if (!puesto || !empresa || !requerimientos) {
        return res.status(400).json({ mensaje: 'Faltan campos obligatorios' });
      }

      const nueva = await Oferta.crear(puesto, empresa, requerimientos, creado_por);
      res.status(201).json(nueva);
    } catch (error) {
      res.status(500).json({ mensaje: 'Error al crear oferta', error: error.message });
    }
  }
);

// Aplicar a oferta (USUARIO)
router.post(
  '/aplicar',
  verificarToken,
  autorizarRoles('USUARIO'),
  upload.single('cv'),
  aplicarOferta
);
module.exports = router;

