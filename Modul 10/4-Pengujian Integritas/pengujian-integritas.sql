-- 1. FOREIGN KEY: id_pelanggan tidak terdaftar
INSERT INTO DETAIL_PENJUALAN (id_transaksi, no_item, id_produk, id_pelanggan, jumlah, harga_satuan_actual, diskon_item)
VALUES (1, 1, 1, 999, 2, 10000, 0);
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails

-- 2. RESTRICT: hapus pelanggan yang masih punya detail penjualan
DELETE FROM PELANGGAN WHERE id_pelanggan = 1;
-- ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails

-- 3. FOREIGN KEY: id_kas tidak terdaftar
INSERT INTO PEMBAYARAN (id_transaksi, arah_pembayaran, metode_bayar, jumlah_bayar, id_kas)
VALUES (2, 'masuk', 'transfer', 50000, 999);
-- ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails