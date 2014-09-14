{include file="$template/pageheader.tpl" title=$MLANG.template_management}
<div id="dialog-confirm" title="{$MLANG.confirm_delete_title}" style="display: none;">
  <p style="margin-left:15px;">{$MLANG.confirm_delete_message}</p>
</div>
<p>{$MLANG.template_desc}</p>
<br />
{if $status_msg}
<div {if $templateid}id="msgbox" {/if}class="alert alert-{$status_msg.type}">
  <p><strong>{$status_msg.title}</strong></p>
  <p>{$status_msg.desc}</p>
</div>
{/if}

{if $delete_confirmation}
<div class="alert alert-{$delete_confirmation.type}">
  <div class="float-L">
    <p><strong>{$MLANG.confirm_delete_title}</strong></p>
    <p>{$MLANG.confirm_delete_message}</p>
  </div>
  <div class="float-R sdns_msg_option">
    <input class="btn btn-danger" id="delete" type="button" onClick="location.href='{$delete_confirmation.confirm}'" value="{$MLANG.btn_delete}">
    <input class="btn btn" id="cancel" type="button" onClick="location.href='{$delete_confirmation.cancel}'" value="{$MLANG.btn_cancel}">
  </div>
  <div style="clear: both;"></div>
</div>
{/if}

{if $templateid}
  <table class="table table-striped">
    <tr>
      <th {if $dns_orderby eq "name"} class="headerSort{$dns_sort}"{/if}><a href="{$smarty.server.PHP_SELF}?m=solutedns&amp;template&amp;name_{$dns_osort.name}">{$MLANG.name}</a></th>
      <th {if $dns_orderby eq "type"} class="headerSort{$dns_sort}"{/if}><a href="{$smarty.server.PHP_SELF}?m=solutedns&amp;template&amp;type_{$dns_osort.type}">{$MLANG.type}</a></th>
      <th {if $dns_orderby eq "content"} class="headerSort{$dns_sort}"{/if}><a href="{$smarty.server.PHP_SELF}?m=solutedns&amp;template&amp;content_{$dns_osort.content}">{$MLANG.content}</a></th>
      <th class="textleft">{$MLANG.prio}</th>
      <th class="textleft">{$MLANG.ttl}</th>
      <th></th>
    </tr>
    {if $dnsrecords}
    <form class="form-horizontal" method="post" action="{$smarty.server.PHP_SELF}?m=solutedns&amp;template">
      <input type="hidden" name="sdns_remoteid" value="{$remoteid}" />
      <input type="hidden" name="sdns_action" value="edit" />
      {foreach from=$dnsrecords item=dnsrecord}
      <tr id="row_{$dnsrecord.id}">
        <td><input type="hidden" id="dnsrecid{$dnsrecord.id}" name="dnsrecid[{$dnsrecord.id}]" value="{$dnsrecord.id}" />
          <input disabled type="text" id="dnsrecordname{$dnsrecord.id}" name="dnsrecordname[{$dnsrecord.id}]" value="{$dnsrecord.name}" size="10" class="input sdns_form_width" /></td>
        <td><select disabled id="dnsrecordtype{$dnsrecord.id}" name="dnsrecordtype[{$dnsrecord.id}]">
            
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
        <td><input disabled type="text" id="dnsrecordcontent{$dnsrecord.id}" name="dnsrecordcontent[{$dnsrecord.id}]" value="{$dnsrecord.content}" size="40" /></td>
        <td><input disabled type="text" id="dnsrecordprio{$dnsrecord.id}" name="dnsrecordprio[{$dnsrecord.id}]" value="{$dnsrecord.prio}" size="2" class="input-small" /></td>
        <td>{if $dispset.pre_ttl eq "true"}
          <select disabled id="dnsrecordttl{$dnsrecord.id}" name="dnsrecordttl[{$dnsrecord.id}]">
            <option value="60" {if $dnsrecord.ttl eq "60"}selected=selected{/if}>1 minute</option>
            <option value="300" {if $dnsrecord.ttl eq "300"}selected=selected{/if}>5 minutes</option>
            <option value="3600" {if $dnsrecord.ttl eq "3600"}selected=selected{/if}>1 hour</option>
            <option value="86400" {if $dnsrecord.ttl eq "86400"}selected=selected{/if}>1 day</option>
          </select>
          {else}
          <input disabled type="text" id="dnsrecordttl{$dnsrecord.id}" name="dnsrecordttl[{$dnsrecord.id}]" value="{$dnsrecord.ttl}" size="2" class="input-small" />
          {/if}</td>
        <td class="sdns_client_management"><input {if $dnsrecord.type eq "SOA"}disabled style="display: none;" {elseif $dnsrecord.type eq "NS" && $dispset.disable_ns eq "true"}disabled style="display: none;"{/if} class="btn btn-primary" style="display: visible;" id="dnsrecordedit{$dnsrecord.id}" onClick="edit('{$dnsrecord.id}')" type="button" value="{$MLANG.btn_edit}">
          <input class="btn btn-warning" style="display: none;" id="dnsrecordsave{$dnsrecord.id}" name="dnsrecordedit[{$dnsrecord.id}]" type="submit" value="{$MLANG.btn_save}">
          <input {if $dnsrecord.type eq "SOA"}disabled{elseif $dnsrecord.type eq "NS" && $dispset.disable_ns eq "true"}disabled{/if} class="btn" style="display: visible;" id="dnsrecorddelete{$dnsrecord.id}" type="button" onClick="deleteRecord('{$dnsrecord.id}', '{$MLANG.btn_delete}', '{$MLANG.btn_cancel}')" value="{$MLANG.btn_delete}"></td>
      </tr>
      {/foreach}
    </form>
    {/if}
    <tr>
      <form class="form-horizontal"  method="post" action="{$smarty.server.PHP_SELF}?m=solutedns&template">
        <input type="hidden" name="sdns_remoteid" value="{$remoteid}" />
        <input type="hidden" name="sdns_action" value="create" />
        <td><input type="text" name="dnsrecordname[]" size="10" class="input sdns_form_width" value="{if $send}{$send.name}{else}<domain>{/if}"/></td>
        <td><select name="dnsrecordtype[]">
            
		{foreach from=$dnstypes item=dnstype}
            <option {if $dnstype eq $send.type}selected{/if} value="{$dnstype}">{$dnstype}</option>
		{/foreach}
		
          </select></td>
        <td><input type="text" name="dnsrecordcontent[]" size="40" value="{$send.content}"/></td>
        <td><input type="text" name="dnsrecordprio[]" size="2" class="input-small" value="{$send.prio}"/>
          *</td>
        <td>{if $dispset.pre_ttl eq "true"}
          <select name="dnsrecordttl[]">
            <option value="60" {if $send.ttl eq "60"}selected=selected{/if}>1 minute</option>
            <option value="300" {if $send.ttl eq "300"}selected=selected{/if}>5 minutes</option>
            <option value="3600" {if $send.ttl eq "3600"}selected=selected{elseif $send.ttl}{else}selected=selected{/if}>1 hour</option>
            <option value="86400" {if $send.ttl eq "86400"}selected=selected{/if}>1 day</option>
          </select>
          {else}
          <input type="text" name="dnsrecordttl[]" size="2" class="input-small" value="{$send.ttl}"/>
          *
          {/if}</td>
        <td><input class="btn btn-success" id="dnsrecordadd[]" type="submit" value="{$MLANG.btn_add}"></td>
      </form>
    </tr>
  </table>

<p align="center">* {$MLANG.domaindnsmanagementinfo}</p>
<br />
{else}
<form method="post" action="{$smarty.server.PHP_SELF}?m=solutedns&amp;template">
  <center>
    <input name="activate" class="btn-success" type="submit" style="font-size:20px;padding:12px 30px ;" value="{$MLANG.activate_template}">
    </input>
  </center>
</form>
{/if}
<div style="clear: both;"></div>
<form method="post" action="index.php?m=solutedns">
  <input type="hidden" name="id" value="{$localid}" />
  <p>
    <input type="submit" value="{$LANG.clientareabacklink}" class="btn" />
  </p>
</form>