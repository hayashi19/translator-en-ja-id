import pandas as pd
from collections import Counter
import statistics

# Membaca data dari file CSV
data = pd.read_csv('data.csv')

# Menghapus kolom yang hanya berisi nilai NaN
data = data.dropna(axis=1, how='all')

# Inisialisasi value_mapping untuk setiap kolom
value_mapping = {}

# Loop melalui setiap kolom
for column in data.columns:
    # Mengambil unique values dari kolom
    unique_values = data[column].unique()
    
    # Membuat value_mapping untuk kolom tersebut
    value_mapping[column] = {value: index + 1 for index, value in enumerate(unique_values)}

# Menginisialisasi list untuk menyimpan hasil mean, median, dan mode
results = []

# Loop melalui setiap kolom
for column in data.columns:
    # Mengambil numerical values dari kolom menggunakan value_mapping
    numeric_data = [value_mapping[column][value] for value in data[column] if not pd.isna(value)]
    
    # Jika semua data adalah NaN, atur numeric_data menjadi kosong
    if len(numeric_data) == 0:
        numeric_data = []
    
    # Menghitung mean
    mean = sum(numeric_data) / len(numeric_data) if len(numeric_data) > 0 else float('nan')
    
    # Menghitung median
    median = statistics.median(numeric_data) if len(numeric_data) > 0 else float('nan')
    
    # Menghitung mode
    mode = Counter(numeric_data).most_common(2)
    if len(mode) > 0:
        if pd.isna(mode[0][0]):
            mode_value = mode[1][0] if len(mode) > 1 else float('nan')
        else:
            mode_value = mode[0][0]
    else:
        mode_value = float('nan')
    
    # Menambahkan hasil ke list results
    results.append({
        'Column': column,
        'Mean': list(value_mapping[column].keys())[list(value_mapping[column].values()).index(round(mean))] if not pd.isna(mean) else float('nan'),
        'Median': list(value_mapping[column].keys())[list(value_mapping[column].values()).index(median)] if not pd.isna(median) else float('nan'),
        'Mode': list(value_mapping[column].keys())[list(value_mapping[column].values()).index(mode_value)] if not pd.isna(mode_value) else float('nan')
    })

# Menampilkan hasil
for result in results:
    print(f"Column: {result['Column']}")
    print(f"Mean: {result['Mean']}")
    print(f"Median: {result['Median']}")
    print(f"Mode: {result['Mode']}")
    print()
