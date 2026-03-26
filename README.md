# Frontend Integrasiya README (DLE Custom)

Bu sənəd frontend developer-in hazır statik saytını bu DLE layihəsinə inteqrasiya etməsi üçündür.

## 1) Qısa Xülasə

Bu build-də əsas xüsusiyyətlər:
- SEO-friendly URL (alt URL aktivdir)
- Multilanguage infrastrukturu (`Azerbaijan`, `English`, `Russian`)
- Frontend dil switcheri (`{multilanguage}`)
- Fullstory view count aktivdir (hər giriş +1)
- Editor image upload: WebP + max 200KB policy

## 2) Mühit və start

### Lokal mühit
- PHP + MySQL (MAMP)
- Web root: layihə qovluğu
- DB config: `engine/data/dbconfig.php`
- Core config: `engine/data/config.php`

### Əsas config yoxlaması
`engine/data/config.php` içində:
- `'http_home_url'` düzgün domain olmalıdır
- `'allow_alt_url' => '1'`
- `'seo_type' => '2'`
- `'main_language'` mövcud dillərdən biri olmalıdır
- `'multilanguage_prefix'`:
  - `1` => dil prefix-li URL (`/az/...`, `/en/...`, `/ru/...`)
  - `0` => default dil prefixsiz, digər dillər prefix-li

## 3) Template xəritəsi (frontend üçün)

Əsas layout faylları:
- `templates/Default/main.tpl` -> ümumi skelet
- `templates/Default/navigation.tpl` -> pagination
- `templates/Default/fullstory.tpl` -> detail page
- `templates/Default/shortstory.tpl` -> listing item
- `templates/Default/static.tpl` -> statik səhifə
- `templates/Default/modules/*.tpl` -> header/footer/yan bloklar

Praktik inteqrasiya qaydası:
1. Hazır statik HTML layout-u `main.tpl`-ə köçür.
2. Reusable hissələri `modules/` altına böl:
   - topmenu, header, footer, sidebar və s.
3. List/detail markup-u uyğun olaraq `shortstory.tpl` və `fullstory.tpl`-də yerləşdir.
4. CTA, contact form, modal və digər UI hissələri `main.tpl` + uyğun modul tpl-lərdə saxla.

## 4) Multilanguage istifadə qaydası

### Dil faylları
- `language/Azerbaijan/template_language.lng`
- `language/English/template_language.lng`
- `language/Russian/template_language.lng`

Template daxilində dil key istifadə:
- `{lang key="home_title"}` formatı ilə (mövcud parser məntiqinə uyğun)
- Mövcud `{multilanguage}` tag-i ilə dil dropdown render olunur.

Admin tərəfdə əsas dil:
- `main_language` dəyişdikdə frontend default dili dəyişir.

## 5) URL və SEO qaydaları

- Public URL-lər alt URL rejimində işləyir.
- Canonical/hreflang məntiqi core-da aktivdir.
- Legacy query route-lar mümkün olduqca canonical route-a yönlənməlidir.
- Sitemap hazırda `uploads/sitemap.xml` üzərindən verilir.

Tövsiyə:
- Menyuda hardcoded `index.php?do=...` linkləri istifadə etmə.
- Mümkün olduqca SEO path və ya sistem token-ları istifadə et.

## 6) Kontent modelinə uyğun frontend mapping

Sənin saytda varsa:
- Statik səhifələr -> `static.tpl`
- Kateqoriya + məhsul/post listing -> `shortstory.tpl` + category pages
- Product/detail page -> `fullstory.tpl`
- Search -> sistem search route-ları
- Contact + sendmail CTA -> `do=feedback` route-u ilə inteqrasiya

## 7) Editor upload davranışı (vacib)

Admin editor upload-u üçün:
- Şəkillər WebP formatına çevrilir
- Məcburi ölçü limiti: max 200KB
- Limit altına düşməzsə upload reject olunur

Bu policy performans və page speed üçün məqsədli saxlanılıb.

## 8) Deploy checklist

Canlıya çıxmadan əvvəl:
1. `engine/data/config.php` içində `http_home_url` production domain olsun.
2. `.htaccess` rewrite aktiv olsun.
3. `uploads/` write permission düzgün olsun.
4. Admin login + add/edit news + static page + category CRUD test et.
5. `/az`, `/en`, `/ru` (və ya seçilmiş rejim) URL-ləri yoxla.
6. `uploads/sitemap.xml` açılıb URL-lərin 200 qaytardığını yoxla.
7. Search, contact form, register, lostpassword route-larını smoke-test et.

## 9) Tez-tez rast gəlinən problemlər

### Problem: Frontend açılmır / 404
- `http_home_url` yanlış ola bilər
- `.htaccess` rewrite işləmir
- `allow_alt_url` söndürülüb

### Problem: Dil switch işləmir
- `main_language` və `langs` uyğunsuz ola bilər
- `language/*/template_language.lng` key-ləri natamam ola bilər
- `multilanguage_prefix` gözlənilən rejimdə deyil

### Problem: Upload gecikməsi
- Böyük şəkillər üçün 200KB policy əlavə emal edir
- Storage driver uzaq serverdirsə latency artır
- DB indexləri tətbiq olunub, amma server IO ayrıca yoxlanmalıdır

## 10) Frontend developer üçün minimum iş axını

1. `main.tpl` üzərində layout qur.
2. Komponentləri `modules/*.tpl`-ə parçala.
3. `shortstory.tpl` + `fullstory.tpl` mapping et.
4. `template_language.lng` key-lərini 3 dilə əlavə et.
5. Route və linkləri SEO-compatible saxla.
6. Deploy checklist ilə canlıya çıx.

---

Əgər istəsən növbəti addımda bu README-yə əsasən sənə `integration task checklist` (Jira-style) də çıxardım.
