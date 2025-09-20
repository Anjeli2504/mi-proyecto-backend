require('dotenv').config();
const express = require('express');
const cors = require('cors');
const fs = require('fs');
const path = require('path');


const app = express();
app.use(express.json());
app.use(cors());

app.use('/uploads', express.static('uploads'));

app.get('/', (req, res) => {
  res.send('Servidor funcionando 🚀');
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});

const authRoutes = require('./src/routes/auth.routes');
const verificarToken = require('./src/middlewares/auth.middleware');

app.use('/api/auth', authRoutes);

const asistenciaRoutes = require('./src/routes/asistencia.routes');
app.use('/api/asistencias', asistenciaRoutes);

const eventoRoutes = require('./src/routes/evento.routes');
app.use('/api/eventos', eventoRoutes);

const ofertaRoutes = require('./src/routes/oferta.routes');
app.use('/api/ofertas', ofertaRoutes);


// Crear carpeta uploads/cv si no existe
const uploadsPath = path.join(__dirname, 'uploads', 'cv');
if (!fs.existsSync(uploadsPath)) {
  fs.mkdirSync(uploadsPath, { recursive: true });
}


// Ejemplo de ruta protegida
app.get('/api/protegido', verificarToken, (req, res) => {
  res.json({ mensaje: 'Ruta protegida', usuario: req.usuario });
});