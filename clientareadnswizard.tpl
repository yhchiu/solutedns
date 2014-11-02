{include file="$template/pageheader.tpl" title=$MLANG.title}
<h3><i class="fa fa-globe"></i> {$MLANG.domainname}: <small>{$domain}</small></h3>
{if $dnswizard eq 'true'}
{else}
<p><input class="btn btn-sm btn-info" id="wizard" type="button" onclick="location.href='index.php?m=solutedns&{$product_type}id={$localid}&wizard=yes'" value='{$MLANG.wizard}'></p>
{/if}
<p>{$MLANG.domaindnsmanagementdesc}</p>
{if $status_msg}
<div {if $dnsrecords}id="msgbox" {/if}class="alert alert-warning">
	<h4>{$status_msg.title}</h4>
	<p>{$status_msg.desc}</p>
</div>
{/if}
{if $showwizard}
<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">{$MLANG.WIZARD_TITLE}</h3>
	</div>
	<div class="panel-body">
		{if $wizard_page eq 'home'}
		<h4>{$MLANG.WIZARD_START}</h4>
		<ul>
			<li><a href="index.php?m=solutedns&{$product_type}id={$localid}&wizard=1&step=1">{$MLANG.WIZARD_GENERAL}</a></li>
			<li><a href="index.php?m=solutedns&{$product_type}id={$localid}&wizard=2">{$MLANG.WIZARD_SUBDOMAIN}</a></li>
			<li><a href="index.php?m=solutedns&{$product_type}id={$localid}&wizard=3">{$MLANG.WIZARD_COPYZONE}</a></li>
			<li><a href="index.php?m=solutedns&{$product_type}id={$localid}&wizard=4">{$MLANG.WIZARD_CREATESRV}</a></li>
		</ul>		
		<div class="pull-right">
			<input class="btn-wizard btn btn-info" id="back" type="button" onclick="location.href='index.php?m=solutedns&{$product_type}id={$localid}'" value="{$MLANG.btn_back}" />
		</div>
		{elseif $wizard_page eq 'setup'}
		{if $wizard_step eq '1'}
		<h3>{$MLANG.WIZARD_SETUP_TITLE}</h3>
		<p>{$MLANG.WIZARD_SETUP_DESC}</p>
		<p>{$MLANG.WIZARD_SETUP_DESC2}</p>
		<div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i> {$MLANG.WIZARD_SETUP_WARN}</div>
		<div class="pull-right">
			<div class="form-group">	
				<input class="btn-wizard btn btn-success" id="back" type="button" onclick="location.href='index.php?m=solutedns&{$product_type}id={$localid}&wizard=1&step=1b'" value='{$MLANG.btn_continue}'>
				<input class="btn-wizard btn btn-info" id="back" type="button" onclick="location.href='index.php?m=solutedns&{$product_type}id={$localid}&wizard=yes'" value='{$MLANG.btn_back}'>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="progress">
					<div class="progress-bar progress-bar-info progress-bar-striped" role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" style="width: 10%">
						<span class="sr-only">10% Complete</span>
					</div>
				</div>
			</div>
		</div>
		{elseif $wizard_step eq '2'}
		<form name="setup1" method="post" action="{$smarty.server.PHP_SELF}?m=solutedns&{$product_type}id={$localid}&wizard=1&step=2">
			<input type="hidden" name="setup1" value="1" />
			<input type="hidden" name="name" value="{$domain}" />
			<input type="hidden" name="type" value="A" />
			<input type="hidden" name="ttl" value="{$default_ttl}" />
			<div class="form-group">
				<label>{$MLANG.WIZARD_SETUP_WEBSERVER_IP}</label>
				<input name="content" type="text" id="content" value="" class="form-control">
			</div>
			<div class="pull-right">
				<div class="form-group">
					<input class="btn btn-success" type="submit" name="setup1" value="{$MLANG.btn_continue}">
				</div>
			</div>
		</form>
		<div class="row">
			<div class="col-md-12">
				<div class="progress">
					<div class="progress-bar progress-bar-info progress-bar-striped" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%">
						<span class="sr-only">45% Complete</span>
					</div>
				</div>
			</div>
		</div>
		{elseif $wizard_step eq '3'}
		<p>{$MLANG.WIZARD_SETUP_MAILSERVER_IP}</p>
		
		<form name="setup2" method="post" action="{$smarty.server.PHP_SELF}?m=solutedns&{$product_type}id={$localid}&wizard=1&step=2" >
			<input type="hidden" name="setup2" value="3" />
			<input type="hidden" name="name" value="{$domain}" />
			<input type="hidden" name="type" value="A" />
			<input type="hidden" name="prio" value="10" />
			<input type="hidden" name="ttl" value="{$default_ttl}" />
			<input name="content" type="text" id="content" value="">
			<div class="float-R btn-wizard">
				<input class="btn btn-success" type="submit" name="setup2" value="{$MLANG.btn_continue}">
			</div>
		</form>
		<div class="row">
			<div class="col-md-12">
				<div class="progress">
					<div class="progress-bar progress-bar-info progress-bar-striped" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%">
						<span class="sr-only">75% Complete</span>
					</div>
				</div>
			</div>
		</div>
		{/if}
		{elseif $wizard_page eq 'subdomain'}
		<p>{$MLANG.WIZARD_SUBDOMAIN_DESC}</p><br />
		<form name="newsub" method="post" action="{$smarty.server.PHP_SELF}?m=solutedns&{$product_type}id={$localid}&wizard=2" >
			<input type="hidden" name="type" value="A" />
			<input type="hidden" name="ttl" value="{$default_ttl}" />
			<div class="row">
				<div class="col-sm-6">
					<div class="form-group">
						<label>{$MLANG.WIZARD_NAME}</label>
						<input name="name" type="text" value="" class="form-control">
						<span class="help-block">.{$domain}</span>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group">
						<label>{$MLANG.WIZARD_IP}</label>
						<input name="content" type="text" value="" class="form-control">
					</div>
				</div>
			</div>
			<div class="pull-right">
				<div class="form-group">
					<input class="btn btn-success" type="submit" name="newsub" value="{$MLANG.btn_add}">
				</form>
				<input class="btn-wizard btn btn-info" id="back" type="button" onclick="location.href='index.php?m=solutedns&{$product_type}id={$localid}&wizard=yes'" value='{$MLANG.btn_back}'>
			</div>
		</div>
		{elseif $wizard_page eq 'copyzone'}
		<h4>{$MLANG.WIZARD_COPYZONE_TITLE}</h4>
		<p>{$MLANG.WIZARD_COPYZONE_DESC}</p>
		<form name="copyzone" method="post" action="{$smarty.server.PHP_SELF}?m=solutedns&{$product_type}id={$localid}&wizard=3" >
			<div class="form-group">
				<select name="from" class="form-control">
					{foreach from=$clientdomainlist item=ctrdomain}
					<option value="{$ctrdomain.domain}">{$ctrdomain.domain}</option>
					{foreachelse}
					<option value="{$domain}">{$MLANG.WIZARD_COPYZONE_NOTAVAILABLE}</option>
					{/foreach}
				</select>
			</div>
			<div class="alert alert-warning">{$MLANG.WIZARD_COPYZONE_WARN}</div>
			<div class="pull-right">
				<div class="form-group">
					<input class="btn btn-success" type="submit" name="copyzone" value="{$MLANG.btn_continue}" {if $clientdomaincount < 1}disabled{/if}/>
					<input class="btn-wizard btn btn-info" id="back" type="button" onclick="location.href='index.php?m=solutedns&{$product_type}id={$localid}&wizard=yes'" value="{$MLANG.btn_back}" />
				</div>
			</div>	
		</form>
		{elseif $wizard_page eq 'addsrv'}
		<p>{$MLANG.WIZARD_SRV_DESC}</p><br />
		<form name="newsrv" method="post" action="{$smarty.server.PHP_SELF}?m=solutedns&{$product_type}id={$localid}&wizard=4" >
			<div class="row">
				<div class="col-sm-4">
					<div class="form-group">
						<label>Service</label>
						<input class="form-control" name="service" type="text" value="ldap">
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label>Protocol</label>
						<select name="protocol" class="form-control">
							<option value="_tcp.">TCP</option>
							<option value="_udp.">UDP</option>
						</select>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label>Domain</label>	
						<p class="form-control-static">.<?php echo $domain;?></p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4">
					<div class="form-group">
						<label>TTL</label>	
						<input class="form-control" name="ttl" type="text" value="{$default_ttl}">
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label>Priority</label>	
						<input class="form-control" name="priority" type="text" value="">
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<label>Weight</label>	
						<input class="form-control" name="weight" type="text" value="">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="form-group">
						<label>Target</label>
						<input name="target" type="text" value="" class="form-control">
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group">
						<label>Port</label>	
						<input class="form-control" name="port" type="text" value="">
					</div>
				</div>
			</div>
			<div class="pull-right">
				<div class="form-group">
					<input class="btn btn-success" type="submit" name="newsrv" value="{$MLANG.btn_add}">
				</form>
				<input class="btn-wizard btn btn-info" id="back" type="button" onclick="location.href='index.php?m=solutedns&{$product_type}id={$localid}&wizard=yes'" value="{$MLANG.btn_back}" />
			</div>
		</div>
		{/if}
	</div> <!-- End Wizard -->
</div> <!-- End Wizard Container -->
{/if}
<form method="post" action="index.php?m=solutedns&{$product_type}id={$localid}">
	<input type="hidden" name="id" value="{$localid}" />
	<div class="pull-right"><input type="submit" value="{$LANG.clientareabacklink}" class="btn btn-default" /></div>
</form>