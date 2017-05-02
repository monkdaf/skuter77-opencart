<?php
if($this->registry->has('theme_options') == false) {
	header("location: themeinstall/index.php");
	exit;
}

$theme_options = $this->registry->get('theme_options'); ?>

<div class="box box-with-categories <?php if($theme_options->get( 'category_box_style' ) == '3') { echo 'category-box-type-4 category-box-type-2'; } ?> <?php if($theme_options->get( 'category_box_style' ) == '2') { echo 'category-box-type-3 category-box-type-2'; } ?> <?php if($theme_options->get( 'category_box_style' ) == '1') { echo 'category-box-type-2'; } ?> box-no-advanced" style="padding-top: 0px !important;">
  <!--noindex--><div class="box-heading"><?php echo $heading_title; ?></div><!--/noindex-->
  <div class="strip-line"></div>
  <div class="box-content box-category">
    <ul class="accordion" id="accordion-category">
      <?php $i = 0; foreach ($categories as $category) { $i++; ?>
      <li class="panel">
        <?php if ($category['category_id'] == $category_id) { ?>
        <a href="<?php echo $category['href']; ?>" class="active"><?php echo $category['name']; ?></a>
        <?php } else { ?>
        <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
        <?php } ?>
        <?php $categories_2 = $theme_options->getCategories($category['category_id']); ?>
        <?php if ($categories_2) { ?>
        <span class="head"><a style="float:right;padding-right:5px" class="accordion-toggle<?php if ($category['category_id'] != $category_id) { echo ' collapsed'; } ?>" data-toggle="collapse" data-parent="#accordion-category" href="#category<?php echo $i; ?>"><span class="plus">+</span><span class="minus">-</span></a></span>
        <?php if(!empty($categories_2)) { ?>
        <div id="category<?php echo $i; ?>" class="panel-collapse collapse <?php if ($category['category_id'] == $category_id) { echo 'in'; } ?>" style="clear:both">
        	<!-- <ul> -->
        	<ul class="accordion" id="accordion-subcategory<?php echo $i; ?>">
		       <?php $j = 0; foreach ($categories_2 as $child) {$j++; ?>
		        <!-- <li> -->
		        <li class="panel">
		         <?php if ($child['category_id'] == $child_id) { ?>
		         <a href="<?php echo $child['href']; ?>" class="active"><?php echo $child['name']; ?></a>
		         <?php } else { ?>
		         <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
		         <?php } ?>


						 <?php $categories_3 = $theme_options->getCategories($child['category_id']); ?>
		         <?php if ($categories_3) { ?>
		         <!-- <?php echo count($categories_3).$categories_3[0]['name']; ?> -->
		         <span class="head"><a style="float:right;padding-right:5px" class="accordion-toggle<?php if ($child['category_id'] != $child_id) { echo ' collapsed'; } ?>" data-toggle="collapse" data-parent="#accordion-subcategory<?php echo $i; ?>" href="#category<?php echo $i.$j; ?>"><span class="plus">+</span><span class="minus">-</span></a></span>
		         <?php if(!empty($categories_3)) { ?>
		         <div id="category<?php echo $i.$j; ?>" class="panel-collapse collapse <?php if ($child['category_id'] == $child_id) { echo 'in'; } ?>" style="clear:both">
		         	<ul>
		 		       <?php foreach ($categories_3 as $subchild) { ?>
		 		        <li>
		 		         <?php if ($subchild['category_id'] == $subchild_id) { ?>
		 		         <a href="<?php echo $subchild['href']; ?>" class="active"><?php echo $subchild['name']; ?></a>
		 		         <?php } else { ?>
		 		         <a href="<?php echo $subchild['href']; ?>"><?php echo $subchild['name']; ?></a>
		 		         <?php } ?>
		 		        </li>
		 		       <?php } ?>
		 	        </ul>
		         </div>
		         <?php } ?>
		         <?php } ?>


		        </li>
		       <?php } ?>
	        </ul>
        </div>
        <?php } ?>
        <?php } ?>
      </li>
      <?php } ?>
    </ul>
  </div>
</div>
