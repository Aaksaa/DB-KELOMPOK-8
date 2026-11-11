
USE db_keuangan;

START TRANSACTION;

-- Membuat transaksi penjualan
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
    'Penjualan 2 Buku Tulis kepada Andi',
    'valid',
    1,
    10000.00,
    'penjualan'
);

-- Menambahkan detail penjualan
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
    2,
    5000.00,
    0.00,
    10000.00
);

-- Menyimpan transaksi secara permanen
COMMIT;

-- Memeriksa hasil transaksi
SELECT * FROM TRANSAKSI;

SELECT * FROM DETAIL_PENJUALAN;
