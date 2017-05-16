<?php echo $header;
$theme_options = $this->registry->get('theme_options');
$config = $this->registry->get('config');
include('catalog/view/theme/'.$config->get('config_template').'/template/new_elements/wrapper_top.tpl'); ?>

<div class="col-sm-4">
  <h3>
    <a href="/giroskutery/">Гироскутеры</a>
  </h3>
  <ul>
    <li>
      <a href="/hoverbot/">Hoverbot</a>
    </li>
    <li>
      <a href="/smart-balance/">Smart Balance</a>
    </li>
    <li>
      <a href="/kiwano/">Kiwano</a>
    </li>
    <li>
      <a href="/chic/">Chic</a>
    </li>
    <li>
      <a href="/razor/">Razor</a>
    </li>
    <li>
      <a href="/wmotion-logo/">Wmotion</a>
    </li>
  </ul>
</div>
<div class="col-sm-4">
  <h3>
    <a href="/monokoleso/">Моноколесо</a>
  </h3>
  <ul>
    <li>
      <a href="/hoverbot/">Hoverbot</a>
    </li>
    <li>
      <a href="/airwheel/">Airwheel</a>
    </li>
    <li>
      <a href="/inmotion/">Inmotion</a>
    </li>
    <li>
      <a href="/ips/">IPS</a>
    </li>
    <li>
      <a href="/ecodrift/">Ecodrift</a>
    </li>
    <li>
      <a href="/firewheel/">FireWheel</a>
    </li>
    <li>
      <a href="/wmotion-logo/">Wmotion</a>
    </li>
    <li>
      <a href="/ninebot/">Ninebot</a>
    </li>
  </ul>
</div>
<div class="col-sm-4">
  <h3>
    <a href="/sigvei/">Сигвеи</a>
  </h3>
  <ul>
    <li>
      <a href="/hoverbot/">Hoverbot</a>
    </li>
    <li>
      <a href="/airwheel/">Airwheel</a>
    </li>
    <li>
      <a href="/inmotion/">Inmotion</a>
    </li>
    <li>
      <a href="/ninebot/">Ninebot</a>
    </li>
  </ul>
</div>

<?php include('catalog/view/theme/'.$config->get('config_template').'/template/new_elements/wrapper_bottom.tpl'); ?>
<?php echo $footer; ?>
