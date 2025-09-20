const nodemailer = require('nodemailer');
require('dotenv').config();

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS
  }
});

function enviarBienvenida(destinatario, nombre) {
  const mailOptions = {
    from: `"SIGELAB" <${process.env.EMAIL_USER}>`,
    to: destinatario,
    subject: 'Bienvenido a SIGELAB',
    html: `<h3>Hola ${nombre},</h3><p>¡Gracias por registrarte en SIGELAB!
Nos alegra mucho que te hayas registrado en nuestra página. Esperamos que disfrutes de todos los contenidos y servicios que ofrecemos.

Si tienes alguna duda o necesitas ayuda, no dudes en contactarnos respondiendo a este correo.

¡Bienvenido/a y esperamos que disfrutes tu experiencia con nosotros!

Saludos cordiales,
El equipo de SIGELAB</p>`
  };

  return transporter.sendMail(mailOptions);
}

module.exports = { enviarBienvenida };
