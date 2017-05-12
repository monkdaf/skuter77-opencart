<?php
$theme_options = $this->registry->get('theme_options');
$config = $this->registry->get('config');
?>

<!-- Product -->
<div class="product clearfix product-hover">
	<div class="left">
		<?php if ($product['thumb']) { ?>
			<?php if($product['special'] && $theme_options->get( 'display_text_sale' ) != '0') { ?>
				<?php $text_sale = 'Скидка';
				if($theme_options->get( 'sale_text', $config->get( 'config_language_id' ) ) != '') {
					$text_sale = $theme_options->get( 'sale_text', $config->get( 'config_language_id' ) );
				} ?>
				<?php if($theme_options->get( 'type_sale' ) == '1') { ?>
					<?php $product_detail = $theme_options->getDataProduct( $product['product_id'] );
					$roznica_ceny = $product_detail['price']-$product_detail['special'];
					$procent = ($roznica_ceny*100)/$product_detail['price']; ?>
					<div class="sale">-<?php echo round($procent); ?>%</div>
				<?php } else { ?>
					<div class="sale"><?php echo $text_sale; ?></div>
				<?php } ?>
			 <?php } elseif($theme_options->get( 'display_text_new' ) != '0' && $theme_options->isLatestProduct( $product['product_id'] )) { ?>
				 <div class="new">Новинка</div>
			 <?php } ?>

			<div class="image <?php if($theme_options->get( 'product_image_effect' ) == '1') { echo 'image-swap-effect'; } ?>">
				<a href="<?php echo $product['href']; ?>">
					<?php if($theme_options->get( 'product_image_effect' ) == '1') {
						$nthumb = str_replace(' ', "%20", ($product['thumb']));
						$nthumb = str_replace(HTTP_SERVER, "", $nthumb);
						$image_size = getimagesize($nthumb);
						$image_swap = $theme_options->productImageSwap($product['product_id'], $image_size[0], $image_size[1]);
						if($image_swap != '') echo '<img src="' . $image_swap . '" alt="' . $product['name'] . '" class="swap-image" />';
					} ?>
					<?php if($theme_options->get( 'lazy_loading_images' ) != '0') { ?>
					<img src="image/catalog/blank.gif" data-echo="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" class="<?php if($theme_options->get( 'product_image_effect' ) == '2') { echo 'zoom-image-effect'; } ?>" />
					<?php } else { ?>
					<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" class="<?php if($theme_options->get( 'product_image_effect' ) == '2') { echo 'zoom-image-effect'; } ?>" />
					<?php } ?>
				</a>
			</div>
		<?php } else { ?>
			<div class="image">
				<a href="<?php echo $product['href']; ?>"><img src="image/no_image.jpg" alt="<?php echo $product['name']; ?>" <?php if($theme_options->get( 'product_image_effect' ) == '2') { echo 'class="zoom-image-effect"'; } ?> /></a>
			</div>
		<?php } ?>
		<?php if($theme_options->get( 'display_specials_countdown' ) == '1' && $product['special']) { $countdown = rand(0, 5000)*rand(0, 5000);
		          $product_detail = $theme_options->getDataProduct( $product['product_id'] );
		          $date_end = $product_detail['date_end'];
		          if($date_end != '0000-00-00' && $date_end) { ?>
               		<script>
               		$(function () {
               			var austDay = new Date();
               		// 	austDay = new Date(<?php echo date("Y", strtotime($date_end)); ?>, <?php echo date("m", strtotime($date_end)); ?> - 1, <?php echo date("d", strtotime($date_end)); ?>);
               		// 	$('#countdown<?php echo $countdown; ?>').countdown({until: austDay});
										var endOfSalesDay = new Date(austDay.getFullYear(), austDay.getMonth(), austDay.getDate() + 4);
										$('#countdown<?php echo $countdown; ?>').countdown({until: endOfSalesDay});
               		});
               		</script>
               		<div id="countdown<?php echo $countdown; ?>" class="clearfix"></div>
     		     <?php } ?>
		<?php } ?>
	</div>
	<div class="right">
		<!--noindex--><div class="name" style="min-height: 79px;"><a rel="nofollow" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
		<?php if($theme_options->get( 'product_grid_type' ) == '7') { ?>
		<?php $product_detail = $theme_options->getDataProduct( $product['product_id'] ); ?>
		<div class="brand"><?php echo $product_detail['manufacturer']; ?></div>
		<?php } ?>
		<div class="price" style="visibility: visible;opacity: 1;">
			<?php if (!$product['special']) { ?>
			<?php echo $product['price']; ?> <!-- <i class="fa fa-rub"></i> -->
			<?php } else { ?>
			<span class="price-old"><?php echo $product['price']; ?> <!-- <i class="fa fa-rub"></i> --></span> <span class="price-new"><?php echo $product['special']; ?> <!-- <i class="fa fa-rub"></i> --></span>
			<?php } ?>
		</div><!--/noindex-->
		<?php if($theme_options->get( 'display_add_to_compare' ) != '0' || $theme_options->get( 'display_add_to_wishlist' ) != '0' || $theme_options->get( 'display_add_to_cart' ) != '0') { ?>


<!-- icons for products -->
		<?php if (isset($product['attribute_groups']) and $product['attribute_groups']) { ?>
			<div>
				<table class="attributes">
	      	<tbody><tr>
					  <?php foreach ($product['attribute_groups'] as $attribute_group) { ?>
					    <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
					      <?php if(in_array($attribute['attribute_id'], array(12,15,17))) { ?>
					        <?php
					          switch ($attribute['attribute_id']):
					              case 12:
									?>
														<td><img src="/image/t1.jpg" alt="Diam"></td>
														<td><?php echo $attribute['text']; ?></td>
									<?php
									          break;
					              case 15:
									?>
														<td><img src="/image/t2.jpg" alt="Speed"></td>
														<td><?php echo $attribute['text']; ?></td>
									<?php
					                  break;
					              case 17:
									?>
									          <td><img src="/image/t3.jpg" alt="Dist"></td>
														<td><?php echo $attribute['text']; ?></td>
									<?php
					                  break;
					          endswitch;
					         ?>
					      <?php }?>
					    <?php }?>
					  <?php } ?>
	        </tr></tbody>
				</table>
			</div>
	<?php } ?>
		<div class="only-hover" style="padding-bottom: 90px;">

			<ul>
				<?php if($theme_options->get( 'display_add_to_cart' ) != '0') { ?>
		    	<?php $enquiry = false; if($config->get( 'product_blocks_module' ) != '') { $enquiry = $theme_options->productIsEnquiry($product['product_id']); }
		      	if(is_array($enquiry)) { ?>
		        	<li><a href="javascript:openPopup('<?php echo $enquiry['popup_module']; ?>', '<?php echo $product['product_id']; ?>')" data-toggle="tooltip" data-original-title="<?php echo $enquiry['block_name']; ?>"><i class="fa fa-question"></i></a></li>
		        <?php } else { ?>
		          <li><button type="button"  onclick="yaCounter35209050.reachGoal('quickorder'); return true;" data-toggle="tooltip" title="Быстрый заказ" class= "callme" data-product_id = <?php echo $product['product_id']; ?>><i class="fa fa-shopping-cart"></i></button><a onclick="cart.add('<?php echo $product['product_id']; ?>');" data-toggle="tooltip" data-original-title="<?php echo $button_cart; ?>"><i class="fa fa-shopping-cart"></i></a></li>
		        <?php } ?>
        <?php } ?>

        <?php if($theme_options->get( 'quick_view' ) == 1) { ?>
        	<li class="quickview"><a href="index.php?route=product/quickview&amp;product_id=<?php echo $product['product_id']; ?>" data-toggle="tooltip" data-original-title="<?php if($theme_options->get( 'quickview_text', $config->get( 'config_language_id' ) ) != '') { echo html_entity_decode($theme_options->get( 'quickview_text', $config->get( 'config_language_id' ) )); } else { echo 'Quickview'; } ?>"><i class="fa fa-search"></i></a></li>
        <?php } ?>

				<?php if($theme_options->get( 'display_add_to_compare' ) != '0') { ?>
					<li><a onclick="compare.add('<?php echo $product['product_id']; ?>');" data-toggle="tooltip" data-original-title="<?php if($theme_options->get( 'add_to_compare_text', $config->get( 'config_language_id' ) ) != '') { echo $theme_options->get( 'add_to_compare_text', $config->get( 'config_language_id' ) ); } else { echo 'Add to compare'; } ?>"><i class="fa fa-exchange"></i></a></li>
				<?php } ?>

				<?php if($theme_options->get( 'display_add_to_wishlist' ) != '0') { ?>
					<li><a onclick="wishlist.add('<?php echo $product['product_id']; ?>');" data-toggle="tooltip" data-original-title="<?php if($theme_options->get( 'add_to_wishlist_text', $config->get( 'config_language_id' ) ) != '') { echo $theme_options->get( 'add_to_wishlist_text', $config->get( 'config_language_id' ) ); } else { echo 'Add to wishlist'; } ?>"><i class="fa fa-heart"></i></a></li>
				<?php } ?>
			</ul>
		</div>
		<?php } ?>
	</div>
</div>
