-- Note: perintah ini digunakan untuk membuat 1jt data dummy.

SET SESSION cte_max_recursion_depth = 1000000;

INSERT INTO TRANSAKSI (tanggal_transaksi, waktu_transaksi, keterangan, status_validasi, id_pengguna, total_nilai, jenis_transaksi)
WITH RECURSIVE seq AS (
    SELECT 1 AS n UNION ALL SELECT n+1 FROM seq WHERE n < 1000000
)
SELECT DATE_ADD('2024-01-01', INTERVAL (n % 1000) DAY),
       '10:00:00', CONCAT('Transaksi ', n), 'VALID', 1,
       ROUND(10000 + RAND()*500000, 2), 'PENJUALAN'
FROM seq;