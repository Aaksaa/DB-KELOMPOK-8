
USE db_keuangan;

START TRANSACTION;

-- Membuat transaksi penjualan sementara
INSERT INTO TRANSAKSI
(
    tanggal_transaksi,
    waktu_transaksi,
    keterangan,
    status_validasi,
    id_pengguna,
    total_nilai,
    jenis_transaksi
)
VALUES
(
    CURDATE(),
    CURTIME(),
    'Uji ROLLBACK penjualan 3 Buku Tulis',
    'valid',
    1,
    15000.00,
    'penjualan'
);

-- Menambahkan detail penjualan sementara
INSERT INTO DETAIL_PENJUALAN
(
    id_transaksi,
    no_item,
    id_produk,
    id_pelanggan,
    jumlah,
    harga_satuan_actual,
    diskon_item,
    subtotal
)
VALUES
(
    LAST_INSERT_ID(),
    1,
    1,
    1,
    3,
    5000.00,
    0.00,
    15000.00
);

-- Membatalkan seluruh perubahan
ROLLBACK;

-- Memeriksa hasil setelah ROLLBACK
SELECT * FROM TRANSAKSI;

SELECT * FROM DETAIL_PENJUALAN;
