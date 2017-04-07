<?php
/* 
Version: 1.0
Author: Artur SuÅkowski
Website: http://artursulkowski.pl
*/

class ControllerModuleBlogPopular extends Controller {
	private $error = array(); 
	 
	public function index() {   
		$this->language->load('module/blog_popular');

		$this->document->setTitle('Blog Popular');
		
		$this->load->model('setting/setting');
		
		// Dodawanie plikÃ³w css i js do <head>
		$this->document->addStyle('view/stylesheet/blog_popular.css');
		
		// Zapisywanie moduÅu		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->model_setting_setting->editSetting('blog_popular', $this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->response->redirect($this->url->link('module/blog_popular', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		// WyÅwietlanie powiadomieÅ
 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
		    unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}
		
		$data['action'] = $this->url->link('module/blog_popular', 'token=' . $this->session->data['token'], 'SSL');
				
		$data['token'] = $this->session->data['token'];
	
		// Åadowanie listy moduÅÃ³w
		$data['modules'] = array();
		
		if (isset($this->request->post['blog_popular_module'])) {
			$data['modules'] = $this->request->post['blog_popular_module'];
		} elseif ($this->config->get('blog_popular_module')) { 
			$data['modules'] = $this->config->get('blog_popular_module');
		}	
        
		
		// Layouts		
		$this->load->model('design/layout');
		$data['layouts'] = $this->model_design_layout->getLayouts();
		
        // Ładowanie templatek modułów
		$data['article_popular_templates'] = array();
		
		$data['templates'] = array();

		$directories = glob(DIR_CATALOG . 'view/theme/*', GLOB_ONLYDIR);

		foreach ($directories as $directory) {
            $directory = basename($directory);
			$data['templates'][] = $directory;
			$files_popular_list = glob(DIR_CATALOG . 'view/theme/' . $directory . '/template/module/blog_popular/*.tpl');

			if(!empty($files_popular_list)) {
			     $data['article_popular_templates'][$directory] = array();
			     foreach ($files_popular_list as $file) {
			          $data['article_popular_templates'][$directory][] = basename($file);
			     }
			}
		}
        
        
		// Languages
		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();
		
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
			'text' => 'Blog popular posts',
			'href' => $this->url->link('module/blog_popular', 'token=' . $this->session->data['token'], 'SSL')
		);
				
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
				
		$this->response->setOutput($this->load->view('module/blog_popular.tpl', $data));
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/blog_popular')) {
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