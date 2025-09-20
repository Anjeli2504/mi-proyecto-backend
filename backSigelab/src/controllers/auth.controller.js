const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const Usuario = require('../models/user.model');
const { enviarBienvenida } = require('../untils/mailer');

// Registro
async function registrarUsuario(req, res) {
  try {
    const {
      nombre,
      email,
      password,
      rol: rolOriginal,
      role,
      discapacidad // ✅ nuevo campo
    } = req.body;

    const rol = (rolOriginal || role || '').toUpperCase();

    const rolesPermitidos = ['USUARIO', 'ADMIN', 'EMPRESA'];
    if (!rolesPermitidos.includes(rol)) {
      return res.status(400).json({ mensaje: 'Rol no permitido' });
    }

    if (!email || !password || !rol) {
      return res.status(400).json({ mensaje: 'Email, contraseña y rol son obligatorios' });
    }

    const existe = await Usuario.buscarPorEmail(email);
    if (existe) {
      return res.status(409).json({ mensaje: 'El correo ya está registrado' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    // ✅ Crear usuario
    const nuevoUsuario = await Usuario.crear(
      nombre || '',
      email,
      hashedPassword,
      rol,
      discapacidad || null
    );

    // ✅ Enviar correo de bienvenida, sin bloquear el flujo si falla
    try {
      await enviarBienvenida(email, nombre);
    } catch (correoError) {
      console.error('Error al enviar correo de bienvenida:', correoError.message);
    }

    return res.status(201).json({
      mensaje: 'Usuario registrado correctamente',
      usuario: {
        id: nuevoUsuario.id,
        email: nuevoUsuario.email,
        rol: nuevoUsuario.rol,
        nombre: nuevoUsuario.nombre,
        discapacidad: nuevoUsuario.discapacidad || null
      }
    });

  } catch (error) {
    return res.status(500).json({
      mensaje: 'Error al registrar usuario',
      error: error.message
    });
  }
}

// Login
async function iniciarSesion(req, res) {
  try {
    const { email, password } = req.body;
    const usuario = await Usuario.buscarPorEmail(email);

    if (!usuario || !(await bcrypt.compare(password, usuario.password))) {
      return res.status(401).json({ mensaje: 'Correo o contraseña incorrectos' });
    }

    const token = jwt.sign(
      { id: usuario.id, email: usuario.email, rol: usuario.rol },
      process.env.JWT_SECRET,
      { expiresIn: '8h' }
    );

    return res.json({
    token,
    email: usuario.email,
    nombre: usuario.nombre,
    rol: usuario.rol,
    discapacidad: usuario.discapacidad || null,
    created_at: usuario.created_at // ✅
  });
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Error en el login',
      error: error.message
    });
  }
}

module.exports = {
  registrarUsuario,
  iniciarSesion
};
