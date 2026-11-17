SELECT
    nama,
    JSON_UNQUOTE(JSON_EXTRACT(role, '$.role_utama')) AS role_utama,
    JSON_EXTRACT(role, '$.role_tambahan') AS role_tambahan
FROM PENGGUNA
WHERE email IN (
    'andi.tahap3@example.com',
    'budi.tahap3@example.com',
    'citra.tahap3@example.com'
)
ORDER BY id_pengguna;