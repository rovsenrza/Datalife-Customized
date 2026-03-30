# DLE Frontend Integration Guide (Praktik)

Bu sənəd `templates/Default` üçün frontend inteqrasiyanı sürətli və səhvsiz etmək üçündür.

## 1) Main Struktur (`main.tpl`)
- Ana səhifə layout-u `main.tpl`-də qurulur.
- `<head>` hissəsində sistem başlıqları mütləq `{headers}` ilə gəlməlidir.
- Ana səhifə blokları:
```tpl
[available=main]
  ... homepage content ...
[/available]
```
- Ana səhifə xarici bloklar:
```tpl
[not-available=main]
  ... digər səhifələrin container-i ...
[/not-available]
```

## 2) Multilanguage Toggle
- `main.tpl` daxilində `{multilanguage}` yazılır.
- UI markup `templates/Default/multilanguage.tpl` faylından render olunur.

## 3) Post Kartları (`{custom}`)
Kateqoriyadan post çəkmək üçün:
```tpl
{custom category="cate-id" template="template-name" limit="optional" from="optional" to="optional"}
```
İstifadə:
- `template="shortstory-products"` → məhsul kartları
- `template="shortstory-blog"` → blog kartları

## 4) Category Menyu (`{catmenu}`)
- `{catmenu}` çağırışı `catmenu.tpl` ilə render olunur.
- Əsas property-lər:
  - `subcat="only"` → yalnız subcat
  - `subcat="yes"` → main + subcat
  - `id="..."` → lazım olan category/subcategory-ləri seçmək

### `catmenu.tpl` daxilində istifadə olunan dəyişənlər
- `{id}` → category ID
- `{name}` → category adı
- `{url}` → category URL
- `{sub-item}` → subcategory list

### Struktur blokları
- `[root][/root]` → parent list wrapper
- `[item][/item]` → hər category elementinin markup-u

## 5) Main-dən Kənar Səhifə Axını
`[not-available=main]` daxilində adətən bunlar işlədilir:
- `{category-title}`
- `{category-icon}`
- `{category-icon-2}` ... `{category-icon-10}`
- `{category-icons}` (əlavə ikonların vergüllə siyahısı)
- `{info}`
- `{content}`

Category icon blokları:
```tpl
[category-icon]<img src="{category-icon}" alt="">[/category-icon]
[category-icon-2]<img src="{category-icon-2}" alt="">[/category-icon-2]
[not-category-icon-2]...[/not-category-icon-2]
[category-icons]...[/category-icons]
```

`{content}` bu tpl-ləri kontekstə görə gətirir:
- Contact səhifəsi → `feedback.tpl`
- Static səhifələr → `static.tpl`
- Listing postları → `shortstory.tpl` və ya `custom-template.tpl`
- Detail səhifə → `fullstory.tpl`

## 6) Filter (Category Səhifələri)
Məhsul kateqoriyalarında filter çağırışı:
```tpl
[category=4,5,6]{filter}[/category]
```
- Markup `templates/Default/filter.tpl` içindən gəlir.

## 7) Pagination
- Pagination üçün `navigation.tpl` istifadə olunur.

## 8) Search Axını
- Search form adətən `main.tpl` içində olur.
- Axtarış nəticələri `searchresult.tpl` ilə göstərilir.

## 9) XFields Sintaksis (Vacib)
XField çağırışları `[]` ilə yazılır, `{}` ilə yox.

Doğru:
```tpl
[xfvalue_price]
[xfgiven_price]...[/xfgiven_price]
[xfnotgiven_price]...[/xfnotgiven_price]
```

Yanlış:
```tpl
{xfvalue_price}
[not-xfgiven_price]...[/not-xfgiven_price]
```

### Nəyi ifadə edir?
- `[xfvalue_fieldname]`  
  XField-in dəyərini çıxarır.
- `[xfgiven_fieldname]...[/xfgiven_fieldname]`  
  Dəyər varsa içindəki blok görünür.
- `[xfnotgiven_fieldname]...[/xfnotgiven_fieldname]`  
  Dəyər yoxdursa içindəki blok görünür.

### `multifile` XField çağırışı
- `multifile` tipində də əsas çağırış eynidir:
```tpl
[xfvalue_docs]
```
- Bu çağırış nəticədə faylların siyahısını (`<ul class="xfieldfiles ..."><li><a ...`) qaytarır.
- Şərt blokları da eyni qayda ilə işləyir:
```tpl
[xfgiven_docs]
  [xfvalue_docs]
[/xfgiven_docs]

[xfnotgiven_docs]
  Fayl əlavə edilməyib
[/xfnotgiven_docs]
```

## 10) Tez Mapping Cədvəli
- Homepage: `main.tpl` (`[available=main]`)
- Not-main container: `main.tpl` (`[not-available=main]`)
- Category cards: `shortstory.tpl` / custom tpl
- Product cards: `shortstory-products.tpl`
- Blog cards: `shortstory-blog.tpl`
- Detail: `fullstory.tpl`
- Static: `static.tpl`
- Contact: `feedback.tpl`
- Filter: `filter.tpl`
- Lang switcher: `multilanguage.tpl`
- Pagination: `navigation.tpl`
- Search results: `searchresult.tpl`
