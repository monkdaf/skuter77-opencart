<?php
class ControllerCommonSeoPro extends Controller {
	private $cache_data = null;


	public function __construct($registry) {
		parent::__construct($registry);
		$this->cache_data = $this->cache->get('seo_pro');
		if (!$this->cache_data) {
			$query = $this->db->query("SELECT LOWER(`keyword`) as 'keyword', `query` FROM " . DB_PREFIX . "url_alias");
			$this->cache_data = array();
			foreach ($query->rows as $row) {
				$this->cache_data['keywords'][$row['keyword']] = $row['query'];
				$this->cache_data['queries'][$row['query']] = $row['keyword'];
			}
			$this->cache->set('seo_pro', $this->cache_data);
		}

		$query = $this->db->query("SELECT `value` FROM `" . DB_PREFIX . "setting` WHERE `key` = 'config_language'");
		$this->config_language = $query->row['value'];

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "language WHERE status = '1'");

		foreach ($query->rows as $result) {
			$this->languages[$result['code']] = $result;
		}

	}

	public function index() {

		$code = null;



		// Pavillion Theme fix for "original_route" param.
		// Theme: <http://themeforest.net/item/pavilion-premium-responsive-opencart-theme/9219645>
		if(isset($this->request->get['original_route'])) {
			unset($this->request->get['original_route']);
		}








		// Add rewrite to url class
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		} else {
			return;
		}

		// Decode URL
		if (!isset($this->request->get['_route_'])) {
			$this->validate();
		} else {
			$route = $this->request->get['_route_'];
			unset($this->request->get['_route_']);
			$parts = explode('/', trim(utf8_strtolower($route), '/'));
			list($last_part) = explode('.', array_pop($parts));
			array_push($parts, $last_part);

			$rows = array();
			foreach ($parts as $keyword) {
				if (isset($this->cache_data['keywords'][$keyword])) {
					$rows[] = array('keyword' => $keyword, 'query' => $this->cache_data['keywords'][$keyword]);
				}
			}

			if (count($rows) == sizeof($parts)) {
				$queries = array();
				foreach ($rows as $row) {
					$queries[utf8_strtolower($row['keyword'])] = $row['query'];
				}

				reset($parts);
				foreach ($parts as $part) {

					// fix "undefined index" exception,
					// https://github.com/myopencart/ocStore/commit/51bd518ca3ee3330ae87314472f63def17dcf746
					if(!isset($queries[$part])) return false;

					$url = explode('=', $queries[$part], 2);

					if ($url[0] == 'category_id') {
						if (!isset($this->request->get['path'])) {
							$this->request->get['path'] = $url[1];
						} else {
							$this->request->get['path'] .= '_' . $url[1];
						}
					} elseif (count($url) > 1) {
						$this->request->get[$url[0]] = $url[1];
					}
				}
			} else {
				$this->request->get['route'] = 'error/not_found';
			}

			if (isset($this->request->get['product_id'])) {
				$this->request->get['route'] = 'product/product';
				if (!isset($this->request->get['path'])) {
					$path = $this->getPathByProduct($this->request->get['product_id']);
					if ($path) $this->request->get['path'] = $path;
				}
			} elseif (isset($this->request->get['path'])) {
				$this->request->get['route'] = 'product/category';
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$this->request->get['route'] = 'product/manufacturer/info';
			} elseif (isset($this->request->get['information_id'])) {
				$this->request->get['route'] = 'information/information';

			// compatibility with fastor blog
			} elseif (isset($this->request->get['article_id'])) {
			$this->request->get['route'] = 'blog/article';
			} elseif (isset($this->request->get['blog_path'])) {
			$this->request->get['route'] = 'blog/blog';

			// Compatibility with Shopencart News/Blog:
			} elseif (isset($this->request->get['news_id'])) {
				$this->request->get['route'] = 'news/article';
			} elseif (isset($this->request->get['author'])) {
				$this->request->get['route'] = 'news/ncategory';
			} elseif (isset($this->request->get['ncat'])) {
				$this->request->get['route'] = 'news/ncategory';
			} elseif (isset($this->request->get['author'])) {
				$this->request->get['route'] = 'news/ncategory';

			} elseif(isset($this->cache_data['queries'][$route_])) {
					header($this->request->server['SERVER_PROTOCOL'] . ' 301 Moved Permanently');
					$this->response->redirect($this->cache_data['queries'][$route_]);
			} else {
				if (isset($queries[$parts[0]])) {
					$this->request->get['route'] = $queries[$parts[0]];
				}
			}


			$this->validate();

			if (isset($this->request->get['route'])) {
				return new Action($this->request->get['route']);
			}
		}
	}

	public function rewrite($link, $code = '') {

		if (!$this->config->get('config_seo_url')) return $link;

		$seo_url = '';

		$component = parse_url(str_replace('&amp;', '&', $link));

		$data = array();
		parse_str($component['query'], $data);

		$route = $data['route'];
		unset($data['route']);

		switch ($route) {
			case 'common/home':
				if ($component['scheme'] == 'https') {
					$link = $this->config->get('config_ssl');
				} else {
					$link = $this->config->get('config_url');
				}
				if($code != $this->config_language.'/') {
					$link .= $code;
				}
				if(isset($this->cache_data['queries']['common/home'])) {
					$link .= $this->cache_data['queries']['common/home'];
				}
				// Return clean shop link with any GET-parameters stripped off
				return $link;
				// (if you want to pass all parameters on homepage as is, comment the line above: `// return $link;`)
				break;
			case 'product/product':
				if (isset($data['product_id'])) {
					// Whitelist GET parameters
					$tmp = $data;
					$data = array();
					if ($this->config->get('config_seo_url_include_path')) {
						$data['path'] = $this->getPathByProduct($tmp['product_id']);
						if (!$data['path']) return $link;
					}

					$allowed_parameters = array(
						'product_id', 'tracking',
						// Compatibility with "OCJ Merchandising Reports" module.
						// Save and pass-thru module specific GET parameters.
						'uri', 'list_type',
						// Compatibility with Google Analytics
						'gclid', 'utm_source', 'utm_medium', 'utm_campaign', 'utm_term', 'utm_content',
						'type', 'source', 'block', 'position', 'keyword',
						// Compatibility with Yandex Metrics, Yandex Market
						'yclid', 'ymclid', 'openstat', 'frommarket',
						'openstat_service', 'openstat_campaign', 'openstat_ad', 'openstat_source'
						);
					foreach($allowed_parameters as $ap) {
						if (isset($tmp[$ap])) {
							$data[$ap] = $tmp[$ap];
						}
					}

				}
				break;

			case 'product/category':
				if (isset($data['path'])) {
					$category = explode('_', $data['path']);
					$category = end($category);
					$data['path'] = $this->getPathByCategory($category);
					if (!$data['path']) return $link;
				}
				break;

			// pages retreived by AJAX requests
			case 'product/product/review':
			case 'information/information/info':
			case 'information/information/agree':
				return $link;
				break;

			default:
				break;
		}

		if ($component['scheme'] == 'https') {
			$link = $this->config->get('config_ssl');
		} else {
			$link = $this->config->get('config_url');
		}

		$link .= $code . 'index.php?route=' . $route;

		if (count($data)) {
			$link .= '&amp;' . urldecode(http_build_query($data, '', '&amp;'));
		}

		$queries = array();
		foreach ($data as $key => $value) {
			switch ($key) {
				case 'product_id':
				case 'manufacturer_id':
				case 'category_id':
				case 'information_id':
				case 'order_id':

				case 'search':
				case 'sub_category':
				case 'description':

				// compatibility with fastor blog
				case 'article_id':
				case 'blog_path':

				// Compatibility with Shopencart News/Blog:
				case 'news_id':
				case 'author':
				case 'ncat':
				case 'page':

					$queries[] = $key . '=' . $value;
					unset($data[$key]);
					$postfix = 1;
					break;

				case 'path':
					// ATTN: user can set any path: path=2_4_1_2_3
					$category_path = explode('_', $value);

					// find real category path:
					$category_id = end($category_path);
					$categories = $this->getPathByCategory($category_id);

					// save all categories queries to find later their aliases
					$categories = explode('_', $categories);
					foreach ($categories as $category) {
						$queries[] = 'category_id=' . $category;
					}
					unset($data[$key]);
					break;

				default:
					break;
			}
		}

		if(empty($queries)) {
			$queries[] = $route;
		}

		$rows = array();
		foreach($queries as $query) {
			if(isset($this->cache_data['queries'][$query])) {
				$rows[] = array('query' => $query, 'keyword' => $this->cache_data['queries'][$query]);
			}
		}

		if(count($rows) == count($queries)) {
			$aliases = array();
			foreach($rows as $row) {
				$aliases[$row['query']] = $row['keyword'];
			}
			foreach($queries as $query) {
				$seo_url .= '/' . rawurlencode($aliases[$query]);
			}
		}

		if ($seo_url == '') return $link;

		$seo_url = $code . trim($seo_url, '/');

		if ($component['scheme'] == 'https') {
			$seo_url = $this->config->get('config_ssl') . $seo_url;
		} else {
			$seo_url = $this->config->get('config_url') . $seo_url;
		}

		if (isset($postfix)) {
			$seo_url .= trim($this->config->get('config_seo_url_postfix'));
		} else {
			$seo_url .= '/';
		}

		if(substr($seo_url, -2) == '//') {
			$seo_url = substr($seo_url, 0, -1);
		}


		if (count($data)) {
			$seo_url .= '?' . urldecode(http_build_query($data, '', '&amp;'));
		}

		return $seo_url;
	}

	private function getPathByProduct($product_id) {
		$product_id = (int)$product_id;
		if ($product_id < 1) return false;

		static $path = null;
		if (!is_array($path)) {
			$path = $this->cache->get('product.seopath');
			if (!is_array($path)) $path = array();
		}

		if (!isset($path[$product_id])) {
			$query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . $product_id . "' ORDER BY main_category DESC LIMIT 1");

			$path[$product_id] = $this->getPathByCategory($query->num_rows ? (int)$query->row['category_id'] : 0);

			$this->cache->set('product.seopath', $path);
		}

		return $path[$product_id];
	}

	private function getPathByCategory($category_id) {
		$category_id = (int)$category_id;
		if ($category_id < 1) return false;

		static $path = null;
		if (!is_array($path)) {
			$path = $this->cache->get('category.seopath');
			if (!is_array($path)) $path = array();
		}

		if (!isset($path[$category_id])) {
			$max_level = 10;

			$sql = "SELECT CONCAT_WS('_'";
			for ($i = $max_level-1; $i >= 0; --$i) {
				$sql .= ",t$i.category_id";
			}
			$sql .= ") AS path FROM " . DB_PREFIX . "category t0";
			for ($i = 1; $i < $max_level; ++$i) {
				$sql .= " LEFT JOIN " . DB_PREFIX . "category t$i ON (t$i.category_id = t" . ($i-1) . ".parent_id)";
			}
			$sql .= " WHERE t0.category_id = '" . $category_id . "'";

			$query = $this->db->query($sql);

			$path[$category_id] = $query->num_rows ? $query->row['path'] : false;

			$this->cache->set('category.seopath', $path);
		}

		return $path[$category_id];
	}

	private function validate() {
		if (isset($this->request->get['route']) && ($this->request->get['route'] == 'error/not_found'
			|| preg_match('~^api/~',$this->request->get['route']) // Masks all api requests
				)) {
			return;
		}
		if (ltrim($this->request->server['REQUEST_URI'], '/') == 'sitemap.xml') {
			$this->request->get['route'] = 'feed/google_sitemap';
			return;
		}

		if(empty($this->request->get['route'])) {
			$this->request->get['route'] = 'common/home';
		}

		if (isset($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
			return;
		}

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$url = str_replace('&amp;', '&', $this->config->get('config_ssl') . ltrim($this->request->server['REQUEST_URI'], '/'));
			$seo = str_replace('&amp;', '&', $this->url->link($this->request->get['route'], $this->getQueryString(array('route')), 'SSL'));
		} else {
			$url = str_replace('&amp;', '&',
				substr($this->config->get('config_url'), 0, strpos($this->config->get('config_url'), '/', 10)) // leave only domain
				. $this->request->server['REQUEST_URI']);
			$seo = str_replace('&amp;', '&', $this->url->link($this->request->get['route'], $this->getQueryString(array('route')), 'NONSSL'));
		}

		if (rawurldecode($url) != rawurldecode($seo)) {
			// header($this->request->server['SERVER_PROTOCOL'] . ' 303 See Other');
			// $this->response->redirect($seo,303);
			header($this->request->server['SERVER_PROTOCOL'] . ' 301 Moved Permanently');
			$this->response->redirect($seo,301);
		}
	}

	private function getQueryString($exclude = array()) {
		if (!is_array($exclude)) {
			$exclude = array();
			}

		return urldecode(
			http_build_query(
				array_diff_key($this->request->get, array_flip($exclude))
				)
			);
		}
	}
