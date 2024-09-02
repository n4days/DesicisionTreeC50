# Instal dan muat paket C50 dan readxl jika belum terpasang
if (!require(C50)) {
  install.packages("C50")
  library(C50)
}

if (!require(readxl)) {
  install.packages("readxl")
  library(readxl)
}

# Baca data dari file Excel
data_training <- read_excel("data_penumpang.xlsx", sheet = "Training")
data_testing <- read_excel("data_penumpang.xlsx", sheet = "Testing")

# Konversi kolom 'Kepuasan' menjadi faktor
data_training$Kepuasan <- factor(data_training$Kepuasan)
data_testing$Kepuasan <- factor(data_testing$Kepuasan)

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

# Buat confusion matrix
confusion_matrix <- table(data_testing$Kepuasan, data_testing$Prediksi_Kepuasan)

# Tampilkan confusion matrix
print(confusion_matrix)
