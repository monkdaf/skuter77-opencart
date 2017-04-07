<div class="container-fluid">
	<div class="row">
  		<div class="col-md-4">
    		<div class="box-heading">
      			<h3><i class="fa fa-user"></i>&nbsp;Ваша лицензия</h3>
    		</div>
			<?php if (empty($data['iwatermark']['LicensedOn'])): ?>
    			<div class="licenseAlerts"></div>
    			<div class="licenseDiv"></div>
                <table class="table notLicensedTable">
                	<tr>
                    	<td colspan="2">
                            <div class="form-group">
                                <label for="moduleLicense">Пожалуйста введите свой лицензионный ключ</label>
                                <input type="text" class="licenseCodeBox form-control" placeholder="Пример. XXXXXX-XXXXXX-XXXXXX-XXXXXX-XXXXXX" name="iwatermark[LicenseCode]" id="moduleLicense" value="<?php echo !empty($data['iwatermark']['LicenseCode']) ? $data['iwatermark']['LicenseCode'] : ''?>" />
                            </div>
                            <button type="button" class="btn btn-success btnActivateLicense"><i class="icon-ok"></i> Активировать ключ</button>
                        	<div class="pull-right"><button type="button" class="btn btn-link small-link" onclick="window.open('http://isenselabs.com/users/purchases/')">Как приобрести ключь ? Перейдите суда.&nbsp;<i class="fa fa-external-link"></i></button></div>
                  		</td>
                	</tr>
              	</table>
				<?php 
                    $hostname = (!empty($_SERVER['HTTP_HOST'])) ? $_SERVER['HTTP_HOST'] : '' ;
                    $hostname = (strstr($hostname,'http://') === false) ? 'http://'.$hostname: $hostname;
                ?>
				<script type="text/javascript">
                var domain='<?php echo base64_encode($hostname); ?>';
                var domainraw='<?php echo $hostname; ?>';
                var timenow=<?php echo time(); ?>;
                var MID = 'K4C4YXZ9K2';
                </script>
                <script type="text/javascript" src="//isenselabs.com/external/validate/"></script>
    		<?php endif; ?>
    
			<?php if (!empty($data['iwatermark']['LicensedOn'])): ?>
    			<input name="cHRpbWl6YXRpb24ef4fe" type="hidden" value="<?php echo base64_encode(json_encode($data['iwatermark']['License'])); ?>" />
    			<input name="OaXRyb1BhY2sgLSBDb21" type="hidden" value="<?php echo $data['iwatermark']['LicensedOn']; ?>" />
    			<table class="table licensedTable">
                    <tr>
                    	<td>Владелец ключа</td>
                    	<td><?php echo $data['iwatermark']['License']['customerName']; ?></td>
                    </tr>
                	<tr>
                		<td>Регистрация домена</td>
                		<td>
                    		<ul class="registeredDomains">
                    			<?php foreach ($data['iwatermark']['License']['licenseDomainsUsed'] as $domain): ?>
                        			<li><i class="fa fa-check"></i>&nbsp;<?php echo $domain; ?></li>
                    			<?php endforeach; ?>
                    		</ul>
                		</td>
                	</tr>
                	<tr>
                		<td>Лицензия истечет</td>
                		<td><?php echo date("F j, Y",strtotime($data['iwatermark']['License']['licenseExpireDate'])); ?></td>
                	</tr>
                	<tr>
                    	<td colspan="2" style="text-align:center;background-color:#EAF7D9;">VALID LICENSE ( <a href="http://isenselabs.com/users/purchases" target="_blank">manage</a> )</td>
                	</tr>
				</table>
    		<?php endif; ?>
  		</div>
  
		<div class="col-md-8">
    		<div class="box-heading">
      			<h3><i class="fa fa-users"></i>&nbsp;Поддержка</h3>
    		</div>
    		<div class="box-contents">
            	<div class="container-fluid">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="thumbnail">
                                <img alt="Community support" style="width: 300px;" src="view/image/iwatermark/community.png">
                                <div class="caption" style="text-align:center;padding-top:0px;">
                                    <h3>Сообщество</h3>
                                    <p>Вы можете задать вопрос в сообществе на форуме iSenseLabs (Нужно знание Англ-яз). </p>
                                    <p style="padding-top: 5px;"><a href="http://isenselabs.com/forum" target="_blank" class="btn btn-lg btn-default">Перейти на форум</a></p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="thumbnail">
                                <img data-src="holder.js/300x200" alt="Ticket support" style="width: 300px;" src="view/image/iwatermark/tickets.png">
                                <div class="caption" style="text-align:center;padding-top:0px;">
                                    <h3>Тикеты</h3>
                                    <p>Вы можете открыть тикет в тех поддержке для решения своих проблем.</p>
                                    <p style="padding-top: 5px;"><a href="http://isenselabs.com/tickets/open/<?php echo base64_encode('Support Request').'/'.base64_encode('125').'/'. base64_encode($_SERVER['SERVER_NAME']); ?>" target="_blank" class="btn btn-lg btn-default">Открыть тикет</a></p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="thumbnail">
                                <img alt="Pre-sale support" style="width: 300px;" src="view/image/iwatermark/pre-sale.png">
                                <div class="caption" style="text-align:center;padding-top:0px;">
                                    <h3>Заказ услуг</h3>
                                    <p>Мы воплощаем все ваши желания в реальнось относительно вашего магазина.(Знание разговорного Англ-яз обязательно)</p>
                                    <p style="padding-top: 5px;"><a href="mailto:sales@isenselabs.com?subject=Pre-sale question" target="_blank" class="btn btn-lg btn-default">Заказать услугу</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
				</div>
            </div>
		</div>
	</div>
</div>