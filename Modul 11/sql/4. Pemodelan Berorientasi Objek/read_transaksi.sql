
-- Menampilkan seluruh transaksi
SELECT
    t.id_transaksi,
    t.tanggal_transaksi,
    t.jenis_transaksi,
    t.status_validasi,
    p.arah_pembayaran,
    p.metode_bayar,
    p.jumlah_bayar,
    p.referensi
FROM TRANSAKSI t
JOIN PEMBAYARAN p
    ON t.id_transaksi = p.id_transaksi;

-- Menampilkan transaksi pembayaran
SELECT
    t.id_transaksi,
    t.tanggal_transaksi,
    t.jenis_transaksi,
    t.status_validasi,
    tk.jenis_kas_pemilik,
    tk.jumlah,
    tk.keterangan_tambahan
FROM TRANSAKSI t
JOIN TRANSAKSI_KAS_PEMILIK tk
    ON t.id_transaksi = tk.id_transaksi;