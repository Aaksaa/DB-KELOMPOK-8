USE praktikum_modul10;

-- 1. PENGGUNA
INSERT INTO PENGGUNA
(id_pengguna, nama, tanggal_lahir, email, status_aktif, alamat, nomor_telepon, role, jumlah_transaksi_dibuat) VALUES
(1, 'Siti Rahmawati', '1990-04-12', 'siti.rahmawati@umkmmaju.id', TRUE,  'Jl. Margonda Raya No. 21, Pancoran Mas, Depok, Jawa Barat, 16431', '081234567801,0217771001', 'Pemilik,Admin', 5),
(2, 'Budi Santoso',   '1995-08-23', 'budi.santoso@umkmmaju.id',   TRUE,  'Jl. Kemang Raya No. 8, Bojongsari, Depok, Jawa Barat, 16516',     '081234567802',            'Kasir',        4),
(3, 'Dewi Lestari',   '1998-01-30', 'dewi.lestari@umkmmaju.id',   TRUE,  'Jl. Cinere Raya No. 45, Cinere, Depok, Jawa Barat, 16514',        '081234567803,0217771003', 'Kasir,Admin',  1),
(4, 'Andi Prasetyo',  '1992-11-05', 'andi.prasetyo@umkmmaju.id',  FALSE, 'Jl. Sawangan No. 17, Sawangan, Depok, Jawa Barat, 16511',         '081234567804',            'Akuntan',      0);

-- 2. PELANGGAN
INSERT INTO PELANGGAN (id_pelanggan, nama_pelanggan, kontak) VALUES
(1, 'Warung Bu Ani',         '081298760001'),
(2, 'Toko Oleh-Oleh Nusantara', '081298760002'),
(3, 'Kafe Senja',            '081298760003'),
(4, 'Rina Marlina',          '081298760004'),
(5, 'Koperasi Sejahtera',    '021-5550005');

-- 3. PEMASOK
INSERT INTO PEMASOK (id_pemasok, nama_pemasok, kontak, email) VALUES
(1, 'CV Tani Makmur',      '081377710001', 'order@tanimakmur.co.id'),
(2, 'UD Sumber Rasa',      '081377710002', 'sumberrasa@gmail.com'),
(3, 'PT Kemasan Prima',    '021-7770003',  'sales@kemasanprima.co.id');

-- 4. PRODUK
INSERT INTO PRODUK (id_produk, nama_produk, harga_satuan_baku) VALUES
(1, 'Keripik Singkong 250g', 15000.00),
(2, 'Kopi Bubuk Arabika 200g', 45000.00),
(3, 'Madu Hutan 250ml',       60000.00),
(4, 'Sambal Roa 150g',         25000.00),
(5, 'Teh Herbal Celup (isi 20)', 20000.00),
(6, 'Gula Aren Cair 500ml',    30000.00);

-- 5. KAS_REKENING
INSERT INTO KAS_REKENING (id_kas, nama_kas, jenis_kas, saldo_terkini) VALUES
(1, 'Kas Tunai Toko', 'Tunai',    1870000.00),
(2, 'Rekening BCA',   'Bank',     4140000.00),
(3, 'DANA Usaha',     'E-Wallet',  320000.00);

-- 6. TRANSAKSI
-- T1-T3 penjualan | T4-T5 pembelian | T6-T8 pembayaran | T9-T10 kas pemilik
INSERT INTO TRANSAKSI
(id_transaksi, tanggal_transaksi, waktu_transaksi, keterangan, status_validasi, id_pengguna, total_nilai, jenis_transaksi) VALUES
(1,  '2026-10-01', '09:15:00', 'Penjualan keripik & kopi ke Warung Bu Ani',     'Valid',    2, 370000.00,  'PENJUALAN'),
(2,  '2026-10-03', '11:40:00', 'Penjualan madu & sambal ke Toko Oleh-Oleh',     'Valid',    2, 320000.00,  'PENJUALAN'),
(3,  '2026-10-07', '14:05:00', 'Penjualan keripik ke Kafe Senja',               'Menunggu', 3, 280000.00,  'PENJUALAN'),
(4,  '2026-10-02', '08:30:00', 'Pembelian kopi & teh dari CV Tani Makmur',      'Valid',    1, 860000.00,  'PEMBELIAN'),
(5,  '2026-10-08', '10:20:00', 'Pembelian madu & sambal dari UD Sumber Rasa',   'Valid',    1, 624000.00,  'PEMBELIAN'),
(6,  '2026-10-01', '09:30:00', 'Pelunasan penjualan T1 (tunai)',                'Valid',    2, 370000.00,  'PEMBAYARAN'),
(7,  '2026-10-03', '12:00:00', 'Pelunasan penjualan T2 (DANA)',                 'Valid',    2, 320000.00,  'PEMBAYARAN'),
(8,  '2026-10-05', '09:00:00', 'Pembayaran pembelian T4 ke CV Tani Makmur',     'Valid',    1, 860000.00,  'PEMBAYARAN'),
(9,  '2026-10-01', '07:45:00', 'Setoran modal awal bulan Oktober',              'Valid',    1, 5000000.00, 'KAS_PEMILIK'),
(10, '2026-10-10', '16:10:00', 'Pengambilan pribadi pemilik (prive)',           'Valid',    1, 500000.00,  'KAS_PEMILIK');

-- 7. BUKTI_TRANSAKSI
INSERT INTO BUKTI_TRANSAKSI
(id_bukti, id_transaksi, nomor_bukti, tanggal_bukti, jenis_transaksi, keterangan, berkas_bukti, id_pelanggan, id_pemasok, id_pengguna) VALUES
(1, 1, 'INV-2610-001', '2026-10-01', 'Nota Penjualan', 'Nota penjualan Warung Bu Ani',  'inv_2610_001.pdf,foto_nota_001.jpg', 1,    NULL, 2),
(2, 2, 'INV-2610-002', '2026-10-03', 'Nota Penjualan', 'Nota penjualan Toko Oleh-Oleh', 'inv_2610_002.pdf',                   2,    NULL, 2),
(3, 3, 'INV-2610-003', '2026-10-07', 'Nota Penjualan', 'Nota penjualan Kafe Senja',     'inv_2610_003.pdf,foto_nota_003.jpg', 3,    NULL, 3),
(4, 4, 'PO-2610-001',  '2026-10-02', 'Faktur Pembelian','Faktur CV Tani Makmur',        'faktur_tm_0210.pdf',                 NULL, 1,    1),
(5, 5, 'PO-2610-002',  '2026-10-08', 'Faktur Pembelian','Faktur UD Sumber Rasa',        'faktur_sr_0810.pdf,surat_jalan.jpg', NULL, 2,    1),
(6, 8, 'TRF-2610-001', '2026-10-05', 'Bukti Transfer',  'Bukti transfer ke CV Tani Makmur','bukti_trf_0510.png',              NULL, 1,    1);

-- 8. PEMBAYARAN
INSERT INTO PEMBAYARAN
(id_transaksi, arah_pembayaran, metode_bayar, jumlah_bayar, id_kas, referensi, status_verifikasi, sisa_alokasi) VALUES
(6, 'Masuk',  'Tunai',    370000.00, 1, 'INV-2610-001',  'Terverifikasi', 0.00),
(7, 'Masuk',  'E-Wallet', 320000.00, 3, 'INV-2610-002',  'Terverifikasi', 0.00),
(8, 'Keluar', 'Transfer', 860000.00, 2, 'PO-2610-001',   'Terverifikasi', 0.00);

-- 9. TRANSAKSI_KAS_PEMILIK
INSERT INTO TRANSAKSI_KAS_PEMILIK (id_transaksi, jenis_kas_pemilik, jumlah, keterangan_tambahan) VALUES
(9,  'Setoran Modal', 5000000.00, 'Modal tambahan dari pemilik'),
(10, 'Prive',          500000.00, 'Kebutuhan pribadi pemilik');

-- 10. DETAIL_PENJUALAN  (subtotal = jumlah * harga_satuan_actual - diskon_item)
INSERT INTO DETAIL_PENJUALAN
(id_transaksi, no_item, id_produk, id_pelanggan, jumlah, harga_satuan_actual, diskon_item, subtotal) VALUES
(1, 1, 1, 1, 10, 15000.00,     0.00, 150000.00),
(1, 2, 2, 1,  5, 45000.00,  5000.00, 220000.00),
(2, 1, 3, 2,  3, 60000.00,     0.00, 180000.00),
(2, 2, 4, 2,  6, 25000.00, 10000.00, 140000.00),
(3, 1, 1, 3, 20, 14000.00,     0.00, 280000.00);

-- 11. DETAIL_PEMBELIAN
INSERT INTO DETAIL_PEMBELIAN
(id_transaksi, no_item, id_produk, id_pemasok, jumlah, harga_satuan_actual, diskon_item, subtotal) VALUES
(4, 1, 2, 1, 20, 35000.00, 20000.00, 680000.00),
(4, 2, 5, 1, 10, 18000.00,     0.00, 180000.00),
(5, 1, 3, 2, 10, 45000.00,     0.00, 450000.00),
(5, 2, 4, 2, 12, 15000.00,  6000.00, 174000.00);

-- 12. LAPORAN_KEUANGAN
INSERT INTO LAPORAN_KEUANGAN (id_laporan, judul_laporan, periode, tanggal_cetak, id_pengguna) VALUES
(1, 'Laporan Laba Rugi',        'September 2026', '2026-10-02', 1),
(2, 'Laporan Arus Kas',         'September 2026', '2026-10-02', 1),
(3, 'Laporan Penjualan Mingguan','Minggu 1 Oktober 2026', '2026-10-09', 3);
