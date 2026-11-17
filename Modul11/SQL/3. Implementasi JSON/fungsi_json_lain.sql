
-- Membuat objek JSON dengan dua atribut.
SELECT JSON_OBJECT(
    'role_utama', 'admin',
    'status', 'aktif'
);

-- Membuat array JSON yang berisi tiga nilai.
SELECT JSON_ARRAY(
    'manajemen',
    'laporan',
    'penjualan'
);

-- Memeriksa apakah kolom role berisi JSON yang valid.
SELECT
    nama,
    JSON_VALID(role) AS valid_json
FROM PENGGUNA;  

-- Menghitung jumlah atribut pada objek JSON setiap pengguna.
SELECT
    nama,
    JSON_LENGTH(role) AS jumlah_atribut
FROM PENGGUNA;

-- Mencari pengguna yang memiliki role_utama bernilai admin.
SELECT
    nama,
    role
FROM PENGGUNA
WHERE JSON_CONTAINS(
    role,
    '"admin"',
    '$.role_utama'
);