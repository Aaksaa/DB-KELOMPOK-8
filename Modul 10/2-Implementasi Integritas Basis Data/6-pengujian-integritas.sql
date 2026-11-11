-- 1. FOREIGN KEY: pengguna tidak ada
INSERT INTO TRANSAKSI (tanggal_transaksi,waktu_transaksi,status_validasi,id_pengguna,jenis_transaksi)
VALUES ('2026-11-05','10:00:00','VALID',99,'PENJUALAN');
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails

-- 2. RESTRICT: hapus pengguna yang masih punya transaksi
DELETE FROM PENGGUNA WHERE id_pengguna = 1;
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails

-- 3. UNIQUE: email ganda
INSERT INTO PENGGUNA (nama,tanggal_lahir,email,status_aktif)
VALUES ('Budi Dua','2005-01-01','budi@mail.com',TRUE);
-- ERROR 1062 (23000): Duplicate entry 'budi@mail.com' for key 'pengguna.uq_pengguna_email'
