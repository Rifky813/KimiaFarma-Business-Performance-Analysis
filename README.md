# 📊 Kimia Farma – Big Data Analytics (2020–2023)

## 📝 About the Project
Kimia Farma perlu mengevaluasi kinerja bisnis periode **2020–2023** pada level cabang dan produk. Analisis ini mencakup:

- Dampak kebijakan diskon terhadap penjualan dan margin  
- Identifikasi area pertumbuhan, efisiensi, dan prioritas tindakan  
- Pemetaan tren penjualan & profitabilitas  
- Hubungan antara rating transaksi dengan kinerja penjualan sebagai indikator kualitas layanan  

**Tech Stack:** BigQuery · SQL · Data Visualization (BI Tools)

---

## ❓ Problem Statement
Bagaimana Kimia Farma dapat:  
1. Memetakan tren penjualan & profitabilitas 2020–2023  
2. Mengidentifikasi cabang & produk dengan kinerja tertinggi/terendah  
3. Menilai efektivitas diskon (apakah meningkatkan penjualan tanpa menggerus margin)  
4. Mengaitkan rating transaksi dengan kualitas layanan  

---

## 🗂 Dataset
Analisis ini menggunakan **4 dataset utama**:

| Dataset           | Deskripsi                                                                 |
|-------------------|---------------------------------------------------------------------------|
| `final_transaction` | Catatan transaksi pelanggan (2020–2023)                                  |
| `inventory`         | Data ketersediaan stok obat per cabang                                   |
| `kantor_cabang`     | Daftar cabang (kode, lokasi, kategori, rating)                          |
| `product`           | Detail produk & harga                                                    |

➡️ Dataset diintegrasikan ke tabel **`analysis_table`** (672.458 entri, 16 fitur)  
Kolom penting: `transaction_id, branch_name, kota, provinsi, product_name, actual_price, discount_percentage, nett_sales, nett_profit, rating_transaksi`

---

## ⚙️ Data Processing (BigQuery)
- **CREATE TABLE** → Membuat tabel utama `analysis_table`  
- **CTE (Common Table Expression)** → Hitung persentase laba kotor & nett sales  
- **CASE WHEN** → Tentukan % gross laba berdasarkan range harga produk  
- **JOIN** → Gabungkan data cabang & produk berdasarkan `branch_id` & `product_id`  

📌 Contoh potongan SQL:
```sql
CASE
    WHEN price <= 50000 THEN 0.10
    WHEN price > 50000 AND price <= 100000 THEN 0.15
    WHEN price > 100000 AND price <= 300000 THEN 0.20
    WHEN price > 300000 AND price <= 500000 THEN 0.25
    WHEN price > 500000 THEN 0.30
END AS persentase_gross_laba
```

---

## 📊 Dashboard Performance Analytics
### 🔹 **Sales & Transactions**

- Penjualan: ±Rp321 miliar
- Laba kotor: ±Rp91 miliar (margin ±28%)
- Jumlah transaksi: +672 ribu
- Rata-rata belanja per transaksi: ~Rp480 ribu
- Rata-rata laba per transaksi: ~Rp136 ribu

Pertumbuhan penjualan didorong oleh jumlah transaksi, bukan nilai per transaksi.

### 🔹 **Branch & Transaction Rating**

- Rating cabang lebih tinggi dibanding pengalaman transaksi (~4,0)
- Masih ada gesekan: antrean panjang, diskon/harga kurang jelas, metode pembayaran terbatas, ketersediaan stok

### 🔹 **Geographic**

- Jawa Barat = penyumbang terbesar penjualan & transaksi
- Diikuti: Sumatera Utara, Jawa Tengah, Jawa Timur
- Laba terkonsentrasi di Jawa & Sumatra
- Indonesia Timur relatif kecil kontribusinya → peluang pertumbuhan

### 🔹 **Product Portfolio**

- Produk unggulan mendorong sebagian besar volume
- KF519 = produk terlaris
- KF451 = produk terendah
- Pola “ekor panjang” → banyak produk berpenjualan kecil butuh strategi khusus

---

## 🔍 **Insights Deep Dive**

1) Tingkatkan pengalaman checkout → kurangi antrean, tambah opsi pembayaran, perjelas label harga/diskon.
2) Pastikan ketersediaan produk unggulan → stok produk laku harus terjamin, bundling produk jarang laku.
3) Uji skema diskon terbatas → gunakan hanya yang terbukti meningkatkan penjualan tanpa menekan margin.
4) Replikasi praktik terbaik cabang top → mulai dari Jawa Barat lalu scale-up ke wilayah lain.

---

## 💡 **Business Recommendations**

- Optimalkan pengalaman transaksi pelanggan
- Kelola portofolio produk secara strategis
- Terapkan kebijakan diskon berbasis data
- Fokus ekspansi wilayah Indonesia Timur
