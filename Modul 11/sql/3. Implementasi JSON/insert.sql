USE praktikum_modul11;

INSERT INTO PENGGUNA
    (nama, tanggal_lahir, email, status_aktif, role)
SELECT
    'Andi',
    '2003-02-15',
    'andi.tahap3@example.com',
    TRUE,
    JSON_OBJECT(
        'role_utama', 'admin',
        'role_tambahan', JSON_ARRAY('manajemen', 'laporan')
    )
WHERE NOT EXISTS (
    SELECT 1
    FROM PENGGUNA
    WHERE email = 'andi.tahap3@example.com'
);

INSERT INTO PENGGUNA
    (nama, tanggal_lahir, email, status_aktif, role)
SELECT
    'Budi',
    '2003-05-20',
    'budi.tahap3@example.com',
    TRUE,
    JSON_OBJECT(
        'role_utama', 'kasir',
        'role_tambahan', JSON_ARRAY('penjualan', 'pembayaran')
    )
WHERE NOT EXISTS (
    SELECT 1
    FROM PENGGUNA
    WHERE email = 'budi.tahap3@example.com'
);

INSERT INTO PENGGUNA
    (nama, tanggal_lahir, email, status_aktif, role)
SELECT
    'Citra',
    '2003-08-10',
    'citra.tahap3@example.com',
    TRUE,
    JSON_OBJECT(
        'role_utama', 'gudang',
        'role_tambahan', JSON_ARRAY('stok', 'pembelian')
    )
WHERE NOT EXISTS (
    SELECT 1
    FROM PENGGUNA
    WHERE email = 'citra.tahap3@example.com'
);