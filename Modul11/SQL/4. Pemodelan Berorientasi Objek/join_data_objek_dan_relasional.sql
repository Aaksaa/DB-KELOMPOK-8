SELECT
    t.id_transaksi,
    t.tanggal_transaksi,
    t.waktu_transaksi,
    t.status_validasi,

    p.id_produk,
    p.nama_produk,
    p.harga_satuan_baku,

    dp.id_pelanggan,
    pl.nama_pelanggan,

    dp.jumlah,
    dp.harga_satuan_actual,
    dp.diskon_item,
    dp.subtotal

FROM TRANSAKSI t

JOIN DETAIL_PENJUALAN dp
    ON t.id_transaksi = dp.id_transaksi

JOIN PRODUK p
    ON dp.id_produk = p.id_produk

JOIN PELANGGAN pl
    ON dp.id_pelanggan = pl.id_pelanggan;