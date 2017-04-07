<?php
/* 
Version: 1.0
Author: Artur SuÅkowski
Website: http://artursulkowski.pl
*/

class ControllerModuleRevolutionSlider extends Controller {
	private $error = array(); 

	public function index() {   
		$this->language->load('module/revolution_slider');

		$this->document->setTitle('Revolution slider');
		
		$this->load->model('setting/setting');
		
		// Dodawanie plikÃ³w css i js do <head>
		$this->document->addStyle('view/stylesheet/revolution_slider.css');
		
		// Ładowanie modelu Revolution slider
		$this->load->model('slider/revolution_slider');
		
		// Pobranie sliderów
		$data['sliders'] = $this->model_slider_revolution_slider->getSliders();
		
		// Zapisywanie moduÅu		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('revolution_slider', $this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->response->redirect($this->url->link('module/revolution_slider', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		// WyÅwietlanie powiadomieÅ
 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->session->data['error_warning'])) {
			$data['error_warning'] = $this->session->data['error_warning'];
		    unset($this->session->data['error_warning']);
		}
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		    unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
		
		$data['action'] = $this->url->link('module/revolution_slider', 'token=' . $this->session->data['token'], 'SSL');
		$data['placement'] = $this->url->link('module/revolution_slider', 'token=' . $this->session->data['token'], 'SSL');		
		$data['existing'] = $this->url->link('module/revslideropencart', 'token=' . $this->session->data['token'], 'SSL');		
		$data['token'] = $this->session->data['token'];
	
		// Åadowanie listy moduÅÃ³w
		$data['modules'] = array();
		
		if (isset($this->request->post['revolution_slider_module'])) {
			$data['modules'] = $this->request->post['revolution_slider_module'];
		} elseif ($this->config->get('revolution_slider_module')) { 
			$data['modules'] = $this->config->get('revolution_slider_module');
		}	
		
		// Load model layout		
		$this->load->model('design/layout');
		$data['layouts'] = $this->model_design_layout->getLayouts();
		
		$data['breadcrumbs'] = array();
		
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);
		
		$data['breadcrumbs'][] = array(
			'text' => 'Modules',
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);
				
		$data['breadcrumbs'][] = array(
			'text' => 'Revolution slider',
			'href' => $this->url->link('module/revolution_slider', 'token=' . $this->session->data['token'], 'SSL')
		);
				
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
				
		$this->response->setOutput($this->load->view('module/revolution_slider/placement.tpl', $data));
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/revolution_slider')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>