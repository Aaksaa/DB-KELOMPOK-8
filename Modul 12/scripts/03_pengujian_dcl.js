// 1. Buat akun / role report_user (Dijalankan oleh Administrator, jalankan di database 'admin' dengan sintax 'use admin')
db.createUser({
  user: "report_user",
  pwd: "pass",
  roles: [
    { role: "read", db: "praktikum_modul12" },  // 2. Hak akses: artinya hanya bisa membaca data pada database 'praktikum_modul12'
  ],
});

// 3. Inspeksi hak akses (Setara dengan SHOW GRANTS pada MySQL/MariaDB)
db.getUser("report_user");

// 4. REVOKE hak baca (Mencabut hak akses)
// Di MongoDB, kita mengupdate user untuk mengubah atau mengosongkan role-nya
db.updateUser("report_user", {
  roles: [] // Mengosongkan array roles berarti mencabut semua hak akses
});