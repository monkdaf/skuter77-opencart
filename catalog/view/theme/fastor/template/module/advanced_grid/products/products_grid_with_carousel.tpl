<?php 
if($this->registry->has('theme_options') == true) { 

$class = 3; 
$all = 4;
$id = rand(0, 5000)*rand(5000, 50000);

$theme_options = $this->registry->get('theme_options');
$config = $this->registry->get('config');

if(count($module['content']['products']) == 6) { $class = 2; $all = 6; }
if(count($module['content']['products']) == 5) { $class = 25; $all = 5; }
if(count($module['content']['products']) == 3) { $class = 4;  $all = 3; }
if(count($module['content']['products']) == 2) { $class = 6; $all = 2; }
if(count($module['content']['products']) == 1) { $class = 12; $all = 1; } ?>

<div class="box clearfix box-with-products products-grid-with-carousel <?php if($module['content']['title'] == '') { echo 'without-heading-type-2'; } ?>">
  <?php if($module['content']['title'] != '') { ?>
  <div class="box-heading"><?php echo $module['content']['title']; ?></div>
  <div class="strip-line"></div>
  <?php } ?>
  <div class="clear"></div>
  <div class="box-content products">
    <div class="box-product">
    	<div id="myCarousel<?php echo $id; ?>">
    	     <div class="owl-carousel">
         		<?php foreach ($module['content']['products'] as $product) { ?>
     	    		<div class="item">
     	    			<div class="product-grid"><?php include('catalog/view/theme/'.$config->get('config_template').'/template/new_elements/product.tpl'); ?></div>
     	    		</div>
         		<?php } ?>
    		</div>
     </div>
   </div>
  </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
 $("#myCarousel<?php echo $id; ?> .owl-carousel").owlCarousel();
});
</script>
<?php } ?>