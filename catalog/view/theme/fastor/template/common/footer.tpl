<?php
if($this->registry->has('theme_options') == true) {
	$theme_options = $this->registry->get('theme_options');
	$config = $this->registry->get('config');

	require_once( DIR_TEMPLATE.$config->get('config_template')."/lib/module.php" );
	$modules = new Modules($this->registry);

	// Pobranie zmiennych
	$language_id = $config->get( 'config_language_id' );
	$customfooter = $theme_options->get( 'customfooter' );
	if(!isset($customfooter[$language_id])) {
		$customfooter[$language_id] = array(
			'aboutus_status' => 0,
			'twitter_status' => 0,
			'facebook_status' => 0,
			'contact_status' => 0,
			'customblock_status' => 0
		);
	}

	if(!isset($customfooter[$language_id]['customblock_status'])) $customfooter[$language_id]['customblock_status'] = 0;

	$customfooter_top = $modules->getModules('customfooter_top');
	$customfooter_bottom = $modules->getModules('customfooter_bottom');
	$customfooter_center = $modules->getModules('customfooter');
	$footer_center = $modules->getModules('footer');

	// Sprawdzanie czy panele są włączone
	if(isset($customfooter[$language_id]) || count($customfooter_top) || count($customfooter_bottom) || count($customfooter_center)) {
		if($customfooter[$language_id]['twitter_status'] == '1' || $customfooter[$language_id]['contact_status'] == '1' || $customfooter[$language_id]['aboutus_status'] == '1' || $customfooter[$language_id]['facebook_status'] == '1' || count($customfooter_top) || count($customfooter_bottom) || count($customfooter_center)) {

			// Ustalanie szerokości paneli
			$grids = 12; $test = 0;
			if($customfooter[$language_id]['aboutus_status'] == '1') { $test++; }
			if($customfooter[$language_id]['twitter_status'] == '1') { $test++; }
			if($customfooter[$language_id]['facebook_status'] == '1') { $test++; }
			if($customfooter[$language_id]['contact_status'] == '1') { $test++; }
			if($customfooter[$language_id]['customblock_status'] == '1') { $test++; }
			if($test == 0) { $test = 1; }
			$grids = 12/$test;
			if($test == 5) $grids = 25;

	?>
	<!-- CUSTOM FOOTER
		================================================== -->
	<div class="custom-footer <?php if($theme_options->get( 'custom_footer_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'custom_footer_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'custom_footer_layout' ) == 3) { echo 'fixed2'; } else { echo 'fixed'; } ?>">
		<div class="background-custom-footer"></div>
		<div class="background">
			<div class="shadow"></div>
			<div class="pattern">
				<div class="container">
					<?php
					if( count($customfooter_top) ) {
						foreach ($customfooter_top as $module) {
							echo $module;
						}
					} ?>

					<?php
					if( count($customfooter_center) ) {
						foreach ($customfooter_center as $module) {
							echo $module;
						}
					} else { ?>
     					<div class="row">
     						<?php if($customfooter[$language_id]['aboutus_status'] == '1') { ?>
     						<!-- About us -->
     						<div class="col-sm-<?php echo $grids; ?>">
     							<?php if($customfooter[$language_id]['aboutus_title'] != '') { ?>
     							<h4><?php echo $customfooter[$language_id]['aboutus_title']; ?></h4>
     							<?php } ?>
     							<div class="custom-footer-text"><?php echo html_entity_decode($customfooter[$language_id]['aboutus_text']); ?></div>
     						</div>
     						<?php } ?>

     						<?php if($customfooter[$language_id]['contact_status'] == '1') { ?>
     						<!-- Contact -->
     						<div class="col-sm-<?php echo $grids; ?>">
     							<?php if($customfooter[$language_id]['contact_title'] != '') { ?>
     							<h4><?php echo $customfooter[$language_id]['contact_title']; ?></h4>
     							<?php } ?>
     							<ul class="contact-us clearfix">
     								<?php if($customfooter[$language_id]['contact_phone'] != '' || $customfooter[$language_id]['contact_phone2'] != '') { ?>
     								<!-- Phone -->
     								<li>
     									<i class="fa fa-mobile-phone"></i>
     									<p>
     										<?php if($customfooter[$language_id]['contact_phone'] != '') { ?>
     											<?php echo $customfooter[$language_id]['contact_phone']; ?><br>
     										<?php } ?>
     										<?php if($customfooter[$language_id]['contact_phone2'] != '') { ?>
     											<?php echo $customfooter[$language_id]['contact_phone2']; ?>
     										<?php } ?>
     									</p>
     								</li>
     								<?php } ?>
     								<?php if($customfooter[$language_id]['contact_email'] != '' || $customfooter[$language_id]['contact_email2'] != '') { ?>
     								<!-- Email -->
     								<li>
     									<i class="fa fa-envelope"></i>
     									<p>
     										<?php if($customfooter[$language_id]['contact_email'] != '') { ?>
     											<span><?php echo $customfooter[$language_id]['contact_email']; ?></span><br>
     										<?php } ?>
     										<?php if($customfooter[$language_id]['contact_email2'] != '') { ?>
     											<span><?php echo $customfooter[$language_id]['contact_email2']; ?></span>
     										<?php } ?>
     									</p>
     								</li>
     								<?php } ?>
     								<?php if($customfooter[$language_id]['contact_skype'] != '' || $customfooter[$language_id]['contact_skype2'] != '') { ?>
     								<!-- Phone -->
     								<li>
     									<i class="fa fa-skype"></i>
     									<p>
     										<?php if($customfooter[$language_id]['contact_skype'] != '') { ?>
     											<?php echo $customfooter[$language_id]['contact_skype']; ?><br>
     										<?php } ?>
     										<?php if($customfooter[$language_id]['contact_skype2'] != '') { ?>
     											<?php echo $customfooter[$language_id]['contact_skype2']; ?>
     										<?php } ?>
     									</p>
     								</li>
     								<?php } ?>
     							</ul>
     						</div>
     						<?php } ?>

     						<?php if($customfooter[$language_id]['twitter_status'] == '1') { ?>
     						<!-- Twitter -->
     						<div class="col-sm-<?php echo $grids; ?>">
     							<?php if($customfooter[$language_id]['twitter_title'] != '') { ?>
     							<h4><?php echo $customfooter[$language_id]['twitter_title']; ?></h4>
     							<?php } ?>

     							<div class="twitter-feed">
     							    <div class="twitter-wrapper"><div class="tweets clearfix" id="twitterFeed"><small>Please wait whilst our latest tweets load.</small></div></div>
     							    <script type="text/javascript">
     							        $(window).load(function(){
     							            twitterFetcher.fetch('<?php echo $customfooter[$language_id]['twitter_widget_id'] ; ?>', 'twitterFeed', 2, true, false);
     							        });
     							    </script>
     							</div>
     						</div>
     						<?php } ?>

     						<?php if($customfooter[$language_id]['facebook_status'] == '1') { ?>
     						<!-- Facebook -->
     						<div class="col-sm-<?php echo $grids; ?>">
     							<?php if($customfooter[$language_id]['facebook_title'] != '') { ?>
     							<h4><?php echo $customfooter[$language_id]['facebook_title']; ?></h4>
     							<?php } ?>

     							<div id="fb-root"></div>
     							<script>(function(d, s, id) {
     							  var js, fjs = d.getElementsByTagName(s)[0];
     							  if (d.getElementById(id)) return;
     							  js = d.createElement(s); js.id = id;
     							  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
     							  fjs.parentNode.insertBefore(js, fjs);
     							}(document, 'script', 'facebook-jssdk'));</script>

     							<div id="facebook">
     								<?php if(!isset($customfooter[$language_id]['color_scheme'])) { $customfooter[$language_id]['color_scheme'] = false; } ?>
     								<div class="fb-like-box fb_iframe_widget" profile_id="<?php echo $customfooter[$language_id]['facebook_id']; ?>" data-show-border="false"
     								 data-width="260" data-height="<?php if($customfooter[$language_id]['facebook_height'] > 0) { echo $customfooter[$language_id]['facebook_height']; } else { echo '210'; } ?>" <?php if($customfooter[$language_id]['show_faces'] != '1') { ?>data-connections="<?php if($customfooter[$language_id]['facebook_faces'] > 0) { echo $customfooter[$language_id]['facebook_faces']; } else { echo '8'; } ?>"<?php } ?> data-colorscheme="<?php if($customfooter[$language_id]['color_scheme'] != '1') { echo 'light'; } else { echo 'dark'; } ?>" data-stream="false" data-header="false" data-show-faces="<?php if($customfooter[$language_id]['show_faces'] == '1') { echo 'false'; } else { echo 'true'; } ?>" fb-xfbml-state="rendered"></div>
     							</div>
     						</div>
     						<?php } ?>

     						<?php if($customfooter[$language_id]['customblock_status'] == '1') { ?>
     						<!-- Custom block -->
     						<div class="col-sm-<?php echo $grids; ?>">
     							<?php if($customfooter[$language_id]['customblock_title'] != '') { ?>
     							<h4><?php echo $customfooter[$language_id]['customblock_title']; ?></h4>
     							<?php } ?>
     							<div class="custom-footer-text"><?php echo html_entity_decode($customfooter[$language_id]['customblock_text']); ?></div>
     						</div>
     						<?php } ?>
     					</div>
					<?php } ?>

					<?php
					if( count($customfooter_bottom) ) {
						foreach ($customfooter_bottom as $module) {
							echo $module;
						}
					} ?>

				</div>
			</div>
		</div>
	</div>
	<?php } } ?>

	<!-- FOOTER
		================================================== -->
	<div class="footer <?php if($theme_options->get( 'footer_layout' ) == 2) { echo 'fixed'; } elseif($theme_options->get( 'footer_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'footer_layout' ) == 3) { echo 'fixed2'; } else { echo 'full-width'; } ?>">
		<div class="background-footer"></div>
		<div class="background">
			<div class="shadow"></div>
			<div class="pattern">
				<div class="container">
				        <div class="container">
				        <div class="footer-my-menu">
<a href="/giroskutery/">Гироскутеры</a>
<a style="margin-left:20px;" href="/samokaty/">Самокаты</a>
<a style="margin-left:20px;" href="/monokoleso/">Моноколесо</a>
<a style="margin-left:20px;" href="/elektrosamokaty/">Электросамокаты</a>
<a style="margin-left:20px;" href="/sigvei/">Сигвеи</a>
<a style="margin-left:20px;" href="/stati">Статьи</a>
			</div>


					<?php
					if( count($footer_center) ) {
						foreach ($footer_center as $module) {
							echo $module;
						}
					} else { ?>
					     <?php
					     $footer_top = $modules->getModules('footer_top');
					     if( count($footer_top) ) {
					     	foreach ($footer_top as $module) {
					     		echo $module;
					     	}
					     } ?>

     					<div class="row footer-main-box">
     						<?php
     						$footer_left = $modules->getModules('footer_left');
     						$footer_right = $modules->getModules('footer_right');

     						$span = 3;
     						if( count($footer_left) && count($footer_right) ) {
     							$span = 2;
     						} elseif( count($footer_left) || count($footer_right) ) {
     							$span = 25;
     						} ?>

     						<?php if( count($footer_left) ) { ?>
     						<div class="col-sm-<?php echo $span; ?>">
     						<?php foreach ($footer_left as $module) {
     								echo $module;
     							} ?>
     						</div>
     						<?php } ?>

     						<!-- Information -->
     						<div class="col-sm-<?php echo $span; ?>">
     							<h4><?php echo $text_information; ?></h4>
     							<div class="strip-line"></div>
     							<ul>
     								<?php foreach ($informations as $information) { ?>
     								<li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
     								<?php } ?>
     							</ul>
     						</div>

     						<!-- Customer Service -->
     						<div class="col-sm-<?php echo $span; ?>">
     							<h4><?php echo $text_service; ?></h4>
     							<div class="strip-line"></div>
     							<ul>
     								<li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
     								<li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
     								<li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
     							</ul>
     						</div>

     						<!-- Extras -->
     						<div class="col-sm-<?php echo $span; ?>">
     							<h4><?php echo $text_extra; ?></h4>
     							<div class="strip-line"></div>
     							<ul>
     								<li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
     								<li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
     								<li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
     								<li><a href="<?php echo $special; ?>"><?php echo $text_special; ?> </a></li>
     							</ul>
     						</div>

     						<!-- My Account -->
     						<div class="col-sm-<?php echo $span; ?>">
     							<h4><?php echo $text_account; ?></h4>
     							<div class="strip-line"></div>
     							<ul>
     								<li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
     								<li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
     								<li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
     								<li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
     							</ul>
     						</div>

     						<?php if( count($footer_right) ) { ?>
     						<div class="col-sm-<?php echo $span; ?>">
     						<?php foreach ($footer_right as $module) {
     								echo $module;
     							} ?>
     						</div>
     						<?php } ?>
     					</div>

     					<?php
     					$footer_bottom = $modules->getModules('footer_bottom');
     					if( count($footer_bottom) ) {
     						foreach ($footer_bottom as $module) {
     							echo $module;
     						}
     					} ?>

     					<div class="row copyright">
     					     <div class="col-sm-12">
     					          <?php if(is_array($theme_options->get( 'payment' ))) { if($theme_options->get( 'payment_status' ) != '0') { ?>
     					          <ul>
     					          	<?php foreach($theme_options->get( 'payment' ) as $payment) {
     					          		echo '<li>';
     					          		if($payment['link'] != '') {
     					          			$new_tab = false;
     					          			if($payment['new_tab'] == 1) {
     					          				$new_tab = ' target="_blank"';
     					          			}
     					          			echo '<a href="' .$payment['link']. '"'.$new_tab.'>';
     					          		}
     					          		echo '<img src="image/' .$payment['img']. '" alt="' .$payment['name']. '">';
     					          		if($payment['link'] != '') {
     					          			echo '</a>';
     					          		}
     					          		echo '</li>';
     					          	} ?>
     					          </ul>
     					          <?php } } ?>
     					          <!--
     					          OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
     					          Please donate via PayPal to donate@opencart.com
     					          //-->
     					          <!-- <p><?php echo $powered; ?></p> -->
     					          <!--
     					          OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
     					          Please donate via PayPal to donate@opencart.com
     					          //-->

     					          <?php
     					          $bottom = $modules->getModules('bottom');
     					          if( count($bottom) ) {
     					          	foreach ($bottom as $module) {
     					          		echo $module;
     					          	}
     					          } ?>

     					     </div>
     					</div>
					<?php } ?>
<div class="row">
     <div class="col-sm-5 col-xs-12 footer-about-info-common">
            <img class="footer-about-info-icon" src="image/catalog/computer4/icon-phone.png" alt="Phone">
            <p><a href="tel:+74994902075"><?php echo $telephone; ?></a></p>
            <!-- <p><?php echo $telephone; ?></p> -->
     </div>

     <!-- <div class="col-sm-4 footer-about-info-common" style="margin-left:-100px"> -->
     <div class="col-sm-4 col-xs-12 footer-about-info-common">
    		<img class="footer-about-info-icon" src="image/catalog/computer4/icon-mail.png" alt="Mail">
          <p><a href="mailto:info@skuter77.ru">info@skuter77.ru</a></p>
					 <!-- <p>info@skuter77.ru</p> -->
     </div>

     <!-- <div class="col-sm-2 footer-about-info-common" style="margin-top:-25px;" > -->
		 <div class="col-sm-2 col-xs-12 footer-about-info-common-copyright">
			 <p itemscope itemtype="http://schema.org/LocalBusiness">
				 <span itemprop="name">Skuter77</span> © 2016</p>
     </div>

		 <div class="col-sm-1 col-xs-12 footer-about-info-common">
			 <!-- Yandex.Metrika informer -->
			 <a href="https://metrika.yandex.ru/stat/?id=35209050&amp;from=informer"
			 target="_blank" rel="nofollow"><img src="https://informer.yandex.ru/informer/35209050/3_1_FFFFFFFF_EFEFEFFF_0_pageviews"
			 style="width:88px; height:31px; border:0;" alt="Яндекс.Метрика" title="Яндекс.Метрика: данные за сегодня (просмотры, визиты и уникальные посетители)" class="ym-advanced-informer" data-cid="35209050" data-lang="ru" /></a>
			 <!-- /Yandex.Metrika informer -->

			 <!-- Yandex.Metrika counter -->
			 <script type="text/javascript">
			     (function (d, w, c) {
			         (w[c] = w[c] || []).push(function() {
			             try {
			                 w.yaCounter35209050 = new Ya.Metrika({
			                     id:35209050,
			                     clickmap:true,
			                     trackLinks:true,
			                     accurateTrackBounce:true,
			                     webvisor:true
			                 });
			             } catch(e) { }
			         });

			         var n = d.getElementsByTagName("script")[0],
			             s = d.createElement("script"),
			             f = function () { n.parentNode.insertBefore(s, n); };
			         s.type = "text/javascript";
			         s.async = true;
			         s.src = "https://mc.yandex.ru/metrika/watch.js";

			         if (w.opera == "[object Opera]") {
			             d.addEventListener("DOMContentLoaded", f, false);
			         } else { f(); }
			     })(document, window, "yandex_metrika_callbacks");
			 </script>
			 <noscript><div><img src="https://mc.yandex.ru/watch/35209050" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
			 <!-- /Yandex.Metrika counter -->
     </div>
</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript" src="catalog/view/theme/<?php echo $config->get( 'config_template' ); ?>/js/megamenu.js"></script>
</div>
</div>
<?php } ?>
</div>
<!-- BEGIN JIVOSITE CODE {literal} -->
<script type='text/javascript'>
(function(){ var widget_id = 'Elk1rfau5x';var d=document;var w=window;function l(){
var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = '//code.jivosite.com/script/widget/'+widget_id; var ss = document.getElementsByTagName('script')[0]; ss.parentNode.insertBefore(s, ss);}if(d.readyState=='complete'){l();}else{if(w.attachEvent){w.attachEvent('onload',l);}else{w.addEventListener('load',l,false);}}})();</script>
<!-- {/literal} END JIVOSITE CODE -->

</body>
</html>
