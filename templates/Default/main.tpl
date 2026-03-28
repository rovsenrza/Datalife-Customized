<!DOCTYPE html>
<html[available=lostpassword|register] class="page_form_style"[/available]>
<head>
	{headers}
	<meta name="HandheldFriendly" content="true">
	<meta name="format-detection" content="telephone=no">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="default">

	<link rel="shortcut icon" href="{THEME}/images/favicon.ico">
	<link href="{THEME}/css/engine.css" type="text/css" rel="stylesheet">

	<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=DM+Sans:wght@400;500;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css">

	<script>
		tailwind.config = {
			theme: {
				extend: {
					colors: {
						atelier_bg: "#fcf9f5",
						atelier_surface: "#ffffff",
						atelier_primary: "#735a36",
						atelier_secondary: "#615e58",
						atelier_outline: "#d1c5b7",
						atelier_ink: "#1c1c1a",
						atelier_low: "#f6f3ef"
					},
					fontFamily: {
						headline: ["Playfair Display", "serif"],
						body: ["DM Sans", "sans-serif"],
						label: ["DM Mono", "monospace"]
					}
				}
			}
		};
	</script>

	<style>
		.noise-bg { position: relative; }
		.noise-bg::before {
			content: "";
			position: absolute;
			inset: 0;
			background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='f'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23f)'/%3E%3C/svg%3E");
			opacity: .03;
			pointer-events: none;
		}
		.stitch-line {
			background-image: linear-gradient(to right, #d1c5b7 50%, transparent 50%);
			background-size: 8px 1px;
			background-repeat: repeat-x;
			background-position: bottom;
		}
		.ml-switcher { position: relative; }
		.ml-switcher__menu {
			display: none;
			position: absolute;
			right: 0;
			top: calc(100% + 8px);
			background: #fff;
			border: 1px solid #d1c5b7;
			min-width: 110px;
			z-index: 70;
		}
		.ml-switcher.open .ml-switcher__menu { display: block; }
		.ml-switcher__menu li { list-style: none; margin: 0; padding: 0; }
		.ml-switcher__menu a {
			display: block;
			padding: 8px 12px;
			font-family: "DM Mono", monospace;
			font-size: 12px;
			color: #1c1c1a;
			text-decoration: none;
		}
		.ml-switcher__menu a:hover { background: #f6f3ef; }
		.ml-switcher__menu .is-active {
			background: #735a36;
			color: #fff;
		}
		.ml-switcher__menu .active a,
		.ml-switcher__menu .current a {
			background: #735a36;
			color: #fff;
		}
		.dle-filters .dle-filter-item,
		.dle-filters .dle-filters-item > div,
		.dle-filters .dle-filters-item > section {
			background: #fff;
			border: 1px solid #d1c5b7;
			padding: 14px;
		}
		.dle-filters label {
			display: block;
			font-family: "DM Mono", monospace;
			font-size: 11px;
			text-transform: uppercase;
			letter-spacing: .08em;
			color: #615e58;
			margin-bottom: 8px;
		}
		.dle-filters input,
		.dle-filters select,
		.dle-filters textarea {
			width: 100%;
			border: 1px solid #d1c5b7;
			background: #fff;
			padding: 8px 10px;
			color: #1c1c1a;
		}
		.dle-filters input[type="checkbox"],
		.dle-filters input[type="radio"] {
			width: auto;
			margin-right: 8px;
		}
		.auto-content img {
			max-width: 100%;
			height: auto;
		}
		@media (max-width: 1023px) {
			.auto-nav { display: none; }
			.auto-nav.open {
				display: flex;
				position: absolute;
				top: calc(100% + 10px);
				left: 0;
				right: 0;
				z-index: 70;
				background: #fff;
				border: 1px solid #d1c5b7;
				padding: 14px;
				flex-direction: column;
				gap: 10px;
			}
		}
	</style>
</head>
<body class="bg-atelier_bg text-atelier_ink font-body selection:bg-[#e2c195]/40">
	[not-available=lostpassword|register]
	<div class="min-h-screen">
		<header class="fixed top-0 inset-x-0 z-50 bg-white/85 backdrop-blur-md border-b border-[#d1c5b7]/60">
			<div class="max-w-7xl mx-auto px-4 md:px-8 py-4 relative">
				<div class="flex items-center justify-between gap-4">
					<div class="flex items-center gap-4 lg:gap-8">
						<a class="font-headline text-2xl font-bold tracking-tight text-atelier_ink" href="/">✦ STITCHES</a>
						<button id="menuToggle" class="lg:hidden inline-flex items-center justify-center w-9 h-9 border border-atelier_outline text-atelier_ink" type="button" aria-label="Menu">
							<span class="material-symbols-outlined text-xl">menu</span>
						</button>
						<nav id="autoNav" class="auto-nav lg:flex lg:items-center lg:gap-8 font-headline text-[17px]">
							<a class="text-atelier_ink hover:text-atelier_primary transition-colors" href="/haqqimizda.html">{lang_about}</a>
							<a class="text-atelier_ink hover:text-atelier_primary transition-colors" href="/sedan/">{lang_cat_sedan}</a>
							<a class="text-atelier_ink hover:text-atelier_primary transition-colors" href="/xecbek/">{lang_cat_hatchback}</a>
							<a class="text-atelier_ink hover:text-atelier_primary transition-colors" href="/suv/">{lang_cat_suv}</a>
							<a class="text-atelier_ink hover:text-atelier_primary transition-colors" href="/avto-blog/">{lang_blog}</a>
							<a class="text-atelier_ink hover:text-atelier_primary transition-colors" href="/contact/">{lang_contact}</a>
						</nav>
					</div>
					<div class="flex items-center gap-2 md:gap-3">
						<form class="hidden md:flex items-center border border-atelier_outline bg-white" action="/search/" method="get">
							<input class="h-10 w-48 border-0 bg-transparent text-sm focus:ring-0" name="story" placeholder="{lang_search_placeholder}" type="search">
							<input type="hidden" name="do" value="search">
							<input type="hidden" name="subaction" value="search">
							<button class="inline-flex items-center justify-center px-3 h-10 text-xs font-label uppercase tracking-wider text-atelier_primary" type="submit">{lang_find}</button>
						</form>
						<div class="hidden md:block">{multilanguage}</div>
						<button id="requestOpen" class="inline-flex items-center justify-center h-10 px-4 md:px-5 bg-atelier_primary text-white text-xs font-label uppercase tracking-wider" type="button">{lang_request}</button>
					</div>
				</div>
				<div class="mt-3 md:hidden">
					<form class="flex items-center border border-atelier_outline bg-white" action="/search/" method="get">
						<input class="h-10 flex-1 border-0 bg-transparent text-sm focus:ring-0" name="story" placeholder="{lang_search_placeholder}" type="search">
						<input type="hidden" name="do" value="search">
						<input type="hidden" name="subaction" value="search">
						<button class="inline-flex items-center justify-center px-3 h-10 text-xs font-label uppercase tracking-wider text-atelier_primary" type="submit">{lang_find}</button>
					</form>
					<div class="mt-3 md:hidden">{multilanguage}</div>
				</div>
			</div>
		</header>

		[available=main]
		<main class="pt-32 md:pt-28">
			<section class="max-w-7xl mx-auto px-4 md:px-8 pb-16 md:pb-20">
				<div class="grid lg:grid-cols-2 gap-8 lg:gap-12 items-center">
					<div>
						<p class="font-label text-[11px] uppercase tracking-[0.22em] text-atelier_secondary mb-5">{lang_hero_kicker}</p>
						<h1 class="font-headline text-4xl md:text-6xl leading-[1.1] mb-5">{lang_hero_title}</h1>
						<p class="text-atelier_secondary text-lg leading-relaxed mb-8 max-w-xl">{lang_hero_subtitle}</p>
						<div class="flex flex-wrap gap-3">
							<a class="inline-flex items-center px-6 h-11 bg-atelier_primary text-white text-xs font-label uppercase tracking-wider" href="/sedan/">{lang_hero_btn_primary}</a>
							<a class="inline-flex items-center px-6 h-11 border border-atelier_primary text-atelier_primary text-xs font-label uppercase tracking-wider" href="/haqqimizda.html">{lang_hero_btn_secondary}</a>
						</div>
					</div>
					<div class="relative">
						<div class="swiper auto-hero-swiper bg-atelier_low border border-atelier_outline/50">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<div class="aspect-[4/5] lg:aspect-[5/6]">
										<img class="w-full h-full object-cover" src="{THEME}/images/tmp/slide_1.jpg" alt="{lang_hero_title}">
									</div>
								</div>
								<div class="swiper-slide">
									<div class="aspect-[4/5] lg:aspect-[5/6]">
										<img class="w-full h-full object-cover" src="{THEME}/images/tmp/slide_2.jpg" alt="{lang_hero_title_2}">
									</div>
								</div>
								<div class="swiper-slide">
									<div class="aspect-[4/5] lg:aspect-[5/6]">
										<img class="w-full h-full object-cover" src="{THEME}/images/tmp/slide_3.jpg" alt="{lang_hero_title_3}">
									</div>
								</div>
							</div>
							<div class="swiper-pagination"></div>
						</div>
						<div class="hidden md:block absolute -left-5 -bottom-5 w-24 h-24 border-l border-b border-dashed border-atelier_outline"></div>
					</div>
				</div>
			</section>

			<section class="max-w-7xl mx-auto px-4 md:px-8 pb-16 md:pb-20">
				<div class="grid sm:grid-cols-2 xl:grid-cols-4 gap-4">
					<div class="noise-bg bg-white border border-atelier_outline/70 p-5 stitch-line">
						<p class="font-label text-xs tracking-wider uppercase text-atelier_secondary mb-2">01</p>
						<h3 class="font-headline text-2xl mb-2">{lang_adv_1_title}</h3>
						<p class="text-sm text-atelier_secondary leading-relaxed">{lang_adv_1_text}</p>
					</div>
					<div class="noise-bg bg-white border border-atelier_outline/70 p-5 stitch-line">
						<p class="font-label text-xs tracking-wider uppercase text-atelier_secondary mb-2">02</p>
						<h3 class="font-headline text-2xl mb-2">{lang_adv_2_title}</h3>
						<p class="text-sm text-atelier_secondary leading-relaxed">{lang_adv_2_text}</p>
					</div>
					<div class="noise-bg bg-white border border-atelier_outline/70 p-5 stitch-line">
						<p class="font-label text-xs tracking-wider uppercase text-atelier_secondary mb-2">03</p>
						<h3 class="font-headline text-2xl mb-2">{lang_adv_3_title}</h3>
						<p class="text-sm text-atelier_secondary leading-relaxed">{lang_adv_3_text}</p>
					</div>
					<div class="noise-bg bg-white border border-atelier_outline/70 p-5 stitch-line">
						<p class="font-label text-xs tracking-wider uppercase text-atelier_secondary mb-2">04</p>
						<h3 class="font-headline text-2xl mb-2">{lang_adv_4_title}</h3>
						<p class="text-sm text-atelier_secondary leading-relaxed">{lang_adv_4_text}</p>
					</div>
				</div>
			</section>

			<section class="max-w-7xl mx-auto px-4 md:px-8 pb-16 md:pb-20">
				<div class="grid lg:grid-cols-[1.2fr_1fr] gap-8 border border-atelier_outline/60 bg-white">
					<div class="p-6 md:p-10 border-b lg:border-b-0 lg:border-r border-dashed border-atelier_outline/80">
						<p class="font-label text-[11px] uppercase tracking-[0.2em] text-atelier_secondary mb-4">{lang_editorial_kicker}</p>
						<h2 class="font-headline text-3xl md:text-5xl leading-tight mb-4">{lang_editorial_title}</h2>
						<p class="text-atelier_secondary leading-relaxed">{lang_editorial_text}</p>
					</div>
					<div class="p-6 md:p-10 bg-atelier_low">
						<h3 class="font-headline text-2xl mb-4">{lang_hero_title_2}</h3>
						<p class="text-atelier_secondary leading-relaxed">{lang_hero_subtitle_2}</p>
					</div>
				</div>
			</section>

			<section class="max-w-7xl mx-auto px-4 md:px-8 pb-16 md:pb-20">
				<div class="flex items-end justify-between gap-4 mb-6">
					<h2 class="font-headline text-3xl md:text-5xl">{lang_cat_sedan}</h2>
					<a class="font-label text-xs uppercase tracking-wider text-atelier_primary" href="/sedan/">{lang_view_all}</a>
				</div>
				<div class="swiper auto-products-swiper" id="products-sedan">
					<div class="swiper-wrapper">
						{custom category="4" template="shortstory-products" available="global" from="0" limit="8" order="date" sort="desc" cache="no"}
					</div>
					<div class="swiper-pagination"></div>
				</div>
			</section>

			<section class="max-w-7xl mx-auto px-4 md:px-8 pb-16 md:pb-20">
				<div class="flex items-end justify-between gap-4 mb-6">
					<h2 class="font-headline text-3xl md:text-5xl">{lang_cat_hatchback}</h2>
					<a class="font-label text-xs uppercase tracking-wider text-atelier_primary" href="/xecbek/">{lang_view_all}</a>
				</div>
				<div class="swiper auto-products-swiper" id="products-hatchback">
					<div class="swiper-wrapper">
						{custom category="5" template="shortstory-products" available="global" from="0" limit="8" order="date" sort="desc" cache="no"}
					</div>
					<div class="swiper-pagination"></div>
				</div>
			</section>

			<section class="max-w-7xl mx-auto px-4 md:px-8 pb-16 md:pb-20">
				<div class="flex items-end justify-between gap-4 mb-6">
					<h2 class="font-headline text-3xl md:text-5xl">{lang_cat_suv}</h2>
					<a class="font-label text-xs uppercase tracking-wider text-atelier_primary" href="/suv/">{lang_view_all}</a>
				</div>
				<div class="swiper auto-products-swiper" id="products-suv">
					<div class="swiper-wrapper">
						{custom category="6" template="shortstory-products" available="global" from="0" limit="8" order="date" sort="desc" cache="no"}
					</div>
					<div class="swiper-pagination"></div>
				</div>
			</section>

			<section class="max-w-7xl mx-auto px-4 md:px-8 pb-16 md:pb-20">
				<div class="flex items-end justify-between gap-4 mb-6">
					<h2 class="font-headline text-3xl md:text-5xl">{lang_blog}</h2>
					<a class="font-label text-xs uppercase tracking-wider text-atelier_primary" href="/avto-blog/">{lang_view_all}</a>
				</div>
				<div class="grid md:grid-cols-2 xl:grid-cols-4 gap-5">
					{custom category="7" template="shortstory-blog" available="global" from="0" limit="4" order="date" sort="desc" cache="no"}
				</div>
			</section>
		</main>
		[/available]

		[not-available=main]
		<main class="pt-32 md:pt-28">
			<section class="max-w-7xl mx-auto px-4 md:px-8 pb-8">
				<div class="border border-atelier_outline/60 bg-atelier_low p-6">
					[category=4,5,6]{filter}[/category]
					<div class="auto-content mt-4">
						{info}
						{content}
					</div>
				</div>
			</section>
		</main>
		[/not-available]

		<section class="max-w-7xl mx-auto px-4 md:px-8 pb-16">
			<div class="bg-white border border-atelier_outline/70 p-6 md:p-10">
				<div class="grid md:grid-cols-[1.3fr_auto] gap-5 items-center">
					<div>
						<h3 class="font-headline text-3xl md:text-4xl mb-3">{lang_cta_title}</h3>
						<p class="text-atelier_secondary">{lang_cta_text}</p>
					</div>
					<div class="flex flex-wrap gap-3">
						<a class="inline-flex items-center justify-center h-11 px-5 bg-atelier_primary text-white text-xs font-label uppercase tracking-wider" href="https://wa.me/994000000000" target="_blank" rel="nofollow noopener">WhatsApp</a>
						<a class="inline-flex items-center justify-center h-11 px-5 border border-atelier_primary text-atelier_primary text-xs font-label uppercase tracking-wider" href="https://t.me/example" target="_blank" rel="nofollow noopener">Telegram</a>
					</div>
				</div>
			</div>
		</section>

		<footer class="border-t border-atelier_outline/70 bg-white">
			<div class="max-w-7xl mx-auto px-4 md:px-8 py-8 md:py-10 flex flex-col md:flex-row items-start md:items-center justify-between gap-3">
				<div>
					<p class="font-headline text-xl">✦ STITCHES</p>
					<p class="text-sm text-atelier_secondary mt-1">{lang_footer_note}</p>
				</div>
				<p class="text-xs font-label uppercase tracking-wider text-atelier_secondary">© {date=Y} STITCHES</p>
			</div>
		</footer>
	</div>

	<div id="requestModal" class="fixed inset-0 z-[100] hidden items-center justify-center bg-black/40 px-4">
		<div class="w-full max-w-xl bg-white border border-atelier_outline">
			<div class="px-5 py-4 border-b border-atelier_outline flex items-start justify-between gap-4">
				<div>
					<h4 class="font-headline text-2xl leading-tight">{lang_request_title}</h4>
					<p class="text-sm text-atelier_secondary mt-1">{lang_request_intro}</p>
				</div>
				<button id="requestClose" type="button" class="material-symbols-outlined text-atelier_secondary hover:text-atelier_primary">close</button>
			</div>
			<form method="post" action="/contact/">
				<div class="p-5 grid gap-4">
					<div>
						<label class="block font-label text-xs uppercase tracking-wider text-atelier_secondary mb-2">{lang_form_name}</label>
						<input class="w-full border border-atelier_outline focus:border-atelier_primary focus:ring-0" type="text" name="name" required>
					</div>
					<div>
						<label class="block font-label text-xs uppercase tracking-wider text-atelier_secondary mb-2">{lang_form_phone}</label>
						<input class="w-full border border-atelier_outline focus:border-atelier_primary focus:ring-0" type="text" name="xfield[phone]" required>
					</div>
					<div>
						<label class="block font-label text-xs uppercase tracking-wider text-atelier_secondary mb-2">{lang_form_model}</label>
						<input class="w-full border border-atelier_outline focus:border-atelier_primary focus:ring-0" type="text" name="subject" required>
					</div>
					<div>
						<label class="block font-label text-xs uppercase tracking-wider text-atelier_secondary mb-2">{lang_form_message}</label>
						<textarea class="w-full border border-atelier_outline focus:border-atelier_primary focus:ring-0" name="message" rows="4" required></textarea>
					</div>
				</div>
				<div class="px-5 py-4 border-t border-atelier_outline flex items-center justify-end gap-3">
					<button id="requestCancel" type="button" class="h-10 px-4 border border-atelier_outline text-xs font-label uppercase tracking-wider">{lang_close}</button>
					<button type="submit" class="h-10 px-4 bg-atelier_primary text-white text-xs font-label uppercase tracking-wider">{lang_send_request}</button>
				</div>
			</form>
		</div>
	</div>
	[/not-available]

	[available=lostpassword|register]
	<div class="min-h-screen bg-atelier_bg flex items-center justify-center px-4 py-10">
		<div class="w-full max-w-lg bg-white border border-atelier_outline p-6 md:p-8">
			<a class="inline-flex items-center text-sm text-atelier_secondary hover:text-atelier_primary mb-4" href="/">{lang_back_to_homepage}</a>
			{info}
			{content}
		</div>
	</div>
	[/available]

	{AJAX}
	<script src="{THEME}/js/lib.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
	<script>
	(function() {
		var menuToggle = document.getElementById('menuToggle');
		var autoNav = document.getElementById('autoNav');
		if (menuToggle && autoNav) {
			menuToggle.addEventListener('click', function() {
				autoNav.classList.toggle('open');
			});
		}

		var switchers = document.querySelectorAll('.ml-switcher');
		switchers.forEach(function(sw) {
			var btn = sw.querySelector('.ml-switcher__btn');
			if (!btn) return;
			btn.addEventListener('click', function(e) {
				e.preventDefault();
				e.stopPropagation();
				sw.classList.toggle('open');
			});
		});
		document.addEventListener('click', function() {
			switchers.forEach(function(sw) { sw.classList.remove('open'); });
		});

		var modal = document.getElementById('requestModal');
		var requestOpen = document.getElementById('requestOpen');
		var requestClose = document.getElementById('requestClose');
		var requestCancel = document.getElementById('requestCancel');

		function closeModal() {
			if (!modal) return;
			modal.classList.add('hidden');
			modal.classList.remove('flex');
			document.body.classList.remove('overflow-hidden');
		}
		function openModal() {
			if (!modal) return;
			modal.classList.remove('hidden');
			modal.classList.add('flex');
			document.body.classList.add('overflow-hidden');
		}

		if (requestOpen) requestOpen.addEventListener('click', openModal);
		if (requestClose) requestClose.addEventListener('click', closeModal);
		if (requestCancel) requestCancel.addEventListener('click', closeModal);
		if (modal) {
			modal.addEventListener('click', function(e) {
				if (e.target === modal) closeModal();
			});
		}
		document.addEventListener('keydown', function(e) {
			if (e.key === 'Escape') closeModal();
		});

		if (typeof Swiper !== 'undefined') {
			new Swiper('.auto-hero-swiper', {
				loop: true,
				autoplay: { delay: 4200 },
				pagination: { el: '.auto-hero-swiper .swiper-pagination', clickable: true }
			});

			document.querySelectorAll('.auto-products-swiper').forEach(function(el) {
				new Swiper(el, {
					loop: false,
					spaceBetween: 16,
					slidesPerView: 1,
					pagination: {
						el: el.querySelector('.swiper-pagination'),
						clickable: true
					},
					breakpoints: {
						640: { slidesPerView: 2 },
						1024: { slidesPerView: 3 },
						1280: { slidesPerView: 4 }
					}
				});
			});
		}
	})();
	</script>
</body>
</html>
