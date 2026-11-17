UPDATE PENGGUNA
SET role = JSON_SET(
    role,
    '$.role_utama',
    'superadmin'
)
WHERE email = 'andi.tahap3@example.com';

SELECT
    nama,
    JSON_UNQUOTE(JSON_EXTRACT(role, '$.role_utama')) AS role_utama
FROM PENGGUNA
WHERE email = 'andi.tahap3@example.com';