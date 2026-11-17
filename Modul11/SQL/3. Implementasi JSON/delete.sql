UPDATE PENGGUNA
SET role = JSON_REMOVE(
    role,
    '$.role_tambahan[1]'
)
WHERE email = 'budi.tahap3@example.com';

SELECT
    nama,
    JSON_EXTRACT(role, '$.role_tambahan') AS role_tambahan
FROM PENGGUNA
WHERE email = 'budi.tahap3@example.com';