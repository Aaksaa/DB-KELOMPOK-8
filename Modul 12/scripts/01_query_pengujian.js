db.transaksi.aggregate([
    // 1. JOIN dengan detail_penjualan
    {
        $lookup: {
            from: "detail_penjualan",
            localField: "_id",
            foreignField: "id_transaksi",
            as: "detail_penjualan"
        }
    },

    // 2. JOIN dengan detail_pembelian
    {
        $lookup: {
            from: "detail_pembelian",
            localField: "_id",
            foreignField: "id_transaksi",
            as: "detail_pembelian"
        }
    },

    // 3. PROYEKSI atribut yang ditampilkan
    {
        $project: {
            _id: 0,
            id_pengguna: 1,
            jenis_transaksi: 1,
            status_validasi: 1,
            jumlah_detail_penjualan: {
                $size: "$detail_penjualan"
            },
            jumlah_detail_pembelian: {
                $size: "$detail_pembelian"
            }
        }
    },

    // 4. Pengurutan berdasarkan id_pengguna
    {
        $sort: {
            id_pengguna: 1
        }
    }
])