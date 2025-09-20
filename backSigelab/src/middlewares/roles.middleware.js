function autorizarRoles(...rolesPermitidos) {
  return (req, res, next) => {
    const { rol } = req.usuario;
    if (!rolesPermitidos.includes(rol)) {
      return res.status(403).json({ mensaje: 'Acceso denegado para este rol' });
    }
    next();
  };
}

module.exports = autorizarRoles;