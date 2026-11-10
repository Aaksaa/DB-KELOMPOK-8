UPDATE TRANSAKSI SET status_validasi = 'DIKOREKSI' WHERE id_transaksi = 2;

UPDATE PENGGUNA SET id_pengguna = 10 WHERE id_pengguna = 2;
SELECT id_transaksi, id_pengguna FROM TRANSAKSI WHERE id_transaksi = 2;