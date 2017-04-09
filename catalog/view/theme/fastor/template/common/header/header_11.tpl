<!-- HEADER
	================================================== -->
<header class="header-type-11">
	<div class="background-header"></div>
	<div class="slider-header">
		<!-- Top of pages -->
		<div id="top" class="<?php if($theme_options->get( 'header_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'header_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'header_layout' ) == 3) { echo 'fixed2';  } else { echo 'fixed'; } ?>">
			<div class="background-top"></div>
			<div class="background">
				<div class="shadow"></div>
				<div class="pattern">

					<div class="top-bar">
						<div class="container">
							<!-- Links -->
							<ul class="menu">
								<li><a href="/compare-products/">Сравнение товаров</a></li>
								<li><a href="/stati/">Статьи на заметку</a></li>
								<li><a href="#">Гарантии и сервис</a></li>
								<li><a href="/delivery/">Доставка и оплата</a></li>
								<li><a href="/contact-us/">Контакты</a></li>
							</ul>
						</div>
					</div>

					<div class="container" style="padding-bottom: 15px">
						<div class="row">
							<!-- Header Left -->
							<div class="col-sm-3" id="header-left">
							     <?php if ($logo) { ?>
							     <!-- Logo -->
									 	<div class="logo" style="padding-top: 12px;"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
							     	<?php } ?>
										</div>
							<!-- Header Center -->
							<div class="col-sm-6" id="header-center">
								<!-- Work shop banner -->
								<div>
									<div class="wsbanner"><span>ДОСТАВКА ПО МОСКВЕ</span><br/>сегодня <span class="wsbold">с 10 до 22</span></div>
									<div class="wsimage"><img src="/image/h2.jpg" alt="ДОСТАВКА"/></div>

									<div class="wsbanner"><span>БЕЗ ВЫХОДНЫХ</span><br/>с <span class="wsbold">9:00</span> до <span class="wsbold">22:00</span></div>
									<div class="wsimage"><img src="/image/h3.jpg" alt="РЕЖИМ"/></div>

									<div class="wsbanner"><span class="wsbold">ГАРАНТИЯ</span><br/>на все товары</div>
									<div class="wsimage"><img src="/image/guard.jpg" alt="ГАРАНТИЯ"/></div>
								</div>
								<!-- Here was Search -->

							</div>

							<!-- Header Right -->
							<div class="col-sm-3" id="header-right">
							     <?php
							     $top_block = $modules->getModules('top_block');
							     if( count($top_block) ) {
							     	foreach ($top_block as $module) {
							     		echo $module;
							     	}
							     } ?>

									 <!-- Search -->
									 <div class="search_form" style="display:inline-block;max-width:120px;margin-top:10px;">
									  <div class="button-search"></div>
									  <input type="text" class="input-block-level search-query" style="height:57px;" name="search" placeholder="<?php echo str_replace('...', '', $search); ?>" id="search_query" value="" />

									  <?php if($theme_options->get( 'quick_search_autosuggest' ) != '0') { ?>
									 	 <div id="autocomplete-results" class="autocomplete-results"></div>

									 	 <script type="text/javascript">
									 	 $(document).ready(function() {
									 		 $('#search_query').autocomplete({
									 			 delay: 0,
									 			 appendTo: "#autocomplete-results",
									 			 source: function(request, response) {
									 				 $.ajax({
									 					 url: 'index.php?route=search/autocomplete&filter_name=' +  encodeURIComponent(request.term),
									 					 dataType: 'json',
									 					 success: function(json) {
									 						 response($.map(json, function(item) {
									 							 return {
									 								 label: item.name,
									 								 value: item.product_id,
									 								 href: item.href,
									 								 thumb: item.thumb,
									 								 desc: item.desc,
									 								 price: item.price
									 							 }
									 						 }));
									 					 }
									 				 });
									 			 },
									 			 select: function(event, ui) {
									 				 document.location.href = ui.item.href;

									 				 return false;
									 			 },
									 			 focus: function(event, ui) {
									 						 return false;
									 				 },
									 				 minLength: 2
									 		 })
									 		 .data( "ui-autocomplete" )._renderItem = function( ul, item ) {
									 			 return $( "<li>" )
									 				 .append( "<a>" + item.label + "</a>" )
									 				 .appendTo( ul );
									 		 };
									 	 });
									 	 </script>
									  <?php } ?>
									 </div>
									 <div  style="display:inline-block;">
										<p style="margin: 0;font-size: 14px;color: #000;font-weight: 500;">
											 <?php echo $telephone; ?>
										</p>
									 	<a href="#" class="callme btn btn-info btn-xs" role="button">Заказать звонок</a>
								 </div>
									 <!-- <div>
										 <a href="<?php echo $account; ?>" class="my-account"><i class="fa fa-user"></i></a> -->
										<?php // echo $cart; ?>
									<!-- </div> -->

							</div>
						</div>
					</div>
					<?php if($theme_options->get( 'megamenu_type' ) == 4 || $theme_options->get( 'megamenu_type' ) == 5 || $theme_options->get( 'megamenu_type' ) == 6 || $theme_options->get( 'megamenu_type' ) == 9 || $theme_options->get( 'megamenu_type' ) == 14 || $theme_options->get( 'megamenu_type' ) == 19 || $theme_options->get( 'megamenu_type' ) == 29) { ?>
					<div class="container container-megamenu2">
					<?php } ?>
					<?php
					$menu = $modules->getModules('menu');
					if( count($menu) ) { ?>
					     <div class="megamenu-background">
					          <div class="">
					               <div class="overflow-megamenu container">
               						<?php
               						if(count($menu) > 1) echo '<div class="row mega-menu-modules">';
               						$i = 0;

               						foreach ($menu as $module) {
               						     if($i == 0 && count($menu) > 1) echo '<div class="col-md-3">';
               						     if($i == 1 && count($menu) > 1) echo '<div class="col-md-9">';
               							     echo $module;
               							if(count($menu) > 1 && ($i == 0 || $i == 1)) echo '</div>';
               							if(count($menu) > 1 && $i == 1) echo '</div>';
               							$i++;
               						} ?>
               					</div>
               				</div>
               			</div>
					<?php } elseif($categories) { ?>
					<div class="megamenu-background">
					     <div class="">
					          <div class="overflow-megamenu container">
               					<div class="container-megamenu horizontal">
               						<div class="megaMenuToggle">
               							<div class="megamenuToogle-wrapper">
               								<div class="megamenuToogle-pattern">
               									<div class="container">
               										<div><span></span><span></span><span></span></div>
               										Navigation
               									</div>
               								</div>
               							</div>
               						</div>

               						<div class="megamenu-wrapper">
               							<div class="megamenu-pattern">
               								<div class="container">
               									<ul class="megamenu shift-up">
																	<?php foreach ($categories as $category) { ?>
               										<?php if ($category['children']) { ?>
               										<li class="with-sub-menu hover"><p class="close-menu"></p><p class="open-menu"></p>
               											<a href="<?php echo $category['href'];?>"><span><strong><?php echo $category['name']; ?></strong></span></a>
               										<?php } else { ?>
               										<li>
               											<a href="<?php echo $category['href']; ?>"><span><strong><?php echo $category['name']; ?></strong></span></a>
               										<?php } ?>
               											<?php if ($category['children']) { ?>
               											<?php
               												$width = '100%';
               												$row_fluid = 3;
               												if($category['column'] == 1) { $width = '220px'; $row_fluid = 12; }
               												if($category['column'] == 2) { $width = '500px'; $row_fluid = 6; }
               												if($category['column'] == 3) { $width = '700px'; $row_fluid = 4; }
               											?>
               											<div class="sub-menu" style="width: <?php echo $width; ?>">
               												<div class="content">
               													<p class="arrow"></p>
               													<div class="row hover-menu">
               														<?php for ($i = 0; $i < count($category['children']);) { ?>
               														<div class="col-sm-<?php echo $row_fluid; ?> mobile-enabled">
               															<div class="menu">
               																<ul>
               																  <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
               																  <?php for (; $i < $j; $i++) { ?>
               																  <?php if (isset($category['children'][$i])) { ?>
               																  <li><a href="<?php echo $category['children'][$i]['href']; ?>" class="main-menu"><?php echo $category['children'][$i]['name']; ?></a></li>
               																  <?php } ?>
               																  <?php } ?>
               																</ul>
               															</div>
               														</div>
               														<?php } ?>
               													</div>
               												</div>
               											</div>
               											<?php } ?>
               										</li>
               										<?php } ?>
               									</ul>
               								</div>
               							</div>
               						</div>
               					</div>
          					</div>
     					</div>
					</div>
					<?php
					}
					?>
					<?php if($theme_options->get( 'megamenu_type' ) == 4 || $theme_options->get( 'megamenu_type' ) == 5 || $theme_options->get( 'megamenu_type' ) == 6 || $theme_options->get( 'megamenu_type' ) == 9 || $theme_options->get( 'megamenu_type' ) == 14 || $theme_options->get( 'megamenu_type' ) == 19 || $theme_options->get( 'megamenu_type' ) == 29) { ?>
					</div>
					<?php } ?>
					<?php
					$menu2 = $modules->getModules('menu2');
					if( count($menu2) ) {
					     echo '<div class="overflow-menu2">';
						foreach ($menu2 as $module) {
							echo $module;
						}
						echo '</div>';
					} ?>
				</div>
			</div>
		</div>
	</div>

	<?php $slideshow = $modules->getModules('slideshow'); ?>
	<?php  if(count($slideshow)) { ?>
	<!-- Slider -->
	<div id="slider" class="<?php if($theme_options->get( 'slideshow_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'slideshow_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'slideshow_layout' ) == 3) { echo 'fixed2'; } else { echo 'fixed'; } ?>">
		<div class="background-slider"></div>
		<div class="background">
			<div class="shadow"></div>
			<div class="pattern">
				<?php foreach($slideshow as $module) { ?>
				<?php echo $module; ?>
				<?php } ?>
			</div>
		</div>
	</div>
	<?php } ?>
</header>
