use praktikum_modul10;
-- 0.1 Perbarui statistik tabel (wajib setelah insert data besar)
ANALYZE TABLE PENGGUNA, PELANGGAN, PEMASOK, PRODUK, KAS_REKENING,
              TRANSAKSI, BUKTI_TRANSAKSI, PEMBAYARAN,
              DETAIL_PENJUALAN, DETAIL_PEMBELIAN;

-- 0.2 Cek jumlah data & rentang tanggal (untuk menentukan filter)
SELECT COUNT(*) AS jml_transaksi,
       MIN(tanggal_transaksi) AS tgl_awal,
       MAX(tanggal_transaksi) AS tgl_akhir
FROM TRANSAKSI;

SELECT jenis_transaksi, COUNT(*) AS jml FROM TRANSAKSI GROUP BY jenis_transaksi;
SELECT status_validasi, COUNT(*) AS jml FROM TRANSAKSI GROUP BY status_validasi;

-- 0.3 Index yang SUDAH ada (PK + otomatis dari FOREIGN KEY di InnoDB)
SHOW INDEX FROM TRANSAKSI;
SHOW INDEX FROM DETAIL_PENJUALAN;
SHOW INDEX FROM BUKTI_TRANSAKSI;
SHOW INDEX FROM PEMBAYARAN;
SHOW INDEX FROM PELANGGAN;
-- Catatan: kolom FK (id_pengguna, id_produk, id_pelanggan, id_kas, dst.)
-- sudah otomatis ber-index. Index tambahan hanya perlu untuk kolom yang
-- sering dipakai di WHERE/ORDER BY/GROUP BY tetapi BUKAN FK.


-- =====================================================================
-- SKENARIO 1: Pencarian transaksi berdasarkan RENTANG TANGGAL
-- Kolom target: TRANSAKSI.tanggal_transaksi
-- =====================================================================
-- 1.a SEBELUM index
EXPLAIN
SELECT id_transaksi, tanggal_transaksi, jenis_transaksi, status_validasi, total_nilai
FROM TRANSAKSI
WHERE tanggal_transaksi >= '2023-01-01'
  AND tanggal_transaksi <  '2026-02-01';

-- (opsional, MySQL 8.0.18+) waktu eksekusi nyata
EXPLAIN ANALYZE
SELECT id_transaksi, tanggal_transaksi, jenis_transaksi, status_validasi, total_nilai
FROM TRANSAKSI
WHERE tanggal_transaksi >= '2023-01-01'
  AND tanggal_transaksi <  '2026-02-01';

-- 1.b BUAT index
CREATE INDEX idx_transaksi_tanggal ON TRANSAKSI (tanggal_transaksi);
SHOW INDEX FROM TRANSAKSI;

-- 1.c SESUDAH index (query sama persis)
EXPLAIN
SELECT id_transaksi, tanggal_transaksi, jenis_transaksi, status_validasi, total_nilai
FROM TRANSAKSI
WHERE tanggal_transaksi >= '2026-01-01'
  AND tanggal_transaksi <  '2026-02-01';

EXPLAIN ANALYZE
SELECT id_transaksi, tanggal_transaksi, jenis_transaksi, status_validasi, total_nilai
FROM TRANSAKSI
WHERE tanggal_transaksi >= '2026-01-01'
  AND tanggal_transaksi <  '2026-02-01';
