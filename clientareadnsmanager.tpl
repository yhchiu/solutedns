{include file="$template/pageheader.tpl" title=$MLANG.title}
<h3><i class="fa fa-globe"></i> {$MLANG.domainname}: <small>{$domain}</small>
	{if $dnswizard eq 'true'}
	{else}
	<span class="pull-right"><input class="btn btn-sm btn-info" id="wizard" type="button" onclick="location.href='index.php?m=solutedns&amp;{$product_type}id={$localid}&amp;wizard=yes'" value='{$MLANG.wizard}'></span>
	{/if}
</h3>
<p><small>{$MLANG.domaindnsmanagementdesc}</small></p>
{if $status_msg}
<div {if $dnsrecords}id="msgbox" {/if}class="alert alert-info">
	<p>{$status_msg.title} {$status_msg.desc}</p>
</div>
{/if}
{if $delete_confirmation}
<div class="alert alert-danger">
	<h4>{$MLANG.confirm_delete_title} {$MLANG.confirm_delete_message}</h4>	
	<div class="form-group">
		<input class="btn btn-sm btn-danger" id="delete" type="button" onClick="location.href='{$delete_confirmation.confirm}'" value="{$MLANG.btn_delete}">
		<input class="btn btn-sm btn-default" id="cancel" type="button" onClick="location.href='{$delete_confirmation.cancel}'" value="{$MLANG.btn_cancel}">
	</div>
</div>
{/if}
{if $dnsrecords}
<div class="table-responsive">
	<table class="table">
		<tr>
			<th {if $dns_orderby eq "name"} class="headerSort{$dns_sort}"{/if}><a href="{$smarty.server.PHP_SELF}?m=solutedns&amp;{$dns_product_type}={$localid}&name_{$dns_osort.name}">{$MLANG.name}</a></th>
			<th {if $dns_orderby eq "type"} class="headerSort{$dns_sort}"{/if}><a href="{$smarty.server.PHP_SELF}?m=solutedns&amp;{$dns_product_type}={$localid}&type_{$dns_osort.type}">{$MLANG.type}</a></th>
			<th {if $dns_orderby eq "content"} class="headerSort{$dns_sort}"{/if}><a href="{$smarty.server.PHP_SELF}?m=solutedns&amp;{$dns_product_type}={$localid}&content_{$dns_osort.content}">{$MLANG.content}</a></th>
			<th>{$MLANG.prio}</th>
			<th>{$MLANG.ttl}</th>
			<th></th>
		</tr>
		<form method="post" action="{$smarty.server.PHP_SELF}?m=solutedns&amp;{$dns_product_type}={$localid}">
			<input type="hidden" name="sdns_remoteid" value="{$remoteid}" />
			<input type="hidden" name="sdns_action" value="edit" />
			{foreach from=$dnsrecords item=dnsrecord}
			<tr id="row_{$dnsrecord.id}">
				<td><input type="hidden" id="dnsrecid{$dnsrecord.id}" name="dnsrecid[{$dnsrecord.id}]" value="{$dnsrecord.id}" class="form-control" /><input disabled type="text" id="dnsrecordname{$dnsrecord.id}" name="dnsrecordname[{$dnsrecord.id}]" value="{$dnsrecord.name}" class="form-control" /></td>
				<td><select disabled id="dnsrecordtype{$dnsrecord.id}" name="dnsrecordtype[{$dnsrecord.id}]" class="form-control">
					{foreach from=$dnstypes item=dnstype}
					<option value="{$dnstype}"{if $dnstype eq $dnsrecord.type} selected="selected"{/if}>{$dnstype}</option> 
					{/foreach}
					{if $dnsrecord.type != $dnstype}
					<option value="{$dnsrecord.type}" selected="selected">{$dnsrecord.type}</option>
					{/if}
					{if $dnsrecord.type eq "SOA"}
					<option value="SOA"{if $dnsrecord.type eq "SOA"} selected="selected"{/if}>SOA</option>
					{/if}
					{if $dnsrecord.type eq "NS"}
					<option value="NS"{if $dnsrecord.type eq "NS"} selected="selected"{/if}>NS</option>
					{/if}
				</select></td>
				<td><input disabled type="text" id="dnsrecordcontent{$dnsrecord.id}" name="dnsrecordcontent[{$dnsrecord.id}]" value="{$dnsrecord.content}" class="form-control" /></td>
				<td><input disabled type="text" id="dnsrecordprio{$dnsrecord.id}" name="dnsrecordprio[{$dnsrecord.id}]" value="{$dnsrecord.prio}" class="form-control" /></td>
				<td>{if $dispset.pre_ttl eq "true"}
					<select disabled id="dnsrecordttl{$dnsrecord.id}" name="dnsrecordttl[{$dnsrecord.id}]" class="form-control">
						<option value="60" {if $dnsrecord.ttl eq "60"}selected=selected{/if}>1 minute</option>
						<option value="300" {if $dnsrecord.ttl eq "300"}selected=selected{/if}>5 minutes</option>
						<option value="3600" {if $dnsrecord.ttl eq "3600"}selected=selected{/if}>1 hour</option>
						<option value="86400" {if $dnsrecord.ttl eq "86400"}selected=selected{/if}>1 day</option>
					</select>
					{else}
					<input disabled type="text" id="dnsrecordttl{$dnsrecord.id}" name="dnsrecordttl[{$dnsrecord.id}]" value="{$dnsrecord.ttl}" class="form-control" />
					{/if}</td>
					<td class="sdns_client_management"><input {if $dnsrecord.type eq "SOA"}disabled style="display: none;" {elseif $dnsrecord.type eq "NS" && $dispset.disable_ns eq "true"}disabled style="display: none;"{/if} class="btn btn-sm btn-primary" style="display: visible;" id="dnsrecordedit{$dnsrecord.id}" onClick="edit('{$dnsrecord.id}')" type="button" value="{$MLANG.btn_edit}">
						<input class="btn btn-sm btn-warning" style="display: none;" id="dnsrecordsave{$dnsrecord.id}" name="dnsrecordedit[{$dnsrecord.id}]" type="submit" value="{$MLANG.btn_save}">
          <input {if $dnsrecord.type eq "SOA"}disabled{elseif $dnsrecord.type eq "NS" && $dispset.disable_ns eq "true"}disabled{/if} class="btn btn-sm btn-default" style="display: visible;" id="dnsrecorddelete{$dnsrecord.id}" type="button" onClick="deleteRecord('{$dnsrecord.id}', '{$MLANG.btn_delete}', '{$MLANG.btn_cancel}')" value="{$MLANG.btn_delete}">
					</td>
				</tr>
				{/foreach}
			</form>
			<tr>
				<form method="post" action="{$smarty.server.PHP_SELF}?m=solutedns&amp;{$dns_product_type}={$localid}">
					<input type="hidden" name="sdns_remoteid" value="{$remoteid}" />
					<input type="hidden" name="sdns_action" value="create" />
					<td><input type="text" name="dnsrecordname[]" class="form-control" value="{if $send}{$send.name}{else}<domain>{/if}"/></td>
					<td><select name="dnsrecordtype[]" class="form-control">
						{foreach from=$dnstypes item=dnstype}
						<option {if $dnstype eq $send.type}selected{/if} value="{$dnstype}">{$dnstype}</option>
						{/foreach}
					</select></td>
					<td><input type="text" name="dnsrecordcontent[]" class="form-control" value="{$send.content}"/></td>
					<td><input type="text" name="dnsrecordprio[]" class="form-control" value="{$send.prio}"/>*</td>
					<td>{if $dispset.pre_ttl eq "true"}
						<select name="dnsrecordttl[]" class="form-control">
							<option value="60" {if $send.ttl eq "60"}selected=selected{/if}>1 minute</option>
							<option value="300" {if $send.ttl eq "300"}selected=selected{/if}>5 minutes</option>
							<option value="3600" {if $send.ttl eq "3600"}selected=selected{elseif $send.ttl}{else}selected=selected{/if}>1 hour</option>
							<option value="86400" {if $send.ttl eq "86400"}selected=selected{/if}>1 day</option>
						</select>
						{else}
						<input type="text" name="dnsrecordttl[]" class="form-control" value="{$send.ttl}"/>*
						{/if}</td>
						<td><input class="btn btn-sm btn-success" id="dnsrecordadd[]" type="submit" value="{$MLANG.btn_add}"></td>
					</form>
				</tr>
			</table>
		</div>
		<p><i class="fa fa-exclamation-circle"></i> {$MLANG.domaindnsmanagementinfo}</p>
		{if $dnssec}
		<hr>
		<h3>DNSsec Keys</h3>
		<div class="table-responsive">
			<table class="table">
				<tr>
					<th>Key tag</th>
					<th>Flag</th>
					<th>Algorithm</th>
					<th>Public Key</th>
					<th>Status</th>
				</tr>
				{foreach from=$dnssec item=dnssecrecord}
				<tr>
					<td>{$dnssecrecord.key_tag}</td>
					<td>{$dnssecrecord.flag}</td>
					<td>{$dnssecrecord.algorithm}</td>
					<td><textarea>{$dnssecrecord.public_key}</textarea></td>
					<td>
						{if $dnssecrecord.active eq '1'}
						<span class="label label-success">active</span>
						{else}
						<span class="label label-default">inactive</span>
						{/if}
					</td>
				</tr>
				{/foreach}
			</table>
		</div>
		{/if}
		{/if}
		<form method="post" action="{if $product_type eq 'lone'}index.php?m=solutedns{else}clientarea.php?action={$product_type}details{/if}">
  <input type="hidden" name="id" value="{$localid}" />
			<div class="pull-right"><input type="submit" value="{$LANG.clientareabacklink}" class="btn btn-default" /></div>
		</form>