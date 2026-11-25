// ============================================================================
// RANCANGAN MIGRASI PjBL
// SISTEM INFORMASI KEUANGAN UMKM
// MySQL -> MongoDB
// ============================================================================

// Menggunakan database
db = db.getSiblingDB("db_keuangan")


// ============================================================================
// 1. MEMBUAT COLLECTION DAN VALIDASI SCHEMA
// ============================================================================

if (!db.getCollectionNames().includes("transaksi")) {
    db.createCollection("transaksi", {
        validator: {
            $jsonSchema: {
                bsonType: "object",
                required: [
                    "_id",
                    "waktu_transaksi",
                    "status_validasi",
                    "id_pengguna",
                    "jenis_transaksi"
                ],
                properties: {
                    _id: {
                        bsonType: ["int", "long"]
                    },
                    waktu_transaksi: {
                        bsonType: "date"
                    },
                    keterangan: {
                        bsonType: "string",
                        maxLength: 255
                    },
                    status_validasi: {
                        bsonType: "string",
                        maxLength: 50
                    },
                    id_pengguna: {
                        bsonType: ["int", "long"]
                    },
                    jenis_transaksi: {
                        enum: [
                            "PENJUALAN",
                            "PEMBELIAN",
                            "KAS_PEMILIK"
                        ]
                    },
                    id_pelanggan: {
                        bsonType: ["int", "long"]
                    }
                }
            }
        }
    })
}


if (!db.getCollectionNames().includes("detail_penjualan")) {
    db.createCollection("detail_penjualan", {
        validator: {
            $jsonSchema: {
                bsonType: "object",
                required: [
                    "id_transaksi",
                    "no_item",
                    "id_produk",
                    "jumlah",
                    "harga_satuan_actual",
                    "diskon_item"
                ],
                properties: {
                    id_transaksi: {
                        bsonType: ["int", "long"]
                    },
                    no_item: {
                        bsonType: ["int", "long"]
                    },
                    id_produk: {
                        bsonType: ["int", "long"]
                    },
                    jumlah: {
                        bsonType: ["int", "long"]
                    },
                    harga_satuan_actual: {
                        bsonType: "decimal"
                    },
                    diskon_item: {
                        bsonType: "decimal"
                    }
                }
            }
        }
    })
}


// ============================================================================
// 2. MEMBUAT INDEX
// ============================================================================

// Index transaksi berdasarkan jenis dan waktu
db.transaksi.createIndex({
    jenis_transaksi: 1,
    waktu_transaksi: -1
})

// Index unik detail penjualan
db.detail_penjualan.createIndex(
    {
        id_transaksi: 1,
        no_item: 1
    },
    {
        unique: true
    }
)

// Index berdasarkan produk
db.detail_penjualan.createIndex({
    id_produk: 1
})


// ============================================================================
// 3. QUERY TRANSAKSI PENJUALAN BESERTA DETAIL
// ============================================================================

db.transaksi.aggregate([
    {
        $match: {
            jenis_transaksi: "PENJUALAN"
        }
    },

    {
        $sort: {
            waktu_transaksi: -1
        }
    },

    {
        $lookup: {
            from: "detail_penjualan",
            localField: "_id",
            foreignField: "id_transaksi",

            pipeline: [
                {
                    $sort: {
                        no_item: 1
                    }
                },

                {
                    $addFields: {
                        subtotal: {
                            $subtract: [
                                {
                                    $multiply: [
                                        "$jumlah",
                                        "$harga_satuan_actual"
                                    ]
                                },
                                "$diskon_item"
                            ]
                        }
                    }
                },

                {
                    $project: {
                        _id: 0,
                        no_item: 1,
                        id_produk: 1,
                        jumlah: 1,
                        harga_satuan_actual: 1,
                        diskon_item: 1,
                        subtotal: 1
                    }
                }
            ],

            as: "detail_penjualan"
        }
    },

    {
        $addFields: {
            total_penjualan: {
                $sum: "$detail_penjualan.subtotal"
            }
        }
    },

    {
        $project: {
            _id: 0,
            id_transaksi: "$_id",
            waktu_transaksi: 1,
            keterangan: 1,
            status_validasi: 1,
            id_pengguna: 1,
            id_pelanggan: 1,
            detail_penjualan: 1,
            total_penjualan: 1
        }
    }
])


// ============================================================================
// 4. EXPLAIN QUERY UNTUK OPTIMISASI
// ============================================================================

db.transaksi.explain("executionStats").aggregate([
    {
        $match: {
            jenis_transaksi: "PENJUALAN"
        }
    },

    {
        $sort: {
            waktu_transaksi: -1
        }
    },

    {
        $lookup: {
            from: "detail_penjualan",
            localField: "_id",
            foreignField: "id_transaksi",

            pipeline: [
                {
                    $sort: {
                        no_item: 1
                    }
                },

                {
                    $addFields: {
                        subtotal: {
                            $subtract: [
                                {
                                    $multiply: [
                                        "$jumlah",
                                        "$harga_satuan_actual"
                                    ]
                                },
                                "$diskon_item"
                            ]
                        }
                    }
                },

                {
                    $project: {
                        _id: 0,
                        no_item: 1,
                        id_produk: 1,
                        jumlah: 1,
                        harga_satuan_actual: 1,
                        diskon_item: 1,
                        subtotal: 1
                    }
                }
            ],

            as: "detail_penjualan"
        }
    },

    {
        $addFields: {
            total_penjualan: {
                $sum: "$detail_penjualan.subtotal"
            }
        }
    },

    {
        $project: {
            _id: 0,
            id_transaksi: "$_id",
            waktu_transaksi: 1,
            keterangan: 1,
            status_validasi: 1,
            id_pengguna: 1,
            id_pelanggan: 1,
            detail_penjualan: 1,
            total_penjualan: 1
        }
    }
])


// ============================================================================
// 5. MEMBUAT ROLE DAN HAK AKSES (RBAC)
// ============================================================================

// Role Kasir
if (db.getRole("role_kasir") == null) {
    db.createRole({
        role: "role_kasir",

        privileges: [
            {
                resource: {
                    db: "db_keuangan",
                    collection: "transaksi"
                },
                actions: ["find", "insert"]
            },

            {
                resource: {
                    db: "db_keuangan",
                    collection: "detail_penjualan"
                },
                actions: ["find", "insert"]
            }
        ],

        roles: []
    })
}


// Role Pemilik UMKM
if (db.getRole("role_pemilik") == null) {
    db.createRole({
        role: "role_pemilik",

        privileges: [
            {
                resource: {
                    db: "db_keuangan",
                    collection: "transaksi"
                },
                actions: ["find"]
            },

            {
                resource: {
                    db: "db_keuangan",
                    collection: "detail_penjualan"
                },
                actions: ["find"]
            }
        ],

        roles: []
    })
}


// ============================================================================
// 6. PEMERIKSAAN HASIL MIGRASI
// ============================================================================

// Melihat collection
db.getCollectionNames()

// Menghitung dokumen
db.transaksi.countDocuments()

db.detail_penjualan.countDocuments()

// Melihat index
db.transaksi.getIndexes()

db.detail_penjualan.getIndexes()

// Melihat hak akses role
db.getRole("role_kasir", {
    showPrivileges: true
})

db.getRole("role_pemilik", {
    showPrivileges: true
})