<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" onclick="apply(); return false;" form="form-account" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-filterpro" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="filterpro_status" id="input-status" class="form-control">
                <?php if ($filterpro_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div>
            <style type="text/css">
                    .list label{
                        display: inline;
                        margin: 0 5px !important;
                        font-weight: normal;
                    }

                    table{
                        width: 100%;
                    }

                    table tr{
                        height: 30px;
                        vertical-align: middle;
                        border-bottom: 1px solid rgb(231, 231, 231);
                    }

                    table input{
                        margin-left:10px !important;
                    }
                </style>
            <div class="col-sm-8">
              <table id="settings" class="table table-hover list">
                <thead>
                  <tr>
                    <td colspan="2"></td>
                    <td><input type="checkbox" id="expand_all">
                      &nbsp;<?php echo $text_expanded?></td>
                  </tr>
                </thead>
                <tr>
                  <td><?php echo $text_price_slider?></td>
                  <td colspan="2"><input id="price_slider_yes" type="radio" name="filterpro_setting[price_slider]" value="1" <?php if(!isset($setting['price_slider']) || $setting['price_slider'] == '1') echo " checked='checked'"?>>
                    <label for="price_slider_yes"><?php echo $text_yes?></label>
                    <input id="price_slider_no" type="radio" name="filterpro_setting[price_slider]" value="0" <?php if(isset($setting['price_slider']) && $setting['price_slider'] == '0') echo " checked='checked'"?>>
                    <label for="price_slider_no"><?php echo $text_no?></label></td>
                </tr>
                <tr>
                  <td><?php echo $text_instock; ?></td>
                  <td colspan="2"><input id="instock_checked" type="checkbox" name="filterpro_setting[instock_checked]" <?php if (isset($setting['instock_checked'])) echo ' checked="checked"'; ?>>
                    &nbsp;
                    <label for="instock_checked"><?php echo $text_checked; ?></label>
                    <input id="instock_visible" type="checkbox" name="filterpro_setting[instock_visible]" <?php if (isset($setting['instock_visible'])) echo ' checked="checked"'; ?>>
                    &nbsp;
                    <label for="instock_visible"><?php echo $text_visible; ?></label></td>
                </tr>
                <tr>
                  <td><?php echo $text_manufacturer?></td>
                  <td><?php foreach($display_options as $display_option) { ?>
                    <input type="radio" name="filterpro_setting[display_manufacturer]" value="<?php echo $display_option['value']?>" <?php if(isset($setting['display_manufacturer']) && $display_option['value'] == $setting['display_manufacturer']) echo 'checked';?> >
                    <?php echo $display_option['name']?>
                    </input>
                    <?php }?></td>
                  <td><input type="checkbox" class="expanded" name="filterpro_setting[expanded_manufacturer]" <?php if(isset($setting['expanded_manufacturer'])) echo ' checked="checked"';?>></td>
                </tr>
                <tr>
                  <td colspan="3">&nbsp;</td>
                </tr>
                <tr>
                  <td colspan="3" style="text-align: center;"><strong>Options</strong></td>
                </tr>
                <?php foreach($options as $option){ ?>
                <tr>
                  <td><?php echo $option['name']?></td>
                  <td><?php foreach($display_options as $display_option) { ?>
                    <input type="radio" name="filterpro_setting[display_option_<?php echo $option['option_id']?>]" value="<?php echo $display_option['value']?>" <?php if(isset($setting['display_option_' . $option['option_id']]) && $display_option['value'] == $setting['display_option_' . $option['option_id']]) echo 'checked';?> >
                    <?php echo $display_option['name']?>
                    </input>
                    <?php }?></td>
                  <td><input type="checkbox" class="expanded" name="filterpro_setting[expanded_option_<?php echo $option['option_id']?>]" <?php if(isset($setting['expanded_option_' . $option['option_id']])) echo ' checked="checked"';?>></td>
                </tr>
                <?php }?>
                <tr>
                  <td colspan="3">&nbsp;</td>
                </tr>
                <?php $attribute_group = false;?>
                <?php foreach($attributes as $attribute){ ?>
                <?php if ($attribute_group !=$attribute['attribute_group']) { ?>
                <?php $attribute_group = $attribute['attribute_group'];?>
                <tr>
                  <td colspan="3" style="text-align: center;"><strong><?php echo $attribute['attribute_group']. ' (Attribute Group)'?></strong></td>
                </tr>
                <?php }	?>
                <tr>
                  <td><?php echo $attribute['name']?></td>
                  <td><?php foreach($display_options_attr as $display_option) { ?>
                    <input type="radio" name="filterpro_setting[display_attribute_<?php echo $attribute['attribute_id']?>]" value="<?php echo $display_option['value']?>" <?php if(isset($setting['display_attribute_' . $attribute['attribute_id']]) && $display_option['value'] == $setting['display_attribute_' . $attribute['attribute_id']]) echo 'checked';?> >
                    <?php echo $display_option['name']?>
                    </input>
                    <?php }?></td>
                  <td><input type="checkbox" class="expanded" name="filterpro_setting[expanded_attribute_<?php echo $attribute['attribute_id']?>]" <?php if(isset($setting['expanded_attribute_' . $attribute['attribute_id']])) echo ' checked="checked"';?>></td>
                </tr>
                <?php }?>
              </table>
            </div>
            <div class="col-sm-4 well">

              <table class="list table table-hover">
                <tr>
                  <td><?php echo $text_attr_delimeter?></td>
                  <td><input id="attr_delimeter" type="text" name="filterpro_setting[attr_delimeter]" size="3"
                                                   value="<?php if(isset($setting['attr_delimeter'])) echo $setting['attr_delimeter']; else echo ':'; ?>"></td>
                </tr>
                <tr>
                  <td><?php echo $text_tax?></td>
                  <td><input id="tax" type="text" name="filterpro_setting[tax]" size="3"
                                                   value="<?php if(isset($setting['tax'])) echo $setting['tax']; else echo '0'; ?>"></td>
                </tr>
                <tr>
                  <td><?php echo $text_option_mode?></td>
                  <td><input id="option_mode_or" type="radio" name="filterpro_setting[option_mode]"
                                                   value="or" <?php if(!isset($setting['option_mode']) || $setting['option_mode'] == 'or') echo " checked='checked'"?>>
                    <label for="option_mode_or"><?php echo $text_mode_or?></label>
                    <input id="option_mode_and" type="radio" name="filterpro_setting[option_mode]"
                                                   value="and" <?php if(isset($setting['option_mode']) && $setting['option_mode'] == 'and') echo " checked='checked'"?>>
                    <label for="option_mode_and"><?php echo $text_mode_and?></label></td>
                </tr>

                <tr>
                  <td><?php echo $text_attribute_mode?></td>
                  <td><input id="attribute_mode_or" type="radio" name="filterpro_setting[attribute_mode]"
                                                   value="or" <?php if(!isset($setting['attribute_mode']) || $setting['attribute_mode'] == 'or') echo " checked='checked'"?>>
                    <label for="attribute_mode_or"><?php echo $text_mode_or?></label>
                    <input id="attribute_mode_and" type="radio" name="filterpro_setting[attribute_mode]"
                                                   value="and" <?php if(isset($setting['attribute_mode']) && $setting['attribute_mode'] == 'and') echo " checked='checked'"?>>
                    <label for="attribute_mode_and"><?php echo $text_mode_and?></label></td>
                </tr>
                  <tr>
                      <td><?php echo $text_attr_group?></td>
                      <td><input id="text_attr_group_off" type="radio" name="filterpro_setting[attr_group]"
                                 value="0" <?php if(!isset($setting['attr_group']) || $setting['attr_group'] == '0') echo " checked='checked'"?>>
                          <label for="text_attr_group_off"><?php echo $text_no?></label>
                          <input id="text_attr_group_on" type="radio" name="filterpro_setting[attr_group]"
                                 value="1" <?php if(isset($setting['attr_group']) && $setting['attr_group'] == '1') echo " checked='checked'"?>>
                          <label for="text_attr_group_on"><?php echo $text_yes?></label></td>
                  </tr>
              </table>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
$(document).ready(function() {
    $('#expand_all').click(function(event) {
        if(this.checked) {
            $('.expanded').each(function() {
                this.checked = true;
            });
        }else{
            $('.expanded').each(function() {
                this.checked = false;
            });
        }
    });

});

function apply(){
	$(".success").remove();
	$.post($("#form-filterpro").attr('action'), $("#form-filterpro").serialize(), function(html) {
		var $success = $(html).find(".success");
		if ($success.length > 0) {
			$(".breadcrumb").after($success);
		}
   });
}


    jQuery(document).ready(function() {
        var radio_groups = {};
        $(":radio").each(function(){
            radio_groups[this.name] = true;
        });

        for(group in radio_groups){
            if_checked = !!$(":radio[name='"+group+"']:checked").length;

            if(!if_checked) {
                $('input[name="'+group+'"][value="checkbox"]').attr('checked', 'checked');
            }

        }
    });

//--></script>
<?php echo $footer; ?>