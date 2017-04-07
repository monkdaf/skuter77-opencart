<?php echo $header;
$theme_options = $this->registry->get('theme_options');
$config = $this->registry->get('config'); ?>
<?php $grid_center = 12;
if($column_left != '') $grid_center = $grid_center-3;
if($column_right != '') $grid_center = $grid_center-3;

require_once( DIR_TEMPLATE.$config->get('config_template')."/lib/module.php" );
$modules = new Modules($this->registry); ?>

<!-- MAIN CONTENT
	================================================== -->
<div class="main-content <?php if($theme_options->get( 'content_layout' ) == 1) { echo 'full-width'; } elseif($theme_options->get( 'content_layout' ) == 4) { echo 'fixed3 fixed2'; } elseif($theme_options->get( 'content_layout' ) == 3) { echo 'fixed2'; } else { echo 'fixed'; } ?> home">
	<!--<h1 align="center">Сигвеи и гироскутеры</h1>-->
	<div class="background-content"></div>
	<div class="background">
		<div class="shadow"></div>
		<div class="pattern">
			<div class="container">
				<?php
				$preface_left = $modules->getModules('preface_left');
				$preface_right = $modules->getModules('preface_right');
				?>
				<?php if( count($preface_left) || count($preface_right) ) { ?>
				<div class="row">
					<div class="col-sm-8">
						<?php
						if( count($preface_left) ) {
							foreach ($preface_left as $module) {
								echo $module;
							}
						} ?>
					</div>

					<noindex><div class="col-sm-4">
						<?php
						if( count($preface_right) ) {
							foreach ($preface_right as $module) {
								echo $module;
							}
						} ?>
					</div></noindex>
				</div>
				<?php } ?>

				<!-- -->
				<?php
				$preface_fullwidth = $modules->getModules('preface_fullwidth');
				if( count($preface_fullwidth) ) { ?>
<!--
				<div class="row">
					<div class="col-sm-12">
-->
						<?php
							foreach ($preface_fullwidth as $module) {
							//	echo $module;
							}
						?>
<!--					</div>
				</div>
-->
				<?php } ?>
				<!-- -->

				<div class="row">
					<?php
					$columnleft = $modules->getModules('column_left');
					if( count($columnleft) ) { ?>
					<div class="col-md-3" id="column_left">
						<?php
						foreach ($columnleft as $module) {
							echo $module;
						}
						?>
					</div>
					<?php } ?>
					<?php $grid_center = 12; if( count($columnleft) ) { $grid_center = 9; } ?>
					<div class="col-md-<?php echo $grid_center; ?>">
						<?php
						$content_big_column = $modules->getModules('content_big_column');
						if( count($content_big_column) ) {
							foreach ($content_big_column as $module) {
								echo $module;
							}
						} ?>

						<div class="row">
							<?php
							$grid_content_top = 12;
							$grid_content_right = 3;
							$column_right = $modules->getModules('column_right');
							if( count($column_right) ) {
								if($grid_center == 9) {
									$grid_content_top = 8;
									$grid_content_right = 4;
								} else {
									$grid_content_top = 9;
									$grid_content_right = 3;
								}
							}
							?>
							<div class="col-md-<?php echo $grid_content_top; ?>">
								<?php
								$content_top = $modules->getModules('content_top');
								if( count($content_top) ) {
									foreach ($content_top as $module) {
										echo $module;
									}
								} ?>
							</div>

							<?php if( count($column_right) ) { ?>
							<div class="col-md-<?php echo $grid_content_right; ?>">
								<?php foreach ($column_right as $module) {
									echo $module;
								} ?>
							</div>
							<?php } ?>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-sm-12">
						<?php
						$contentbottom = $modules->getModules('content_bottom');
						if( count($contentbottom) ) { ?>
							<?php
							foreach ($contentbottom as $module) {
								echo $module;
							}
							?>
						<?php } ?>
					</div>
				</div>

				<div class="box clearfix box-with-products  box-no-advanced">
					<div class="box-heading">Как купить</div>
					<div class="strip-line"></div>
					<div class="clear"></div>
					<div class="box-content products">
						<div class="col-sm-1"><img src="/image/kk1.jpg"/></div>
						<div class="col-sm-2 propis"><span class="tbold">Закажите товар</span> на сайте или получите консультацию по телефону</div>

						<div class="col-sm-1"><img src="/image/kk2.jpg"/></div>

						<div class="col-sm-1"><img src="/image/kk3.jpg"/></div>
						<div class="col-sm-3 propis">Мы обработаем заказ за <span class="tbold">9&nbsp;минут</span> и доставим гироскутер уже сегодня</div>

						<div class="col-sm-1"><img src="/image/kk2.jpg"/></div>

						<div class="col-sm-1"><img src="/image/kk4.jpg"/></div>
						<div class="col-sm-2 propis"><span class="tbold">Вы уже катаетесь</span> на своём новеньком гироскутере</div>
					</div>
				</div>

				<div align="justify">
					<br />
					Правильно подобранное индивидуальное средство передвижения существенно расширяет человеческие возможности. Но для того, чтобы в процессе эксплуатации испытывать только положительные эмоциональные впечатления, рекомендуется обращаться за покупкой в специализированный магазин.
					<br />
					<h2>Доступные цены на Segway в Москве</h2>
					<br />
					У нас, в Skuter77, предлагается широкий ассортимент специальных транспортных средств. Их объединяют безупречное качество и вполне приемлемые цены.
					Обратите также внимание на следующие преимущества нашего торгового предприятия:
					<br />* Здесь можно купить гироскутеры в Москве быстро и точно. Каждая модель техники представлена с подробными описаниями, фотографиями. Внимательно изучить ее будет даже проще, чем при личном посещении классического выставочного зала.
					<br />* Мы предлагаем купить Segway в Москве с тщательным подбором параметров будущего пользователя, с учетом условий будущего использования. В разделах нашего каталога представлены модели с разными по размеру колесами, рассчитанные на какие-либо нагрузки.
					<br />* Тут Вы можете купить электросамокаты в Москве только от проверенных производителей и поставщиков, способных дать надежные гарантии. При соблюдении несложных правил, потребительские параметры и внешний вид этих изделий сохранятся в течение длительного срока службы.
					<br />
					<h2>У нас самые выгодные цены на гироскутеры в Москве</h2>
					<br />
					Удобный выбор и тщательный анализ, простое оформление заказа и быстрая доставка, квалифицированная помощь и полноценная информационная поддержка – используйте эти особенности нашего магазина с пользой и выгодой для себя.
				</div>

			</div>
		</div>
	</div>
</div>

<?php echo $footer; ?>
