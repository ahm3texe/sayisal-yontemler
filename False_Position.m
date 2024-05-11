%FALSE-POSITION (REGULA FALSI)
clc; % Console temizler

% Seçilen Fonksiyon
f = @(x) x.^7 + x.^5 - 15;

% Fonksiyonun Grafiğini çizecek olan kod satırı.
x = -50:0.5:50; % -50'den 50'ye kadar 0.5 aralıkla değer alır
y = f(x); % Grafiği çizilecek fonksiyon
plot(x, y); % Seçilen x ve y değerlerini grafiğe çizer.
xlabel('x'); % x ekseni için başlık
ylabel('f(x)'); % y ekseni için başlık
title('Grafik: f(x) = x^7 + x^5 - 15'); % Grafiğin Başlığı
grid on; % Grafiğin üzerine eşit kareler ekler 

% Kullanıcıdan başlangıç değerleri alınır.
xl = input('Aralığın başlangıç değerini giriniz (xl): ');
xu = input('Aralığın bitiş değerini giriniz (xu): ');
minerror = input('Minimum hata yüzdelik değerini yazınız. (% işareti kullanmayınız): ');
iterasyon = input('Kaç iterasyon hesaplanacağını seçiniz: ');

prev_x = xu; % İlk başta önceki x değeri xu olarak ayarlanır
errors = []; % Hataları saklamak için boş bir dizi oluşturulur

% Regula Falsi Algoritması
for i = 1:iterasyon
    fxl = f(xl);
    fxu = f(xu);
    x_new = xu - (fxu * (xl - xu) / (fxl - fxu)); % Regula Falsi formülü
    fx_new = f(x_new);
    
    % Hata hesaplanır (yaklaşık hata)
    error = abs((x_new - prev_x) / x_new) * 100;
    errors(i) = error; % Hataları diziye ekler
    
    % Sonuçları ekrana yazdır
    fprintf('İterasyon %d: Kök tahmini = %.10f, Hata = %.10f%%\n', i, x_new, error);
    
    % Minimum hata değerini karşılayıp karşılamadığını kontrol edin
    if error < minerror || error == 0 % Eğer hata toleransı kabul edilebilir bir seviyede veya sıfır ise
        break; % Döngüyü sonlandır
    end
    
    % Yeni Kökü Seçmek İçin Yapılacak Hesap
    if fxl * fx_new < 0 % eğer f(xl) * f(xr) 0 dan küçük ise
        xu = x_new; % xu yeni xr olur
    else 
        xl = x_new; % küçük değilse xl yeni xr olur
    end
    
    prev_x = x_new; % x_new'i önceki x olarak günceller
end

% Grafik üzerinde tahmini kökü göster
hold on;
plot(x_new, fx_new, 'ro'); % Tahmini kökü kırmızı daire ile gösterir

% Grafik üzerinde hataları göster
figure; % Yeni bir grafik penceresi oluşturur
plot(1:i, errors, '-o'); % Hataları grafiğe çizer
xlabel('İterasyon'); % x ekseninin etiketini belirler
ylabel('Hata (%)'); % y ekseninin etiketini belirler
title('Hataların İterasyona Göre Değişimi (%)'); % Grafiğin başlığını belirler

