<article class="max-w-7xl mx-auto px-4 md:px-8 py-8 md:py-10">
	<nav class="mb-6">
		<ol class="flex items-center gap-2 text-[11px] font-label uppercase tracking-[0.16em] text-atelier_secondary">
			<li><a class="hover:text-atelier_primary transition-colors" href="/">{home}</a></li>
			<li>/</li>
			<li>{link-category}</li>
		</ol>
	</nav>
	<div class="grid lg:grid-cols-[1.05fr_.95fr] gap-8 lg:gap-12">
		<section>
			<div class="bg-white border border-atelier_outline/70 overflow-hidden">
				<div class="aspect-[4/5] bg-atelier_low">
					<img class="w-full h-full object-cover" src="{image-1}" alt="{title}" onerror="this.onerror=null;this.src='https://placehold.co/980x1200/f6f3ef/6b5e4b?text=STITCHES';">
				</div>
			</div>
		</section>
		<section>
			<p class="font-label text-[11px] uppercase tracking-[0.16em] text-atelier_secondary mb-3">{date=d.m.Y}</p>
			<h1 class="font-headline text-4xl md:text-5xl leading-tight mb-4">{title}</h1>
			<div class="text-sm text-atelier_secondary mb-6">{author}</div>

			<div class="grid sm:grid-cols-2 gap-3 mb-6">
				[xfgiven_price]<div class="bg-white border border-atelier_outline/60 p-3"><p class="font-label text-[11px] uppercase tracking-[0.16em] text-atelier_secondary mb-1">{lang_label_price}</p><p class="text-lg">{xfvalue_price}</p></div>[/xfgiven_price]
				[xfgiven_product_type]<div class="bg-white border border-atelier_outline/60 p-3"><p class="font-label text-[11px] uppercase tracking-[0.16em] text-atelier_secondary mb-1">{lang_label_type}</p><p class="text-lg">{xfvalue_product_type}</p></div>[/xfgiven_product_type]
				[xfgiven_color]<div class="bg-white border border-atelier_outline/60 p-3"><p class="font-label text-[11px] uppercase tracking-[0.16em] text-atelier_secondary mb-1">{lang_label_color}</p><p class="text-lg">{xfvalue_color}</p></div>[/xfgiven_color]
				[xfgiven_fuel]<div class="bg-white border border-atelier_outline/60 p-3"><p class="font-label text-[11px] uppercase tracking-[0.16em] text-atelier_secondary mb-1">{lang_label_fuel}</p><p class="text-lg">{xfvalue_fuel}</p></div>[/xfgiven_fuel]
			</div>

			<div class="auto-content text-atelier_ink leading-relaxed mb-8">
				{full-story}
			</div>

			<div class="flex flex-wrap gap-3">
				<button type="button" id="requestOpenFromDetail" class="inline-flex items-center justify-center h-11 px-5 bg-atelier_primary text-white text-xs font-label uppercase tracking-wider">{lang_request}</button>
				<a href="/contact/" class="inline-flex items-center justify-center h-11 px-5 border border-atelier_primary text-atelier_primary text-xs font-label uppercase tracking-wider">{lang_contact}</a>
			</div>
		</section>
	</div>

	{pages}

	[banner_header]
	<div class="mt-8 bg-white border border-atelier_outline/70 p-4">
		{banner_header}
	</div>
	[/banner_header]
</article>

<div class="max-w-7xl mx-auto px-4 md:px-8 pb-12">
	[comments]
	<div class="bg-white border border-atelier_outline/70 p-5 md:p-7 mb-4">
		<h3 class="font-headline text-3xl mb-4">{lang_comments} <span class="text-atelier_secondary">{comments-num}</span></h3>
		<div class="auto-content">{comments}</div>
	</div>
	[/comments]
	{navigation}
	<div class="bg-white border border-atelier_outline/70 p-5 md:p-7">{addcomments}</div>
</div>

<script>
(function(){
	var btn = document.getElementById('requestOpenFromDetail');
	var mainBtn = document.getElementById('requestOpen');
	if (btn && mainBtn) {
		btn.addEventListener('click', function(){ mainBtn.click(); });
	}
})();
</script>
