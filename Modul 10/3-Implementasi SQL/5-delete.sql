INSERT INTO produk (nama_produk, harga_satuan_baku)
VALUES ('Produk Uji Hapus', 3000.00);

SELECT * FROM produk
WHERE nama_produk = 'Produk Uji Hapus';

DELETE FROM produk
WHERE nama_produk = 'Produk Uji Hapus';

SELECT * FROM produk
WHERE nama_produk = 'Produk Uji Hapus';
