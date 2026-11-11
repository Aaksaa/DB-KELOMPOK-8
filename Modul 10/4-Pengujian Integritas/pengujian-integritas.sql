-- 1. FOREIGN KEY: id_pelanggan tidak terdaftar (999)
INSERT INTO DETAIL_PENJUALAN (id_transaksi, no_item, id_produk, id_pelanggan, jumlah, harga_satuan_actual, diskon_item) 
VALUES (1, 1, 1, 999, 2, 10000, 0);
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`praktikum_modul10`.`DETAIL_PENJUALAN`, CONSTRAINT `fk_detjual_pelanggan` FOREIGN KEY (`id_pelanggan`) REFERENCES `PELANGGAN` (`id_pelanggan`) ON UPDATE CASCADE)
-- Database menolak penyisipan data karena angka 999 pada kolom id_pelanggan tidak ditemukan di tabel PELANGGAN. Constraint fk_detjual_pelanggan mencegah terjadinya orphan record (data anak yang tidak memiliki induk), sehingga integritas relasi antar tabel tetap terjaga.

-- 2. RESTRICT default: hapus pelanggan yang masih memiliki pesanan
DELETE FROM PELANGGAN WHERE id_pelanggan = 1;
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`praktikum_modul10`.`DETAIL_PENJUALAN`, CONSTRAINT `fk_detjual_pelanggan` FOREIGN KEY (`id_pelanggan`) REFERENCES `PELANGGAN` (`id_pelanggan`) ON UPDATE CASCADE)
-- Karena di dalam skema ini, foreign key-nya tidak mendefinisikan aturan ON DELETE (misalnya ON DELETE CASCADE), maka MariaDB/MySQL otomatis menerapkan perilaku bawaan yaitu RESTRICT. Database menolak penghapusan pelanggan ID 1 karena ID tersebut masih tercatat di tabel DETAIL_PENJUALAN. Ini mencegah data transaksi menjadi yatim (orphant data).

-- 3. FOREIGN KEY: id_kas tidak terdaftar (999)
INSERT INTO PEMBAYARAN (id_transaksi, arah_pembayaran, metode_bayar, jumlah_bayar, id_kas) 
VALUES (2, 'masuk', 'transfer', 50000, 999);
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`praktikum_modul10`.`PEMBAYARAN`, CONSTRAINT `fk_pembayaran_kas` FOREIGN KEY (`id_kas`) REFERENCES `KAS_REKENING` (`id_kas`) ON UPDATE CASCADE)
-- Sama seperti skenario pertama, database menolak pencatatan pembayaran karena angka 999 pada kolom id_kas tidak ada di tabel KAS_REKENING. Constraint fk_pembayaran_kas memastikan bahwa setiap transaksi pembayaran benar-benar masuk ke rekening kas yang valid dan terdaftar di sistem keuangan UMKM.

