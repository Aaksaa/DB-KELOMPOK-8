-- 1. Eksplorasi JOIN (Tahap 1)
SELECT
    t.id_transaksi,
    t.tanggal_transaksi,
    SUM(dp.subtotal) AS total_penjualan
FROM TRANSAKSI t
JOIN DETAIL_PENJUALAN dp
    ON t.id_transaksi = dp.id_transaksi
GROUP BY
    t.id_transaksi,
    t.tanggal_transaksi
ORDER BY t.id_transaksi;

-- 2. Penerapan Denormalisasi (Tahap 2)
CREATE TABLE REKAP_PENJUALAN (
    id_transaksi INT NOT NULL PRIMARY KEY,
    total_penjualan DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (id_transaksi)
        REFERENCES TRANSAKSI(id_transaksi)
);

INSERT INTO REKAP_PENJUALAN (
    id_transaksi,
    total_penjualan
)
SELECT
    t.id_transaksi,
    SUM(dp.subtotal)
FROM TRANSAKSI t
JOIN DETAIL_PENJUALAN dp
    ON t.id_transaksi = dp.id_transaksi
GROUP BY t.id_transaksi;

-- 3. Pembuktian (Tahap 3)
SELECT
    id_transaksi,
    total_penjualan
FROM REKAP_PENJUALAN;
