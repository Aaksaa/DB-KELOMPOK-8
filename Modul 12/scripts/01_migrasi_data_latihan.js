// ============================================================================
// Migrasi TRANSAKSI, DETAIL_PENJUALAN, DETAIL_PEMBELIAN ke MongoDB
// Database : praktikum_modul12
//
// Jalankan dari terminal (database ditentukan lewat connection string):
//   mongosh "mongodb://localhost:27017/praktikum_modul12" --file mongodb_praktikum_modul12.js
//
// Atau paste seluruh isi file ini ke MONGOSH di Compass setelah menjalankan:
//   use praktikum_modul12
// ============================================================================


// ---------------------------------------------------------------------------
// 0. BERSIHKAN (supaya aman dijalankan ulang)
// ---------------------------------------------------------------------------
db.detail_penjualan.drop()
db.detail_pembelian.drop()
db.transaksi.drop()


// ---------------------------------------------------------------------------
// 1. STRUKTUR COLLECTION (DDL)
// ---------------------------------------------------------------------------
db.createCollection("transaksi", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["_id", "waktu_transaksi", "status_validasi", "id_pengguna", "jenis_transaksi"],
      properties: {
        _id:             { bsonType: ["int", "long", "double"] },
        waktu_transaksi: { bsonType: "date" },
        keterangan:      { bsonType: "string", maxLength: 255 },
        status_validasi: { bsonType: "string", maxLength: 50 },
        id_pengguna:     { bsonType: ["int", "long", "double"] },
        total_nilai:     { bsonType: "decimal" },
        jenis_transaksi: { enum: ["PENJUALAN", "PEMBELIAN"] }
      }
    }
  }
})

db.createCollection("detail_penjualan", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["id_transaksi", "no_item", "id_produk", "id_pelanggan", "jumlah", "harga_satuan_actual", "diskon_item"],
      properties: {
        id_transaksi:        { bsonType: ["int", "long", "double"] },
        no_item:             { bsonType: ["int", "long", "double"] },
        id_produk:           { bsonType: ["int", "long", "double"] },
        id_pelanggan:        { bsonType: ["int", "long", "double"] },
        jumlah:              { bsonType: ["int", "long", "double"] },
        harga_satuan_actual: { bsonType: "decimal" },
        diskon_item:         { bsonType: "decimal" },
        subtotal:            { bsonType: "decimal" }
      }
    }
  }
})

db.createCollection("detail_pembelian", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["id_transaksi", "no_item", "id_produk", "id_pemasok", "jumlah", "harga_satuan_actual", "diskon_item"],
      properties: {
        id_transaksi:        { bsonType: ["int", "long", "double"] },
        no_item:             { bsonType: ["int", "long", "double"] },
        id_produk:           { bsonType: ["int", "long", "double"] },
        id_pemasok:          { bsonType: ["int", "long", "double"] },
        jumlah:              { bsonType: ["int", "long", "double"] },
        harga_satuan_actual: { bsonType: "decimal" },
        diskon_item:         { bsonType: "decimal" },
        subtotal:            { bsonType: "decimal" }
      }
    }
  }
})

// Indeks (PRIMARY KEY gabungan id_transaksi + no_item dibuat unik)
db.transaksi.createIndex({ id_pengguna: 1 })
db.transaksi.createIndex({ jenis_transaksi: 1, waktu_transaksi: -1 })

db.detail_penjualan.createIndex({ id_transaksi: 1, no_item: 1 }, { unique: true })
db.detail_penjualan.createIndex({ id_produk: 1 })
db.detail_penjualan.createIndex({ id_pelanggan: 1 })

db.detail_pembelian.createIndex({ id_transaksi: 1, no_item: 1 }, { unique: true })
db.detail_pembelian.createIndex({ id_produk: 1 })
db.detail_pembelian.createIndex({ id_pemasok: 1 })


// ---------------------------------------------------------------------------
// 2. PENGISIAN DATA (DML)
//    subtotal = jumlah * harga_satuan_actual - diskon_item
//    waktu disimpan UTC (09:15 WIB = 02:15Z)
// ---------------------------------------------------------------------------
db.transaksi.insertMany([
  { _id: 1, waktu_transaksi: ISODate("2026-10-01T02:15:00Z"), keterangan: "Penjualan keripik & kopi ke Warung Bu Ani",   status_validasi: "Valid",    id_pengguna: 2, total_nilai: NumberDecimal("370000.00"), jenis_transaksi: "PENJUALAN" },
  { _id: 2, waktu_transaksi: ISODate("2026-10-03T04:40:00Z"), keterangan: "Penjualan madu & sambal ke Toko Oleh-Oleh",   status_validasi: "Valid",    id_pengguna: 2, total_nilai: NumberDecimal("320000.00"), jenis_transaksi: "PENJUALAN" },
  { _id: 3, waktu_transaksi: ISODate("2026-10-07T07:05:00Z"), keterangan: "Penjualan keripik ke Kafe Senja",             status_validasi: "Menunggu", id_pengguna: 3, total_nilai: NumberDecimal("280000.00"), jenis_transaksi: "PENJUALAN" },
  { _id: 4, waktu_transaksi: ISODate("2026-10-02T01:30:00Z"), keterangan: "Pembelian kopi & teh dari CV Tani Makmur",    status_validasi: "Valid",    id_pengguna: 1, total_nilai: NumberDecimal("860000.00"), jenis_transaksi: "PEMBELIAN" },
  { _id: 5, waktu_transaksi: ISODate("2026-10-08T03:20:00Z"), keterangan: "Pembelian madu & sambal dari UD Sumber Rasa", status_validasi: "Valid",    id_pengguna: 1, total_nilai: NumberDecimal("624000.00"), jenis_transaksi: "PEMBELIAN" }
])

db.detail_penjualan.insertMany([
  { id_transaksi: 1, no_item: 1, id_produk: 1, id_pelanggan: 1, jumlah: 10, harga_satuan_actual: NumberDecimal("15000.00"), diskon_item: NumberDecimal("0.00"),     subtotal: NumberDecimal("150000.00") },
  { id_transaksi: 1, no_item: 2, id_produk: 2, id_pelanggan: 1, jumlah: 5,  harga_satuan_actual: NumberDecimal("45000.00"), diskon_item: NumberDecimal("5000.00"),  subtotal: NumberDecimal("220000.00") },
  { id_transaksi: 2, no_item: 1, id_produk: 3, id_pelanggan: 2, jumlah: 3,  harga_satuan_actual: NumberDecimal("60000.00"), diskon_item: NumberDecimal("0.00"),     subtotal: NumberDecimal("180000.00") },
  { id_transaksi: 2, no_item: 2, id_produk: 4, id_pelanggan: 2, jumlah: 6,  harga_satuan_actual: NumberDecimal("25000.00"), diskon_item: NumberDecimal("10000.00"), subtotal: NumberDecimal("140000.00") },
  { id_transaksi: 3, no_item: 1, id_produk: 1, id_pelanggan: 3, jumlah: 20, harga_satuan_actual: NumberDecimal("14000.00"), diskon_item: NumberDecimal("0.00"),     subtotal: NumberDecimal("280000.00") }
])

db.detail_pembelian.insertMany([
  { id_transaksi: 4, no_item: 1, id_produk: 2, id_pemasok: 1, jumlah: 20, harga_satuan_actual: NumberDecimal("35000.00"), diskon_item: NumberDecimal("20000.00"), subtotal: NumberDecimal("680000.00") },
  { id_transaksi: 4, no_item: 2, id_produk: 5, id_pemasok: 1, jumlah: 10, harga_satuan_actual: NumberDecimal("18000.00"), diskon_item: NumberDecimal("0.00"),     subtotal: NumberDecimal("180000.00") },
  { id_transaksi: 5, no_item: 1, id_produk: 3, id_pemasok: 2, jumlah: 10, harga_satuan_actual: NumberDecimal("45000.00"), diskon_item: NumberDecimal("0.00"),     subtotal: NumberDecimal("450000.00") },
  { id_transaksi: 5, no_item: 2, id_produk: 4, id_pemasok: 2, jumlah: 12, harga_satuan_actual: NumberDecimal("15000.00"), diskon_item: NumberDecimal("6000.00"),  subtotal: NumberDecimal("174000.00") }
])


// ---------------------------------------------------------------------------
// 3. CEK HASIL
// ---------------------------------------------------------------------------
db.getCollectionNames()
db.transaksi.countDocuments()
db.detail_penjualan.countDocuments()
db.detail_pembelian.countDocuments()