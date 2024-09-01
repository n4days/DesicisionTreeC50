# Instal dan muat paket C50 jika belum terpasang
if (!require(C50)) {
  install.packages("C50")
  library(C50)
}

# Siapkan data
data <- data.frame(
  ID_Penumpang = c("PNP-0001", "PNP-0002", "PNP-0003", "PNP-0004", "PNP-0005", 
                   "PNP-0006", "PNP-0007", "PNP-0008", "PNP-0009"),
  Fasilitas = c("Tidak Lengkap", "Tidak Lengkap", "Tidak Lengkap", "Tidak Lengkap", 
                "Tidak Lengkap", "Lengkap", "Lengkap", "Lengkap", "Lengkap"),
  Harga = c("Mahal", "Mahal", "Mahal", "Mahal", "Murah", "Murah", "Murah", "Murah", "Murah"),
  Lokasi = c("Strategis", "Tidak Strategis", "Strategis", "Strategis", "Strategis", 
             "Tidak Strategis", "Strategis", "Strategis", "Tidak Strategis"),
  Pelayanan = c("Baik", "Tidak Baik", "Tidak Baik", "Tidak Baik", "Baik", 
                "Baik", "Tidak Baik", "Tidak Baik", "Baik"),
  Kepuasan = factor(c(1, 0, 0, 0, 1, 1, 1, 1, 1))
)

# Buat model decision tree menggunakan C5.0
model <- C5.0(Kepuasan ~ Fasilitas + Harga + Lokasi + Pelayanan, data = data)

# Lihat ringkasan model
summary(model)

# Plot pohon keputusan
plot(model)
