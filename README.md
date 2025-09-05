# Business Performance Analysis for Kimia Farma

## About the Project
Kimia Farma perlu mengevaluasi kinerja bisnis periode **2020–2023** pada level cabang dan produk. Analisis ini mencakup:

- Dampak kebijakan diskon terhadap penjualan dan margin  
- Identifikasi area pertumbuhan, efisiensi, dan prioritas tindakan  
- Pemetaan tren penjualan & profitabilitas  
- Hubungan antara rating transaksi dengan kinerja penjualan sebagai indikator kualitas layanan  

**Tech Stack:** BigQuery · SQL · Data Visualization (BI Tools)

---

## Problem Statement
Bagaimana Kimia Farma dapat:  
1. Memetakan tren penjualan & profitabilitas 2020–2023  
2. Mengidentifikasi cabang & produk dengan kinerja tertinggi/terendah  
3. Menilai efektivitas diskon (apakah meningkatkan penjualan tanpa menggerus margin)  
4. Mengaitkan rating transaksi dengan kualitas layanan  

---

## Dataset
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

##  Data Processing (BigQuery)
- **CREATE TABLE** → Membuat tabel utama `analysis_table`  
- **CTE (Common Table Expression)** → Hitung persentase laba kotor & nett sales  
- **CASE WHEN** → Tentukan % gross laba berdasarkan range harga produk  
- **JOIN** → Gabungkan data cabang & produk berdasarkan `branch_id` & `product_id`  

Contoh potongan SQL:
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

## Dashboard Performance Analytics
<img width="1148" height="1199" alt="Screenshot 2025-08-28 100931" src="https://github.com/user-attachments/assets/f6a6f0a2-c685-4180-adba-f45442934eef" />


---

## **Insights Deep Dive**
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

## **Business Recommendations**

1) Tingkatkan pengalaman checkout
   - Kurangi antrean dengan **menambah jalur pembayaran**, sediakan opsi pembayaran **digital/e-wallet**, serta buat **label harga & diskon lebih jelas** di cabang bertransaksi tinggi seperti **Jawa Barat** dan **Sumatera Utara**.
2) Pastikan ketersediaan produk unggulan 
   - Jaga ketersediaan produk **KF519** di cabang utama dan **tampilkan di posisi strategis**. 
Produk dengan penjualan rendah seperti **KF451** sebaiknya **dibundel** dalam **promo sederhana** atau dihentikan bila tidak menguntungkan.
3) Uji skema diskon terbatas 
   - **Diskon besar** (>20%) **tidak meningkatkan margin**, yang tetap di sekitar 28%.
Gunakan **diskon moderat** (10–15%) untuk kategori harga **Rp100.000–Rp300.000** di **cabang utama** (contoh Bandung, Medan) agar penjualan meningkat tanpa menekan profitabilitas.
4) Replikasi praktik terbaik cabang top 
   - Terapkan **strategi promosi & pengelolaan cabang** Jawa Barat di **wilayah potensial** seperti Jawa Tengah (Semarang) dan Sulawesi Selatan (Makassar), agar pertumbuhan lebih merata secara nasional.
