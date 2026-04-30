# INUFEST Akıllı Kütüphane ve Merkeziyetsiz Rezervasyon Sistemi

Bu proje, öğrencilerin kütüphane masalarını rezerve edebildiği, blockchain teknolojisi (Solidity akıllı kontratları) ile donatılmış merkeziyetsiz bir altyapıya sahip, uçtan uca güvenli bir kampüs erişim ve yönetim sistemidir.

## 📁 Proje Yapısı

Proje, temel olarak iki ana bileşenden (ve ileride eklenecek bir arayüzden) oluşmaktadır:

```text
inufesttt/
├── library/            # Spring Boot (Java) Backend ve Güvenlik Servisleri
├── contracts/          # Solidity (Ethereum/Polygon) Akıllı Kontratları
└── README.md           # Bu dosya
```

### 1. `library` (Backend)
- **Teknolojiler:** Java 17, Spring Boot 3, Spring Security, JWT, PostgreSQL, Hibernate/JPA.
- **Özellikler:**
  - Kullanıcı doğrulama ve yetkilendirme (JWT bazlı uçtan uca güvenlik).
  - Masa rezervasyon yönetim servisleri.
  - Analitik loglama (`UsageLog` tablosu).
  - Veritabanı başlangıç verileri otomatik olarak oluşturulmaktadır (Örn: Berfin KUŞ, Gamze POLAT, Nisa DANIŞ, vb.).
  - Arayüz (Frontend) entegrasyonu için genel `CORS` ayarları yapılmıştır. Localhost portlarından gelen istekleri kabul eder.

### 2. `contracts` (Blockchain / Akıllı Kontrat)
- **Teknolojiler:** Solidity, Chainlink Automation.
- **Özellikler:**
  - `DecentralizedReservation.sol`: Masaların adil ve değiştirilemez bir şekilde rezerve edilmesi.
  - 15 dakikalık zaman aşımı (timeout) kontrolü (Zincir dışı otomasyon).

---

## 🚀 Kurulum ve Çalıştırma

### Backend (Spring Boot) Kurulumu

1. **Veritabanı Ayarları (Supabase):**
   Projemiz veritabanı olarak **Supabase** (PostgreSQL) kullanmaktadır. GitHub'a şifre sızdırmamak için `application.yml` dosyasında ortam değişkenleri (Environment Variables) kullanılmıştır.
   Kendi bilgisayarınızda projeyi çalıştırırken IDE'nizin (IntelliJ, Eclipse vb.) "Environment Variables" kısmına veya sisteminize şu değişkenleri eklemelisiniz:

   - `SUPABASE_DB_URL`: Supabase JDBC Connection String (Örn: `jdbc:postgresql://aws-0-eu-central-1.pooler.supabase.com:5432/postgres`)
   - `SUPABASE_DB_USERNAME`: Supabase veritabanı kullanıcı adı (Genelde `postgres`)
   - `SUPABASE_DB_PASSWORD`: Supabase veritabanı şifreniz

   *(Eğer bu değişkenleri ayarlamazsanız, sistem varsayılan olarak `localhost:5432/akillikutuphane` adresine bağlanmayı dener.)*

2. **Projeyi Derleme ve Çalıştırma:**
   Terminal üzerinden `library` klasörüne gidin ve projeyi çalıştırın:
   ```bash
   cd library
   mvn clean install
   mvn spring-boot:run
   ```
   **Not:** Proje ilk çalıştığında `DataInitializer` devreye girerek örnek kullanıcıları (Berfin KUŞ, vb.) otomatik olarak veritabanına ekleyecektir. Tüm kullanıcıların varsayılan şifresi `password123` olarak ayarlanmıştır.

### Akıllı Kontrat Kurulumu (Geliştirme İçin)

Kontratları Remix IDE veya Hardhat kullanarak test ağına (örn. Sepolia) deploy edebilirsiniz. `DecentralizedReservation` kontratı başlangıçta toplam masa sayısını parametre olarak alır.

---

## 🔒 Güvenlik (Uçtan Uca)

- **JWT Auth:** Kullanıcı giriş yaptığında bir JSON Web Token alır. Tüm korumalı `/api/**` rotaları bu token ile erişilebilir durumdadır (`Authorization: Bearer <token>`).
- **CORS Configuration:** `SecurityConfig.java` içinde tanımlı olan CORS ayarları, frontend (React/Vue) uygulamasının sorunsuzca istek atmasını sağlar (`http://localhost:3000` ve `http://localhost:5173` portlarına varsayılan olarak izin verilmiştir).

## 👥 Ekip (Örnek Kullanıcılar)
- Berfin KUŞ
- Gamze POLAT
- Nisa DANIŞ
- Sueda TOPÇU
- Şermin KUŞ (Admin)

---
*Bu repo INUFEST (Teknofest) projesi için hazırlanmıştır.*
