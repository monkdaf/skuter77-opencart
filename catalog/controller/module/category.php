<?php
class ControllerModuleCategory extends Controller {
	public function index() {
		$this->load->language('module/category');

		$data['heading_title'] = $this->language->get('heading_title');

		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}

		if (isset($parts[0])) {
			$data['category_id'] = $parts[0];
		} else {
			$data['category_id'] = 0;
		}

		if (isset($parts[1])) {
			$data['child_id'] = $parts[1];
		} else {
			$data['child_id'] = 0;
		}

		if (isset($parts[2])) {
			$data['subchild_id'] = $parts[2];
		} else {
			$data['subchild_id'] = 0;
		}

		// $this->log->debug('$data["category_id"]=', $data['category_id']);
		// $this->log->debug('$data["child_id"]=', $data['child_id']);
		// $this->log->debug('$data["subchild_id"]=', $data['subchild_id']);

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			$children_data = array();

			if ($category['category_id'] == $data['category_id']) {
				$children = $this->model_catalog_category->getCategories($category['category_id']);

// $this->log->debug('$data["category_id"]=', $data['category_id']);

				foreach($children as $child) {
					$filter_data = array('filter_category_id' => $child['category_id'], 'filter_sub_category' => true);
// $this->log->debug('$filter_data(child)=', $filter_data);
					$subchidren_data = array();
// $this->log->debug('$subchildren_data1=', $subchildren_data);
					$subchidren = $this->model_catalog_category->getCategories($child['category_id']);

					foreach($subchidren as $subchild) {
						$filter_subchild_data = array('filter_category_id' => $subchild['category_id'], 'filter_sub_category' => true);
// $this->log->debug('$filter_subchild_data=', $filter_subchild_data);
						$subchildren_data[] = array(
							'category_id' => $subchild['category_id'],
							'name' => $subchild['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_subchild_data) . ')' : ''),
							'href' => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'] . '_' . $subchild['category_id'])
						);
// $this->log->debug('$subchildren_data2=', $subchildren_data);
					}


					$children_data[] = array(
						'category_id' => $child['category_id'],
						'name' => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						'children' => $subchildren_data,
						'href' => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
// $this->log->resetDebug();
// $this->log->debug('$children_data=', $children_data);
				}
			}

			$filter_data = array(
				'filter_category_id'  => $category['category_id'],
				'filter_sub_category' => true
			);

			$data['categories'][] = array(
				'category_id' => $category['category_id'],
				'name'        => $category['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
				'children'    => $children_data,
				'href'        => $this->url->link('product/category', 'path=' . $category['category_id'])
			);
// $this->log->resetDebug();
// $this->log->debug('$data[categories]=', $data['categories']);

		}


		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/category.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/category.tpl', $data);
		} else {
			return $this->load->view('default/template/module/category.tpl', $data);
		}
	}
}
