SELECT p.nama, COUNT(t.id_transaksi) AS jml_transaksi, SUM(t.total_nilai) AS total_penjualan
FROM TRANSAKSI t
JOIN PENGGUNA p ON p.id_pengguna = t.id_pengguna
GROUP BY p.nama;