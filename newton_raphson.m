%NEWTON-RAPHSON
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

% Kullanıcıdan istenen değerleri almak
x0 = input('Başlangıç değeri için bir değer atayın. (0 seçmeyiniz):');
    while x0 == 0
        disp('Başlangıç değeri olarak 0 girilemez. Lütfen başka bir değer giriniz.');
        x0 = input('Başlangıç değeri için bir değer atayın. (0 seçmeyiniz):');
    end
minerror = input('Minimum hata değerini yazınız. (% olmadan yazınız..):');
iterasyon = input('Kaç iterasyon hesaplanacağını seçiniz.');

% Seçilen fonksiyonun türevi.
diff = @(x) 7*x.^6 + 5*x.^4;

% Newton-Raphson Algoritması.

x = x0; % x0 değeri x'e atanır.
prev_x = x0; % Önceki tahmin başlangıçta x0 olarak ayarlanır.

errors = []; % Hataları saklamak için boş bir dizi oluşturur

for i = 1:iterasyon % Girilen iterasyon sayısı kadar döngü çalıştırır
    x_new = x - (f(x) / diff(x)); % Newton-Raphson formülü ile yeni tahmin hesaplanır
    
    % Hata hesaplanır (yaklaşık hata)
    error = abs((x_new - x) / x_new) * 100; % Yaklaşık hata yüzde olarak hesaplanır
    errors(i) = error; % Hataları diziye ekler
    
    % Sonuçları ekrana yazdır
    fprintf('İterasyon %d: Kök tahmini = %.10f, Hata = %.10f%%\n', i, x_new, error);
    
    % Minimum hata değerini karşılayıp karşılamadığını kontrol edin
    if error < minerror || error == 0 % Eğer hata toleransı kabul edilebilir bir seviyede veya sıfır ise
        break; % Döngüyü sonlandır
    end
    
    % Yeni tahminler için güncelleme
    x = x_new; % Yeni tahmini mevcut tahmin olarak atar
end

% Grafik üzerinde tahmini kökü göstermek
hold on; % Mevcut grafiği korur
plot(x_new, f(x_new), 'ro'); % Tahmini kökü kırmızı daire ile gösterir

% Grafik üzerinde hataları göster
figure; % Yeni bir grafik penceresi oluşturur
plot(1:i, errors, '-o'); % Hataları grafiğe çizer
xlabel('İterasyon'); % x ekseninin etiketini belirler
ylabel('Hata (%)'); % y ekseninin etiketini belirler
title('Hataların İterasyona Göre Değişimi (%)'); % Grafiğin başlığını belirler
