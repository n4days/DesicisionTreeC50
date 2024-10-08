# Instal dan muat paket C50 dan readxl jika belum terpasang
if (!require(C50)) {
  install.packages("C50")
  library(C50)
}

if (!require(readxl)) {
  install.packages("readxl")
  library(readxl)
}

if (!require(writexl)) {
  install.packages("writexl")
  library(writexl)
}

# Baca data dari file Excel
data_training <- read_excel("data_penumpang.xlsx", sheet = "Training")
data_testing <- read_excel("data_penumpang.xlsx", sheet = "Testing")

# Konversi kolom 'Kepuasan' menjadi faktor
data_training$Kepuasan <- factor(data_training$Kepuasan)

# Cetak struktur data untuk memastikan tipe data
print(str(data_training))

# Buat model decision tree menggunakan C5.0
model <- C5.0(Kepuasan ~ Fasilitas + Harga + Lokasi + Pelayanan, data = data_training)

# Prediksi dengan model
prediksi <- predict(model, data_testing)

# Tambahkan hasil prediksi ke data testing
data_testing$Prediksi_Kepuasan <- prediksi

# Tampilkan hasil prediksi
print(data_testing)

# Prediksi Data Training dengan model
prediksi_training <- predict(model, data_training)

# Tambahkan hasil prediksi ke data testing
data_training$Prediksi_Kepuasan <- prediksi_training

# Buat confusion matrix
confusion_matrix <- table(data_training$Kepuasan, data_training$Prediksi_Kepuasan)

# Tampilkan confusion matrix
print(confusion_matrix)

# Export hasil prediksi data_training ke file Excel
write_xlsx(data_training, "hasil_prediksi_data_training.xlsx")

# Export hasil prediksi data_testing ke file Excel
write_xlsx(data_testing, "hasil_prediksi_data_testing.xlsx")

print("Data berhasil diekspor ke file Excel.")

