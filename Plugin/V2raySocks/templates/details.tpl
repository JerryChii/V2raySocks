<!-- CSS -->
<link rel="stylesheet" href="modules/servers/{$module}/templates/static/css/style.css">
<script src="modules/servers/{$module}/templates/static/js/Chart.js"></script>
<script src="modules/servers/{$module}/templates/static/js/qrcode.js"></script>
<script src="modules/servers/{$module}/templates/static/js/html5-qrcode.js"></script>
<script>
    function send(arg) {
      CreateXMLHttpRequest();
      xmlhttp.onreadystatechange = callhandle;
      xmlhttp.open("GET", arg,true);
      xmlhttp.onreadystatechange = processResponse;
      xmlhttp.send(null);
    }

    function CreateXMLHttpRequest() {
      if (window.ActiveXObject) {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      else if (window.XMLHttpRequest) {
        xmlhttp = new XMLHttpRequest();
      }
    }
    
    function callhandle() {
      if (xmlhttp.readyState == 4) {
        if (xmlhttp.status == 200) {
          alert(xmlhttp.responseText);
        }
      }
    }
    
    function processResponse(){
        if(xmlhttp.readyState == 4){     //判断对象状态
            if(xmlhttp.status == 200){
            }else{
                //alert("HTTP 200");
            }
        }
    }
</script>
<style>
.table-container
{
width: 100%;
overflow-y: auto;
_overflow: auto;
margin: 0 0 1em;
}

.table-container::-webkit-scrollbar
{
-webkit-appearance: none;
width: 14px;
height: 14px;
}

.table-container::-webkit-scrollbar-thumb
{
border-radius: 8px;
border: 3px solid #fff;
background-color: rgba(0, 0, 0, .3);
}

.table-container-outer { position: relative; }

.table-container-fade
{
	position: absolute;
	right: 0;
	width: 30px;
	height: 100%;
	background-image: -webkit-linear-gradient(0deg, rgba(255,255,255,.5), #fff);
	background-image: -moz-linear-gradient(0deg, rgba(255,255,255,.5), #fff);
	background-image: -ms-linear-gradient(0deg, rgba(255,255,255,.5), #fff);
	background-image: -o-linear-gradient(0deg, rgba(255,255,255,.5), #fff);
	background-image: linear-gradient(0deg, rgba(255,255,255,.5), #fff);
}
</style>
{if ($infos)}
	<div class="alert alert-success">
		<p>{$infos|unescape:"html"}</p>
	</div>
{/if}
<div class="plugin">
    <div class="row">
        <div class="col-md-12">
            <aside class="profile-nav alt hidden-xs">
                <section class="panel">
                    <ul class="nav nav-pills nav-stacked">
                        <li><a href="javascript:;"> <i class="fa fa-calendar-check-o"></i> {$LANG.clientareahostingregdate} : {$regdate} </a></li>
                        <li><a href="javascript:;"> <i class="fa fa-list-alt"></i> {$LANG.orderproduct} : {$groupname} - {$product} </a></li>
                        <li><a href="javascript:;"> <i class="fa fa-money"></i> {$LANG.orderpaymentmethod} : {$paymentmethod} {$LANG.firstpaymentamount}({$firstpaymentamount}) - {$LANG.recurringamount}({$recurringamount})</a></li>
                        <li><a href="javascript:;"> <i class="fa fa-spinner"></i> {$LANG.clientareahostingnextduedate} : {$nextduedate} {$LANG.orderbillingcycle}({$billingcycle}) </a></li>
                        <li><a href="javascript:;"> <i class="fa fa-check-square-o"></i> {$LANG.clientareastatus} : {$status} </a></li>
						<li><a href="javascript:;"> <i class="fa fa-check-square-o"></i> {V2raySocks_get_lang('data_update_at')} : {$nowdate} </a></li>
                    </ul>
                </section>
            </aside>
            <section class="panel">
                <header class="panel-heading">
                    {V2raySocks_get_lang('user_info')}
                </header>
                <div class="panel-body table-container">
                    <table class="table general-table">
                        <thead>
                            <tr>
                                <th>{V2raySocks_get_lang('uuid')}</th>
                                <th class="hidden-xs hidden-sm">{V2raySocks_get_lang('created_at')}</th>
                                <th class="hidden-sm hidden-xs">{V2raySocks_get_lang('last_use_time')}</th>
                                <th class="hidden-sm hidden-xs">{V2raySocks_get_lang('action')}</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>{$usage.uuid}
                                    <button name="url" class="btn btn-primary btn-xs btyuuid" data-unit=".btyuuid" data-params="{$usage.uuid}" data-done="{V2raySocks_get_lang('copy_success')}">
                                            <i class="fa fa-code"></i>
                                            {V2raySocks_get_lang('copy')}
                                        </button>
                                </td>
                                <td class="hidden-xs hidden-sm">{$usage.created_at|date_format:'%Y-%m-%d %H:%M:%S'}</td>
                                <td class="hidden-sm hidden-xs">{$usage.t|date_format:'%Y-%m-%d %H:%M:%S'}</td>
                                <td class="hidden-xs hidden-sm"><button type='button' class='btn btn-xs btn-danger btn-block' onclick='ResetUUID{$serviceid}()'>{V2raySocks_get_lang('resetUUID')}</button>
                                <script>
                                    function ResetUUID{$serviceid}(){
                                        layer.confirm('{V2raySocks_get_lang('are_you_sure')}?', {
                                          btn: ['{V2raySocks_get_lang('confirm')}','{V2raySocks_get_lang('cancel')}']
                                        }, function(){
                                          send('{$smarty.server.REQUEST_URI|replace:'&amp;':'&'}&V2raySocksAction=ResetUUID&Serviceid={$serviceid}');
                                          layer.msg('{V2raySocks_get_lang('success')}!');
                                          {literal}setTimeout(function(){location.reload();},2000);{/literal}
                                        });
                                    }
                                </script>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    {if $enable_subscribe == 1}
                        <table class="table general-table">
                            <thead>
                                <tr>
                                    <th>{V2raySocks_get_lang('subscribe')}</th>
                                    <th class="hidden-sm hidden-xs">{V2raySocks_get_lang('action')}</th>
                                    <th class="hidden-sm hidden-xs">{V2raySocks_get_lang('action')}</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>IOS</td>
                                        <td>
                                        <button name="url" class="btn btn-primary btn-xs btyurlios" data-unit=".btyurlios" data-params="https://{$HTTP_HOST}/modules/servers/V2raySocks/subscribe.php?sid={$serviceid}&token={$subscribe_token}" data-done="{V2raySocks_get_lang('copy_success')}">
                                                <i class="fa fa-code"></i>
                                                {V2raySocks_get_lang('copy')}
                                            </button>
                                    </td>
                                    <td class="hidden-xs hidden-sm"><button type='button' class='btn btn-xs btn-danger btn-block' onclick='resetToken{$serviceid}()'>{V2raySocks_get_lang('resetToken')}</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Android/Win</td>
                                    <td>
                                        <button name="url" class="btn btn-primary btn-xs btyurlothers" data-unit=".btyurlothers" data-params="https://{$HTTP_HOST}/modules/servers/V2raySocks/osubscribe.php?sid={$serviceid}&token={$subscribe_token}" data-done="{V2raySocks_get_lang('copy_success')}">
                                                <i class="fa fa-code"></i>
                                                {V2raySocks_get_lang('copy')}
                                            </button>
                                    </td>
                                    <td class="hidden-xs hidden-sm"><button type='button' class='btn btn-xs btn-danger btn-block' onclick='resetToken{$serviceid}()'>{V2raySocks_get_lang('resetToken')}</button>
                                    </td>
                                </tr>
                            </tbody>
                            <script>
                                function resetToken{$serviceid}(){
                                    layer.confirm('{V2raySocks_get_lang('are_you_sure')}?', {
                                      btn: ['{V2raySocks_get_lang('confirm')}','{V2raySocks_get_lang('cancel')}']
                                    }, function(){
                                      send('{$smarty.server.REQUEST_URI|replace:'&amp;':'&'}&V2raySocksAction=ResetToken&Serviceid={$serviceid}');
                                      layer.msg('{V2raySocks_get_lang('success')}!');
                                      {literal}setTimeout(function(){location.reload();},2000);{/literal}
                                    });
                                }
                            </script>
                        </table>
                    {/if}
                </div>
            </section>
            
            <section class="panel">
                <header class="panel-heading">
                    {V2raySocks_get_lang('usage_chart')} ({V2raySocks_get_lang('bandwidth')}：{$usage.tr_MB_GB})
                </header>
                <div class="panel-body" id="plugin-usage">
                    <p>{V2raySocks_get_lang('used')} ({$usage.s_MB_GB})</p>
                    <div class="progress progress-striped progress-sm">
                        <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="{($usage.sum/$usage.transfer_enable)*100}" aria-valuemin="0" aria-valuemax="100" style="width: {($usage.sum/$usage.transfer_enable)*100}%">
                            <span class="sr-only">{($usage.sum/$usage.transfer_enable)*100}% Complete</span>
                        </div>
                    </div>
                    <p>{V2raySocks_get_lang('upload')} ({$usage.u_MB_GB})</p>
                    <div class="progress progress-striped progress-sm">
                        <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="{($usage.u/$usage.transfer_enable)*100}" aria-valuemin="0" aria-valuemax="100" style="width: {($usage.u/$usage.transfer_enable)*100}%">
                            <span class="sr-only">{($usage.u/$usage.transfer_enable)*100}% Complete (warning)</span>
                        </div>
                    </div>
                    <p>{V2raySocks_get_lang('download')} ({$usage.d_MB_GB})</p>
                    <div class="progress progress-striped progress-sm">
                        <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="{($usage.d/$usage.transfer_enable)*100}" aria-valuemin="0" aria-valuemax="100" style="width: {($usage.d/$usage.transfer_enable)*100}%">
                            <span class="sr-only">{($usage.d/$usage.transfer_enable)*100}% Complete (danger)</span>
                        </div>
                    </div>
                </div>
            </section>
            
            <section class="panel">
                <header class="panel-heading">
                    {V2raySocks_get_lang('routelist')}
                </header>
                <div class="panel-body table-container">
                    <table class="table table-hover general-table">
                        <thead>
                            <tr>
                                <th>{V2raySocks_get_lang('name')}</th>
                                <th class="hidden-xs hidden-sm">{V2raySocks_get_lang('address')}</th>
                                <th class="hidden-xs hidden-sm">{V2raySocks_get_lang('port')}</th>
                                <th class="hidden-xs hidden-sm">{V2raySocks_get_lang('type')}</th>
                                <th class="hidden-xs hidden-sm">{V2raySocks_get_lang('host')}</th>
                                <th class="hidden-xs hidden-sm">{V2raySocks_get_lang('path')}</th>
                                <th class="hidden-xs hidden-sm">{V2raySocks_get_lang('network')}</th>
                                <th class="hidden-xs hidden-sm">TLS</th>
                                <th class="hidden-xs hidden-sm">{V2raySocks_get_lang('trafficrate')}</th>
                                <th class="hidden-xs hidden-sm">{V2raySocks_get_lang('alterId')}</th>
                                <th>{V2raySocks_get_lang('action')}</th>
                            </tr>
                        </thead>
                        <tbody>
							{$yy = 0}
                            {foreach $nodes as $node }
                            <tr>
                                <td>{$node[0]}</td>
                                <td class="hidden-xs hidden-sm">{$node[1]}</td>
                                <td class="hidden-xs hidden-sm">{$node[2]}</td>
                                <td class="hidden-xs hidden-sm">{if ($node[3])}{$node[3]}{else}X{/if}</td>
                                <td class="hidden-xs hidden-sm">{if ($node[5])}{$node[5]}{else}X{/if}</td>
                                <td class="hidden-xs hidden-sm">{if ($node[6])}{$node[6]}{else}X{/if}</td>
                                <td class="hidden-xs hidden-sm">{if ($node[7])}{$node[7]}{else}X{/if}</td>
                                <td class="hidden-xs hidden-sm">{if ($node[4])}{$node[4]}{else}X{/if}</td>
                                <td class="hidden-xs hidden-sm">{if ($node[8])}{$node[8]}{else}1{/if}</td>
                                <td class="hidden-xs hidden-sm">{if ($node[9])}{$node[9]}{else}64{/if}</td>
                                <td data-hook="action">
                                        <button name="qrcode" class="btn btn-primary btn-xs" data-type="vmess{V2raySocks_get_lang('show_QRcode')}" data-params="{$node['url']['ios']|unescape:"htmlall"}">
                                            <i class="fa fa-qrcode"></i>
                                            IOS
                                        </button>
                                        <button name="qrcode" class="btn btn-primary btn-xs" data-type="vmess{V2raySocks_get_lang('show_QRcode')}" data-params="{$node['url']['win']|unescape:"htmlall"}">
                                            <i class="fa fa-qrcode"></i>
                                            {V2raySocks_get_lang('show_QRcode')}
                                        </button>
                                        <button name="url" class="btn btn-primary btn-xs bty{$yy}" data-unit=".bty{$yy}" data-params="{$node['url']['win']|unescape:"htmlall"}" data-done="{V2raySocks_get_lang('copy_success')}">
                                            <i class="fa fa-code"></i>
                                            URL
                                        </button>
                                    {$yy = $yy + 1}
                                </td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </section>
            <script>

                
            </script>

			{if ($script)}
			<section class="panel">
                <header class="panel-heading">
                    {V2raySocks_get_lang('traffic_chart')} ({$datadays} {V2raySocks_get_lang('days')})
                </header>
                <div class="panel-body" id="chart-usage">
					<div class="tab-content margin-bottom">
                        <ul class="nav nav-tabs" id="myTab" >                                                                  
                            <li class="active">
                                <a href="#totalcOverview" data-toggle="tab" >{V2raySocks_get_lang('all_traffic_chart')}</a>
                            </li>
                            <li>
                                <a href="#uploadcOverview" data-toggle="tab" >{V2raySocks_get_lang('upload_traffic_chart')}</a>
                            </li>
                            <li>
                                <a href="#downloadcOverview" data-toggle="tab">{V2raySocks_get_lang('download_traffic_chart')}</a>
                            </li>
                        </ul>
                        <div role="tabpanel" class="tab-pane fade in active" id="totalcOverview">
                            <h3 class="block-title text-primary"></h3>
                            <canvas id="totalc" ></canvas>
                        </div>
                        <div role="tabpanel" class="tab-pane fade in active" id="uploadcOverview">
                            <h3 class="block-title text-primary"></h3>
                            <canvas id="uploadc" ></canvas>
                        </div>
                        <div role="tabpanel" class="tab-pane fade in active" id="downloadcOverview">
                            <h3 class="block-title text-primary"></h3>
                            <canvas id="downloadc" ></canvas>
                        </div>
                    </div>
					<script src="/assets/js/bootstrap-tabdrop.js"></script>
					<script type="text/javascript">
						{$script|unescape:"htmlall"}
                        $("#uploadcOverview").removeClass("active");
                        $("#downloadcOverview").removeClass("active");
					</script>
                </div>
            </section>
			{/if}
			
        </div>
    </div>
</div>
<!-- JavsScript -->
<script src="modules/servers/{$module}/templates/static/layer.js"></script>
<script src="modules/servers/{$module}/templates/static/js/script.js" charset="utf-8"></script>
<script src="modules/servers/{$module}/templates/static/js/clipboard.min.js" charset="utf-8"></script>