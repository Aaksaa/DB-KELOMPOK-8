UPDATE PENGGUNA
SET role = JSON_INSERT(
    role,
    '$.hak_akses_baru',
    'ekspor_laporan'
)
WHERE email = 'andi.tahap3@example.com';

SELECT
    nama,
    role
FROM PENGGUNA
WHERE email = 'andi.tahap3@example.com';