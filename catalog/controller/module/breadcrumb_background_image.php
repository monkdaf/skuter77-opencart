<?php  
/* 
Version: 1.0
Author: Artur Sułkowski
Website: http://artursulkowski.pl
*/

class ControllerModuleBreadcrumbBackgroundImage extends Controller {
	public function index($setting) {
		$data['background_color'] = $setting['background_color'];
		$data['background_image'] = $setting['background_image'];
		$data['background_image_position'] = $setting['background_image_position'];
		$data['background_image_repeat'] = $setting['background_image_repeat'];
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/breadcrumb_background_image.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/breadcrumb_background_image.tpl', $data);
		} else {
			return $this->load->view('default/template/module/breadcrumb_background_image.tpl', $data);
		}
	}
}
?>