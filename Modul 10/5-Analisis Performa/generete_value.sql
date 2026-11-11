-- =====================================================================
-- DATA DUMMY db_keuangan  (MySQL 8 / MariaDB 10.x, SQL murni)
-- Jalankan SETELAH db_keuangan.sql, pada database yang masih kosong.
--
-- Jumlah baris:
--   PENGGUNA 10.000 | PELANGGAN 20.000 | PEMASOK 10.000 | PRODUK 10.000
--   KAS_REKENING 10.000 | LAPORAN_KEUANGAN 10.000
--   TRANSAKSI 2.000.000 (25% penjualan, 25% pembelian,
--                        25% pembayaran, 25% kas pemilik)
--   BUKTI_TRANSAKSI 2.000.000 | PEMBAYARAN 500.000
--   TRANSAKSI_KAS_PEMILIK 500.000
--   DETAIL_PENJUALAN 1.000.000 | DETAIL_PEMBELIAN 1.000.000
--
-- Semua nominal uang dibuat di rentang Rp10.000 s.d. Rp2.000.000.
-- Nilai dibuat dengan rumus MOD (deterministik), jadi hasilnya sama
-- setiap dijalankan dan semua foreign key dijamin valid.
-- =====================================================================
USE praktikum_modul10;
SET SQL_SAFE_UPDATES = 0;
SET autocommit = 0;
-- ---------------------------------------------------------------------
-- 0. Tabel bantu: deret angka 1..2.000.000 (tanpa bahasa lain, hanya cross join)
-- ---------------------------------------------------------------------
CREATE TABLE bantu_digit (d TINYINT NOT NULL PRIMARY KEY);
INSERT INTO bantu_digit (d) VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
CREATE TABLE bantu_seq (n INT NOT NULL PRIMARY KEY);
INSERT INTO bantu_seq (n)
SELECT 1 + a.d + b.d*10 + c.d*100 + e.d*1000 + f.d*10000 + g.d*100000 + h.d*1000000 AS nn
FROM bantu_digit a, bantu_digit b, bantu_digit c, bantu_digit e,
    bantu_digit f, bantu_digit g, bantu_digit h
WHERE h.d < 2
ORDER BY nn;
COMMIT;
-- ---------------------------------------------------------------------
-- 1. PENGGUNA (10.000)
-- ---------------------------------------------------------------------
INSERT INTO PENGGUNA
   (id_pengguna, nama, tanggal_lahir, email, status_aktif, alamat,
    nomor_telepon, role, jumlah_transaksi_dibuat)
SELECT
   n,
   CONCAT(
       ELT(1 + MOD(n, 20), 'Budi','Siti','Agus','Dewi','Rizky','Putri','Andi','Rina','Eko','Sari',
                           'Dimas','Ayu','Fajar','Nur','Hendra','Wulan','Bayu','Intan','Joko','Lestari'),
       ' ',
       ELT(1 + MOD(FLOOR(n/20), 20), 'Santoso','Wijaya','Pratama','Saputra','Hidayat','Kusuma','Nugroho',
                                     'Permana','Lubis','Siregar','Utami','Wibowo','Setiawan','Rahayu',
                                     'Gunawan','Halim','Maulana','Fitriani','Susanto','Purnama')),
   DATE_ADD('1970-01-01', INTERVAL MOD(n*37, 12000) DAY),
   CONCAT('user', n, '@mail.com'),
   MOD(n, 10) <> 0,
   CONCAT('Jl. ', ELT(1 + MOD(n, 8), 'Merdeka','Sudirman','Diponegoro','Ahmad Yani','Gatot Subroto',
                                     'Pahlawan','Melati','Kenanga'),
          ' No. ', 1 + MOD(n, 200),
          ', Kec. ', ELT(1 + MOD(n, 6), 'Menteng','Tebet','Coblong','Lowokwaru','Sukun','Klojen'),
          ', ', ELT(1 + MOD(n, 5), 'Jakarta','Bandung','Malang','Surabaya','Semarang'),
          ', ', ELT(1 + MOD(n, 5), 'DKI Jakarta','Jawa Barat','Jawa Timur','Jawa Timur','Jawa Tengah'),
          ', ', 10000 + MOD(n*7, 80000)),
   CONCAT('0812', LPAD(MOD(n*7919, 100000000), 8, '0'), ',',
          '0857', LPAD(MOD(n*104729, 100000000), 8, '0')),
   ELT(1 + MOD(n, 4), 'admin', 'kasir', 'pemilik', 'kasir,pemilik'),
   0
FROM bantu_seq
WHERE n <= 10000;
COMMIT;
-- ---------------------------------------------------------------------
-- 2. PELANGGAN (20.000)
-- ---------------------------------------------------------------------
INSERT INTO PELANGGAN (id_pelanggan, nama_pelanggan, kontak)
SELECT
   n,
   CONCAT(
       ELT(1 + MOD(n, 20), 'Ahmad','Lia','Tono','Maya','Yusuf','Citra','Hasan','Nia','Doni','Tika',
                           'Rudi','Mega','Ilham','Sinta','Galih','Vina','Teguh','Dian','Wahyu','Yuni'),
       ' ',
       ELT(1 + MOD(FLOOR(n/20), 25), 'Widodo','Anggraini','Firmansyah','Salim','Hakim','Amalia','Kurniawan',
                                     'Safitri','Ramadhan','Oktaviani','Syahputra','Handayani','Mahendra',
                                     'Puspita','Hartono','Lestari','Surya','Pangestu','Wardana','Kartika',
                                     'Sutrisno','Yulianti','Baskoro','Marlina','Darmawan')),
   CONCAT('0813', LPAD(MOD(n*15485863, 100000000), 8, '0'))
FROM bantu_seq
WHERE n <= 20000;
COMMIT;
-- ---------------------------------------------------------------------
-- 3. PEMASOK (10.000)
-- ---------------------------------------------------------------------
INSERT INTO PEMASOK (id_pemasok, nama_pemasok, kontak, email)
SELECT
   n,
   CONCAT(ELT(1 + MOD(n, 3), 'PT','CV','UD'), ' ',
          ELT(1 + MOD(FLOOR(n/3), 12), 'Maju Jaya','Sumber Rezeki','Berkah Abadi','Sinar Mas','Cahaya Baru',
                                       'Tani Makmur','Karya Mandiri','Bumi Pangan','Sentosa','Harapan',
                                       'Mitra Niaga','Global Tama'),
          ' ', n),
   CONCAT('0821', LPAD(MOD(n*32452843, 100000000), 8, '0')),
   CONCAT('cs', n, '@pemasok.co.id')
FROM bantu_seq
WHERE n <= 10000;
COMMIT;
-- ---------------------------------------------------------------------
-- 4. PRODUK (10.000)  harga baku Rp10.000 - Rp200.000
-- ---------------------------------------------------------------------
INSERT INTO PRODUK (id_produk, nama_produk, harga_satuan_baku)
SELECT
   n,
   CONCAT(ELT(1 + MOD(n, 10), 'Beras','Gula','Minyak Goreng','Tepung','Kopi','Teh','Susu','Mie','Sabun','Garam'),
          ' ',
          ELT(1 + MOD(FLOOR(n/10), 10), 'Premium','Ekonomis','Super','Organik','Kemasan Besar',
                                        'Kemasan Kecil','Spesial','Reguler','Pilihan','Lokal'),
          ' ', n),
   10000 + MOD(n*137, 191) * 1000
FROM bantu_seq
WHERE n <= 10000;
COMMIT;
-- ---------------------------------------------------------------------
-- 5. KAS_REKENING (10.000)  saldo_terkini diisi di bagian akhir
-- ---------------------------------------------------------------------
INSERT INTO KAS_REKENING (id_kas, nama_kas, jenis_kas, saldo_terkini)
SELECT
   n,
   CONCAT('Kas ', ELT(1 + MOD(n, 3), 'Tunai','Bank','E-Wallet'), ' ', n),
   ELT(1 + MOD(n, 3), 'Tunai','Bank','E-Wallet'),
   0
FROM bantu_seq
WHERE n <= 10000;
COMMIT;
-- ---------------------------------------------------------------------
-- 6. LAPORAN_KEUANGAN (10.000)
-- ---------------------------------------------------------------------
INSERT INTO LAPORAN_KEUANGAN (id_laporan, judul_laporan, periode, tanggal_cetak, id_pengguna)
SELECT
   n,
   CONCAT('Laporan ', ELT(1 + MOD(n, 5), 'Laba Rugi','Neraca','Arus Kas','Penjualan','Pembelian'),
          ' ', 2023 + MOD(n, 4), '-', LPAD(1 + MOD(n, 12), 2, '0')),
   CONCAT(2023 + MOD(n, 4), '-', LPAD(1 + MOD(n, 12), 2, '0')),
   DATE_ADD('2023-02-01', INTERVAL MOD(n*29, 1300) DAY),
   1 + MOD(n*7, 10000)
FROM bantu_seq
WHERE n <= 10000;
COMMIT;
-- 7. Tabel transaksi dan turunannya (tanpa stored procedure / DELIMITER,
--    supaya aman dijalankan di klien SQL mana pun)
--    Aturan jenis transaksi berdasarkan id_transaksi:
--      MOD(id,4)=1 PENJUALAN | =2 PEMBELIAN | =3 PEMBAYARAN | =0 KAS_PEMILIK
--    id_pengguna transaksi: 1 + MOD(id*7919, 10000)
-- ---------------------------------------------------------------------
-- TRANSAKSI
INSERT INTO TRANSAKSI
   (id_transaksi, tanggal_transaksi, waktu_transaksi, keterangan,
    status_validasi, id_pengguna, total_nilai, jenis_transaksi)
SELECT
   n,
   DATE_ADD('2023-01-01', INTERVAL MOD(n*31, 1400) DAY),
   SEC_TO_TIME(28800 + MOD(n*977, 43200)),
   CONCAT('Transaksi ke-', n),
   CASE WHEN MOD(n,10) < 7 THEN 'Valid'
        WHEN MOD(n,10) < 9 THEN 'Pending'
        ELSE 'Ditolak' END,
   1 + MOD(n*7919, 10000),
   0,
   CASE MOD(n,4) WHEN 1 THEN 'PENJUALAN'
                 WHEN 2 THEN 'PEMBELIAN'
                 WHEN 3 THEN 'PEMBAYARAN'
                 ELSE 'KAS_PEMILIK' END
FROM bantu_seq;
COMMIT;
-- BUKTI_TRANSAKSI (1 bukti per transaksi)
INSERT INTO BUKTI_TRANSAKSI
   (id_bukti, id_transaksi, nomor_bukti, tanggal_bukti, jenis_transaksi,
    keterangan, berkas_bukti, id_pelanggan, id_pemasok, id_pengguna)
SELECT
   n,
   n,
   CONCAT('BKT-', LPAD(n, 8, '0')),
   DATE_ADD('2023-01-01', INTERVAL MOD(n*31, 1400) DAY),
   CASE MOD(n,4) WHEN 1 THEN 'PENJUALAN'
                 WHEN 2 THEN 'PEMBELIAN'
                 WHEN 3 THEN 'PEMBAYARAN'
                 ELSE 'KAS_PEMILIK' END,
   CONCAT('Bukti untuk transaksi ', n),
   CONCAT('bukti_', n, '.pdf', IF(MOD(n,3)=0, CONCAT(',foto_', n, '.jpg'), '')),
   IF(MOD(n,4)=1, 1 + MOD(n*13, 20000), NULL),
   IF(MOD(n,4)=2, 1 + MOD(n*17, 10000), NULL),
   1 + MOD(n*7919, 10000)
FROM bantu_seq;
COMMIT;
-- DETAIL_PENJUALAN (2 item per transaksi penjualan)
INSERT INTO DETAIL_PENJUALAN
   (id_transaksi, no_item, id_produk, id_pelanggan, jumlah,
    harga_satuan_actual, diskon_item, subtotal)
SELECT
   s.n,
   it.i,
   p.id_produk,
   1 + MOD(s.n*13, 20000),
   1 + MOD(s.n*7 + it.i*3, 10),
   ROUND(p.harga_satuan_baku * (0.95 + MOD(s.n,11)/100), 2),
   ELT(1 + MOD(s.n,4), 0, 1000, 2500, 5000),
   NULL
FROM bantu_seq s
JOIN (SELECT 1 AS i UNION ALL SELECT 2) it
JOIN PRODUK p ON p.id_produk = 1 + MOD(s.n*31 + it.i*17, 10000)
WHERE MOD(s.n,4) = 1;
COMMIT;
UPDATE DETAIL_PENJUALAN
SET subtotal = jumlah * harga_satuan_actual - diskon_item;
COMMIT;
-- DETAIL_PEMBELIAN (2 item per transaksi pembelian)
INSERT INTO DETAIL_PEMBELIAN
   (id_transaksi, no_item, id_produk, id_pemasok, jumlah,
    harga_satuan_actual, diskon_item, subtotal)
SELECT
   s.n,
   it.i,
   p.id_produk,
   1 + MOD(s.n*17, 10000),
   1 + MOD(s.n*5 + it.i*3, 10),
   ROUND(p.harga_satuan_baku * (0.60 + MOD(s.n,11)/100), 2),
   ELT(1 + MOD(s.n,4), 0, 1000, 2500, 5000),
   NULL
FROM bantu_seq s
JOIN (SELECT 1 AS i UNION ALL SELECT 2) it
JOIN PRODUK p ON p.id_produk = 1 + MOD(s.n*29 + it.i*19, 10000)
WHERE MOD(s.n,4) = 2;
COMMIT;
UPDATE DETAIL_PEMBELIAN
SET subtotal = jumlah * harga_satuan_actual - diskon_item;
COMMIT;
-- PEMBAYARAN
INSERT INTO PEMBAYARAN
   (id_transaksi, arah_pembayaran, metode_bayar, jumlah_bayar, id_kas,
    referensi, status_verifikasi, sisa_alokasi)
SELECT
   n,
   IF(MOD(n,8) = 3, 'MASUK', 'KELUAR'),
   ELT(1 + MOD(n,5), 'Tunai','Transfer','QRIS','Debit','E-Wallet'),
   10000 + MOD(n*131, 1991) * 1000,
   1 + MOD(n*11, 10000),
   CONCAT('REF-', LPAD(n, 8, '0')),
   CASE WHEN MOD(FLOOR(n/4),10) < 7 THEN 'Terverifikasi'
        WHEN MOD(FLOOR(n/4),10) < 9 THEN 'Menunggu'
        ELSE 'Ditolak' END,
   IF(MOD(FLOOR(n/4),10) < 7, 0, 10000 + MOD(n*131, 1991) * 1000)
FROM bantu_seq
WHERE MOD(n,4) = 3;
COMMIT;
-- TRANSAKSI_KAS_PEMILIK
INSERT INTO TRANSAKSI_KAS_PEMILIK
   (id_transaksi, jenis_kas_pemilik, jumlah, keterangan_tambahan)
SELECT
   n,
   ELT(1 + MOD(FLOOR(n/4),4), 'Modal Awal','Setoran Modal','Prive','Penarikan'),
   10000 + MOD(n*131, 1991) * 1000,
   CONCAT('Catatan kas pemilik #', n)
FROM bantu_seq
WHERE MOD(n,4) = 0;
COMMIT;
-- ---------------------------------------------------------------------
-- 8. Atribut turunan (derived)
-- ---------------------------------------------------------------------
-- TRANSAKSI.total_nilai
UPDATE TRANSAKSI t
JOIN (SELECT id_transaksi, SUM(subtotal) AS s FROM DETAIL_PENJUALAN GROUP BY id_transaksi) d
 ON d.id_transaksi = t.id_transaksi
SET t.total_nilai = d.s;
COMMIT;
UPDATE TRANSAKSI t
JOIN (SELECT id_transaksi, SUM(subtotal) AS s FROM DETAIL_PEMBELIAN GROUP BY id_transaksi) d
 ON d.id_transaksi = t.id_transaksi
SET t.total_nilai = d.s;
COMMIT;
UPDATE TRANSAKSI t
JOIN PEMBAYARAN p ON p.id_transaksi = t.id_transaksi
SET t.total_nilai = p.jumlah_bayar;
COMMIT;
UPDATE TRANSAKSI t
JOIN TRANSAKSI_KAS_PEMILIK k ON k.id_transaksi = t.id_transaksi
SET t.total_nilai = k.jumlah;
COMMIT;
-- PENGGUNA.jumlah_transaksi_dibuat
UPDATE PENGGUNA u
JOIN (SELECT id_pengguna, COUNT(*) AS c FROM TRANSAKSI GROUP BY id_pengguna) t
 ON t.id_pengguna = u.id_pengguna
SET u.jumlah_transaksi_dibuat = t.c;
COMMIT;
-- KAS_REKENING.saldo_terkini (hanya pembayaran yang terverifikasi)
UPDATE KAS_REKENING k
LEFT JOIN (
   SELECT id_kas,
          SUM(IF(arah_pembayaran = 'MASUK', jumlah_bayar, -jumlah_bayar)) AS s
   FROM PEMBAYARAN
   WHERE status_verifikasi = 'Terverifikasi'
   GROUP BY id_kas
) x ON x.id_kas = k.id_kas
SET k.saldo_terkini = COALESCE(x.s, 0);
COMMIT;
-- ---------------------------------------------------------------------
-- 9. Bersihkan tabel bantu
-- ---------------------------------------------------------------------
DROP TABLE bantu_seq;
DROP TABLE bantu_digit;
SET autocommit = 1;
SET SQL_SAFE_UPDATES = 1;
-- ---------------------------------------------------------------------
-- 10. Verifikasi (opsional): jumlah baris tiap tabel
-- ---------------------------------------------------------------------
SELECT 'PENGGUNA' AS tabel, COUNT(*) AS jumlah FROM PENGGUNA
UNION ALL SELECT 'PELANGGAN', COUNT(*) FROM PELANGGAN
UNION ALL SELECT 'PEMASOK', COUNT(*) FROM PEMASOK
UNION ALL SELECT 'PRODUK', COUNT(*) FROM PRODUK
UNION ALL SELECT 'KAS_REKENING', COUNT(*) FROM KAS_REKENING
UNION ALL SELECT 'LAPORAN_KEUANGAN', COUNT(*) FROM LAPORAN_KEUANGAN
UNION ALL SELECT 'TRANSAKSI', COUNT(*) FROM TRANSAKSI
UNION ALL SELECT 'BUKTI_TRANSAKSI', COUNT(*) FROM BUKTI_TRANSAKSI
UNION ALL SELECT 'PEMBAYARAN', COUNT(*) FROM PEMBAYARAN
UNION ALL SELECT 'TRANSAKSI_KAS_PEMILIK', COUNT(*) FROM TRANSAKSI_KAS_PEMILIK
UNION ALL SELECT 'DETAIL_PENJUALAN', COUNT(*) FROM DETAIL_PENJUALAN
UNION ALL SELECT 'DETAIL_PEMBELIAN', COUNT(*) FROM DETAIL_PEMBELIAN;
