const bcrypt = require('bcryptjs');

bcrypt.hash("admin123", 4).then(hash => {
  console.log("Hash generado:", hash);
});
