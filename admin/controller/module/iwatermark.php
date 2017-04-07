<?php
class ControllerModuleIwatermark extends Controller {
	private $data = array();
	private $error = array(); 
	
	public function index() {   
		$this->load->language('module/iwatermark');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle('view/stylesheet/iwatermark.css');
		$this->document->addStyle('view/stylesheet/iwatermark_colorpicker.css');
		$this->document->addScript('view/javascript/iwatermark_colorpicker.js');
        $this->document->addStyle('view/stylesheet/iwatermark/iwatermark.css');		
		
		
		$this->load->model('module/iwatermark');
		$this->load->model('setting/store');
		$this->load->model('setting/setting');

		$catalogURL = $this->getCatalogURL();

		if(!isset($this->request->get['store_id'])) {
           $this->request->get['store_id'] = 0; 
        }
	
        $store = $this->getCurrentStore($this->request->get['store_id']);
		
		$this->data['error_warning'] = '';
		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateForm()) {
			
			if (!empty($_POST['OaXRyb1BhY2sgLSBDb21'])) {
                $this->request->post['iwatermark']['LicensedOn'] = $_POST['OaXRyb1BhY2sgLSBDb21'];
            }
        	if (!empty($_POST['cHRpbWl6YXRpb24ef4fe'])) {
                $this->request->post['iwatermark']['License'] = json_decode(base64_decode($_POST['cHRpbWl6YXRpb24ef4fe']), true);
            }

            $store = $this->getCurrentStore($this->request->post['store_id']);

			if (empty($_GET['activate'])) {
				// Clear cache
				$this->model_module_iwatermark->cleanFolder(DIR_IMAGE . 'cache');

				// Data validation
				$this->validate($store);
			}

			$this->model_setting_setting->editSetting('iwatermark', $this->request->post, $this->request->post['store_id']);		
			
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			if (!empty($_GET['activate'])) {
				$this->session->data['success'] = $this->language->get('text_success_activation');
			}
			
			$selectedTab = (empty($this->request->post['selectedTab'])) ? 0 : $this->request->post['selectedTab'];
			$this->response->redirect($this->url->link('module/iwatermark', 'store_id='.$this->request->post['store_id'] .'&token=' . $this->session->data['token'], 'SSL'));
		}

		// Set language data
		$variables = array(
			'heading_title',
			'text_enabled',
			'text_disabled',
			'text_content_top',
			'text_content_bottom',
			'text_column_left',
			'text_column_right',
			'text_activate',
			'text_not_activated',
			'text_click_activate',
			'entry_code',
			'button_save',
			'button_cancel',
			'entry_type',
			'text_type_image',
			'text_type_text',
			'entry_image',
			'text_max_size',
			'text_max_size_learn',
			'text_top_left',
			'text_top_right',
			'text_center',
			'text_bottom_left',
			'text_bottom_right',
			'entry_position',
			'entry_opacity',
			'entry_text',
			'entry_current_image',
			'text_cache_delete_warning',
			'entry_image_opacity',
			'entry_text_color',
			'text_default',
			'entry_watermark_limit',
			'entry_all_images',
			'entry_bigger_than',
			'entry_smaller_than',
			'entry_font',
			'entry_font_size',
			'entry_watermark_limit_categories',
			'entry_all_categories',
			'entry_following_categories',
			'entry_watermark_limit_related',
			'entry_all_related',
			'entry_following_related',
			'entry_rotation'
		);
		foreach ($variables as $variable) $this->data[$variable] = $this->language->get($variable);
		
		$this->data['maxSize'] = $this->model_module_iwatermark->returnMaxUploadSize();
		$this->data['maxSizeReadable'] = $this->model_module_iwatermark->returnMaxUploadSize(true);
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		if (isset($this->session->data['warning'])) {
			$this->data['error_warning'] = $this->session->data['warning'];
			unset($this->session->data['warning']);
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['code'])) {
			$data['error_code'] = $this->error['code'];
		} else {
			$data['error_code'] = '';
		}

  		$this->data['breadcrumbs'] = array(
			array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => false
			),
			array(
				'text'      => $this->language->get('text_module'),
				'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			),
			array(
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
			)
		);	


		$this->data['stores'] = array_merge(array(0 => array('store_id' => '0', 'name' => $this->config->get('config_name') . ' (' . $this->data['text_default'].')', 'url' => HTTP_SERVER, 'ssl' => HTTPS_SERVER)), $this->model_setting_store->getStores());
		$this->data['store']                  = $store;
		$this->data['token']                  = $this->session->data['token'];
		$this->data['action'] = $this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['data']                   = $this->model_setting_setting->getSetting('iwatermark', $store['store_id']);
		
		$this->data['currenttemplate'] =  $this->config->get('config_template');
		
		/*if (isset($this->data['data'][$this->moduleName])) {
		// Module Unifier
		$this->data['moduleData'] = $this->data['data']['iwatermark'];
		// Module Unifier
		}*/

		$this->load->model('design/layout');
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->load->model('setting/store');
		
		$this->data['fonts'] = array();
		$fontsFolder = IMODULE_ROOT.'vendors/iwatermark/font/';
		if (is_dir($fontsFolder)) {
			$fontsFolderFiles = scandir($fontsFolder);
			foreach ($fontsFolderFiles as $font) {
				if (substr($font, strripos($font, '.ttf')) == '.ttf') {
					$this->data['fonts'][] = $font;	
				}
			}
		}
		
		// Categories
		$this->load->model('catalog/category');
		$categories = array();
		
		$this->data['product_categories'] = array();
		
		
		if (!empty($this->data['data']['iwatermark']['LimitCategoriesList'])) {
			$categories = $this->data['data']['iwatermark']['LimitCategoriesList'];
		} else {
			$categories = array();
		}
		
		$this->data['product_categories'] = array();
		
		foreach ($categories as $category_id) {
			$category_info = $this->model_catalog_category->getCategory($category_id);
			
			if ($category_info) {
				$this->data['product_categories'][] = array(
					'category_id' => $category_info['category_id'],
					'name'        => version_compare(VERSION, '1.5.4.1', '<=') ? ($this->model_catalog_category->getPath($category_id)) : (($category_info['path'] ? $category_info['path'] . ' &gt; ' : '') . $category_info['name'])
				);
			}
		}
		
		// Related
		$this->load->model('catalog/product');
		$products = array();
		
		$this->data['products_related'] = array();
		
		
		if (!empty($this->data['data']['iwatermark']['LimitRelatedList'])) {
			$products = $this->data['data']['iwatermark']['LimitRelatedList'];
		} else {
			$products = array();
		}
		
		$this->data['products_related'] = array();
		
		foreach ($products as $product_id) {
			$product_info = $this->model_catalog_product->getProduct($product_id);
			
			if ($product_info) {
				$this->data['products_related'][] = array(
					'product_id' => $product_info['product_id'],
					'name'        => $product_info['name']
				);
			}
		}
		
		$this->data['header']  					 = $this->load->controller('common/header');
		$this->data['column_left']				= $this->load->controller('common/column_left');
		$this->data['footer']					 = $this->load->controller('common/footer');
	
        $this->response->setOutput($this->load->view('module/iwatermark.tpl', $this->data));
	}
	
	private function validate($store) {
		$this->load->model('setting/store');
		$this->load->model('setting/setting');
		$stores = array_merge(array(0 => array('store_id' => '0', 'name' => '', 'url' => NULL, 'ssl' => NULL)), $this->model_setting_store->getStores());
		
		
			if (!empty($this->request->post['iwatermark']['Enabled']) && $this->request->post['iwatermark']['Enabled'] == 'true') {
				if (empty($this->request->post['iwatermark']['Type'])) {
					$this->session->data['flash_error'][] = $this->language->get('error_type_empty');
					$this->session->data['warning'] = $this->language->get('error_type_empty');
					$this->response->redirect($this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL'));
				}
				
				if ($this->request->post['iwatermark']['Type'] == 'image') { 
					if (!empty($this->request->files['iwatermark']['size']['Image'])) {
						try {
							$image = $this->model_module_iwatermark->getStandardFile($this->request->files['iwatermark'], $store['store_id']);
							$this->request->post['iwatermark']['ImagePath'] = $image['path'];
							$this->request->post['iwatermark']['Image'] = $image['image'];
						} catch (Exception $e) { 
							$this->session->data['flash_error'][] = $e->getMessage();
							$this->session->data['warning'] = $e->getMessage();
							$this->response->redirect($this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL'));
						}
					}
						
					$configValue = $this->model_setting_setting->getSetting('iwatermark', $store['store_id']);

					if (empty($this->request->post['iwatermark']['ImagePath']) || empty($this->request->post['iwatermark']['Image'])) {
						$this->session->data['flash_error'][] = $this->language->get('error_image_empty');
						$this->session->data['warning'] = $this->language->get('error_image_empty');
						$this->response->redirect($this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL'));
					}
				} else if ($this->request->post['iwatermark']['Type'] == 'text') {
					if (empty($this->request->post['iwatermark']['Text'])) {
						$this->session->data['flash_error'][] = $this->language->get('error_text_empty');
						$this->session->data['warning'] = $this->language->get('error_text_empty');
						$this->response->redirect($this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL'));
					}
					
					if (empty($this->request->post['iwatermark']['Font'])) {
						$this->session->data['flash_error'][] = $this->language->get('error_font_empty');
						$this->session->data['warning'] = $this->language->get('error_font_empty');
						$this->response->redirect($this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL'));
					}
					
					if (!isset($this->request->post['iwatermark']['FontSize']) || (int)$this->request->post['iwatermark']['FontSize'] < 8 || (int)$this->request->post['iwatermark']['FontSize'] > 100) {
						$this->session->data['flash_error'][] = $this->language->get('error_invalid_font_size');
						$this->session->data['warning'] = $this->language->get('error_invalid_font_size');
						$this->response->redirect($this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL'));
					}
					
					if (empty($this->request->post['iwatermark']['Color']) || !preg_match('/[0-9a-fA-F]{6}/', $this->request->post['iwatermark']['Color'])) {
						$this->session->data['flash_error'][] = $this->language->get('error_text_color');
						$this->session->data['warning'] = $this->language->get('error_text_color');
						$this->response->redirect($this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL'));
					} else {
						// Convert color to RGB, so it can be used in the watermark.
						$this->request->post['iwatermark']['ColorRGB'] = $this->model_module_iwatermark->hex2rgb($this->request->post['iwatermark']['Color']);	
					}
				}
				
				$positions = array('top_left', 'top_right', 'center', 'bottom_left', 'bottom_right');
				if (empty($this->request->post['iwatermark']['Position']) || !in_array($this->request->post['iwatermark']['Position'], $positions)) {
					$this->session->data['flash_error'][] = $this->language->get('error_invalid_position');
					$this->session->data['warning'] = $this->language->get('error_invalid_position');
					$this->response->redirect($this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL'));
				}
				
				$limitSizeTypes = array('all', 'bigger_than', 'smaller_than');
				if (empty($this->request->post['iwatermark']['LimitSizeType']) || !in_array($this->request->post['iwatermark']['LimitSizeType'], $limitSizeTypes)) {
					$this->session->data['flash_error'][] = $this->language->get('error_invalid_limit_size_type');
					$this->session->data['warning'] = $this->language->get('error_invalid_limit_size_type');
					$this->response->redirect($this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL'));
				}
				
				if (!isset($this->request->post['iwatermark']['LimitSizeWidth']) || (!is_numeric($this->request->post['iwatermark']['LimitSizeWidth']) && $this->request->post['iwatermark']['LimitSizeWidth'] != '') || (int)$this->request->post['iwatermark']['LimitSizeWidth'] < 0) {
					$this->session->data['flash_error'][] = $this->language->get('error_invalid_limit_size_width');
					$this->session->data['warning'] = $this->language->get('error_invalid_limit_size_width');
					$this->response->redirect($this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL'));
				}
				
				if (!isset($this->request->post['iwatermark']['LimitSizeHeight']) || (!is_numeric($this->request->post['iwatermark']['LimitSizeHeight']) && $this->request->post['iwatermark']['LimitSizeHeight'] != '') || (int)$this->request->post['iwatermark']['LimitSizeHeight'] < 0) {
					$this->session->data['flash_error'][] = $this->language->get('error_invalid_limit_size_height');
					$this->session->data['warning'] = $this->language->get('error_invalid_limit_size_height');
					$this->response->redirect($this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL'));
				}
				
				if (!isset($this->request->post['iwatermark']['Opacity']) || (int)$this->request->post['iwatermark']['Opacity'] < 0 || (int)$this->request->post['iwatermark']['Opacity'] > 100) {
					$this->session->data['flash_error'][] = $this->language->get('error_invalid_opacity');
					$this->session->data['warning'] = $this->language->get('error_invalid_opacity');
					$this->response->redirect($this->url->link('module/iwatermark', 'token=' . $this->session->data['token'], 'SSL'));
				}
			}
		
	}
	
	public function autocomplete_category() {
		$json = array();
		
		if (isset($this->request->get['filter_name'])) {
			$this->load->model('catalog/category');
			
			if (version_compare(VERSION, '1.5.2.1', '>')) {
				$data = array(
					'filter_name' => $this->request->get['filter_name'],
					'start'       => 0,
					'limit'       => 20
				);
			} else {
				$data = 0;
			}
			
			$results = $this->model_catalog_category->getCategories($data);
				
			foreach ($results as $result) {
				if (version_compare(VERSION, '1.5.2.1', '<=')) {
					if (stripos($result['name'], $this->request->get['filter_name']) === false) continue;
				}
				
				$json[] = array(
					'category_id' => $result['category_id'], 
					'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
				);
			}		
		}

		$sort_order = array();
	  
		foreach ($json as $key => $value) {
			$sort_order[$key] = $value['name'];
		}

		array_multisort($sort_order, SORT_ASC, $json);

		$this->response->setOutput(json_encode($json));
	}
	
	public function autocomplete_product() {
		$json = array();
		
		if (isset($this->request->get['filter_name']) || isset($this->request->get['filter_model']) || isset($this->request->get['filter_category_id'])) {
			$this->load->model('catalog/product');
			$this->load->model('catalog/option');
			
			if (isset($this->request->get['filter_name'])) {
				$filter_name = $this->request->get['filter_name'];
			} else {
				$filter_name = '';
			}
			
			if (isset($this->request->get['filter_model'])) {
				$filter_model = $this->request->get['filter_model'];
			} else {
				$filter_model = '';
			}
			
			if (isset($this->request->get['limit'])) {
				$limit = $this->request->get['limit'];	
			} else {
				$limit = 20;	
			}			
						
			$data = array(
				'filter_name'  => $filter_name,
				'filter_model' => $filter_model,
				'start'        => 0,
				'limit'        => $limit
			);
			
			$results = $this->model_catalog_product->getProducts($data);
			
			foreach ($results as $result) {
				
				$json[] = array(
					'product_id' => $result['product_id'],
					'name'       => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),	
					'model'      => $result['model'],
					'price'      => $result['price']
				);	
			}
		}

		$this->response->setOutput(json_encode($json));
	}

	private function getCatalogURL() {
        if (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) {
            $storeURL = HTTPS_CATALOG;
        } else {
            $storeURL = HTTP_CATALOG;
        } 
        return $storeURL;
    }

    private function getServerURL() {
        if (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) {
            $storeURL = HTTPS_SERVER;
        } else {
            $storeURL = HTTP_SERVER;
        } 
        return $storeURL;
    }

    private function getCurrentStore($store_id) {    
        if($store_id && $store_id != 0) {
            $store = $this->model_setting_store->getStore($store_id);
        } else {
            $store['store_id'] = 0;
            $store['name'] = $this->config->get('config_name');
            $store['url'] = $this->getCatalogURL(); 
        }
        return $store;
    }

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'module/iwatermark')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
	
	public function install() {
		$this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=1 WHERE `name` LIKE'%WaterMark by iSenseLabs%'"); 
 		$modifications = $this->load->controller('extension/modification/refresh');
    }

	public function uninstall() {
    	$this->db->query("UPDATE `" . DB_PREFIX . "modification` SET status=0 WHERE `name` LIKE'%WaterMark by iSenseLabs%'"); 
 		$modifications = $this->load->controller('extension/modification/refresh');
    }
}
?>