INSERT INTO PENGGUNA (nama, tanggal_lahir, email, status_aktif, alamat, nomor_telepon, role) VALUES
 ('Budi Santoso','2005-03-14','budi@mail.com',TRUE,'Jl. Merdeka 10, Madiun','0815218590','kasir'),
 ('Siti Aminah','2004-07-21','siti@mail.com',TRUE,'Jl. Pahlawan 5, Madiun','081298365032','admin');

INSERT INTO TRANSAKSI (tanggal_transaksi, waktu_transaksi, keterangan, status_validasi, id_pengguna, total_nilai, jenis_transaksi) VALUES
 ('2026-11-02','09:23:08','Penjualan ke Toko Maju','VALID',1,368000,'PENJUALAN'),
 ('2026-11-03','14:30:45','Penjualan ke Andi Wijaya','VALID',2,34000,'PENJUALAN');

INSERT INTO DETAIL_PENJUALAN (id_transaksi,no_item,id_produk,id_pelanggan,jumlah,harga_satuan_actual,diskon_item,subtotal) VALUES
 (1,1,101,201,4,65000,0,260000),
 (1,2,102,201,3,38000,6000,108000),
 (2,1,103,202,2,17000,0,34000);