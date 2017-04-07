<div class="last-shop-ratings horizontal">
    <div class="block_header">
        <h4><span><?php echo $heading_title; ?></span></h4>
    </div>
    <div class="block_content">
        <div class="shop_summary_rating">
            <div class="shop_summary_general">
                <div class="shop_summary_general_title"><?php echo $text_summary; ?></div>
                <div class="shop_summary_general_rating"><?php echo $general['summ']?></div>
                <div class="summary-rate-star-show">
                    <div class="summary-rate-star-show star-change" style="<?php echo 'width: '.$general['summ_perc'].'%'; ?>"></div>
                </div>
                <div class="shop_summary_general_desc"><?php echo $text_count; ?> <?php echo $general['count'];?></div>
            </div>
        </div>

        <div class="block_content_wrapper" id="ratings_carousel" class="owl-carousel">
        <?php foreach($ratings as $rating){ ?>
            <div class="last-rating-item item">
                <div class="last-rating-item-header">
                    <div class="rate-author">
                        <?php echo $rating['author'];?>
                    </div>
                    <?php if(isset($show_rating)){ ?>
                    <div class="rate-stars">
                        <div class="rate-star-show small-stars <?php if($rating['shop_rating'] >= 1)echo 'star-change';?>"></div>
                        <div class="rate-star-show small-stars <?php if($rating['shop_rating'] >= 2)echo 'star-change';?>"></div>
                        <div class="rate-star-show small-stars <?php if($rating['shop_rating'] >= 3)echo 'star-change';?>"></div>
                        <div class="rate-star-show small-stars <?php if($rating['shop_rating'] >= 4)echo 'star-change';?>"></div>
                        <div class="rate-star-show small-stars <?php if($rating['shop_rating'] == 5)echo 'star-change';?>"></div>
                    </div>
                    <?php } ?>
                    <div style="clear: both"></div>
                </div>
                <div class="last-rating-item-comment"><?php echo $rating['comment'];?></div>
            </div>
        <?php } ?>
        </div>
        <div style="clear: both"></div>
    </div>
    <div class="last-rating-link">
        <a class="" href="<?php echo $href_read_more; ?>"><?php echo $text_read_more; ?></a>
    </div>

</div>
<script type="text/javascript"><!--
    $('#ratings_carousel').owlCarousel({
        items: 2,
        itemsDesktop: [1199,2],
        itemsDesktopSmall: [979,2],
        itemsTablet: [768,2],

        autoPlay: 6000,
        navigation: true,
        navigationText: ['<i class="fa fa-chevron-left fa-5x"></i>', '<i class="fa fa-chevron-right fa-5x"></i>'],
        pagination: false
    });
    --></script>