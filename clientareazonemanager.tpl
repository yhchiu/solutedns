<script src="//cdn.datatables.net/plug-ins/a5734b29083/integration/bootstrap/3/dataTables.bootstrap.js"></script>
{include file="$template/pageheader.tpl" title=$MLANG.title}
<div id="dialog-import" title="{$MLANG.zone_import}" style="display: none;">
  <p class="sdns_dialog_desc">{$MLANG.zone_import_desc}</p>
  <span class="sdns_dialog_textarea_wrap">
  <textarea class="sdns_dialog_textarea_import" id="importcontent"></textarea>
  </span>
  <p class="sdns_dialog_desc">
    <input id="overwrite" type="checkbox" />
    <label for="overwrite" class="sdns_dialog_overwrite">{$MLANG.zone_import_overwrite}</label>
  </p>
</div>
<div id="dialog-export" title="{$MLANG.zone_export}" style="display: none;">
  <p class="sdns_dialog_desc">{$MLANG.zone_export_desc}</p>
  <span class="sdns_dialog_textarea_wrap">
  <textarea class="sdns_dialog_textarea_export" wrap="off" id="export">{$exportzone}</textarea>
  </span> </div>
<div id="dialog-deletezone" title="{$MLANG.zone_delete}" style="display: none;">
  <p class="sdns_dialog_desc">{$MLANG.zone_delete_desc}</p>
</div>
<div id="dialog-template" title="{$MLANG.apply_template}" style="display: none;">
  <p class="sdns_dialog_desc">{$MLANG.zone_template_desc}</p>
  <p class="sdns_dialog_desc" style="text-align: center"> {if $template_options}
    <select id="settemplate">
        {foreach from=$template_options key=templatekey item=templateoption}
      <option value="{$templatekey}">{$templateoption}</option>
        {/foreach}
    </select>
    {/if}</p>
</div>
<p>{$MLANG.zonemanagement_desc} <strong>{$limit}</strong> {$MLANG.zonemanagement_desc2}</p>
<br />
{if $status_msg}
<div {if $dnszones}id="msgbox" {/if}class="alert alert-{$status_msg.type}">
  <p><strong>{$status_msg.title}</strong></p>
  <p>{$status_msg.desc}</p>
</div>
{/if}
{if $dnszones}
  <div class="form-group">
  <form method="post" action="{$smarty.server.PHP_SELF}?m=solutedns">
    <div class="input-group">
    <input type="hidden" name="sdns_action" value="addzone" />
      <input type="text" name="domain" value="{if $send}{$send.domain}{else}{$MLANG.zonemanagement_addnewdesc}{/if}" class="form-control" onfocus="if(this.value=='{$LANG.searchenterdomain}')this.value=''" />
      <span class="input-group-btn">
       <button name="addzone" class="btn btn-success">{$MLANG.btn_add}</button>
      </span>
    </div><!-- /input-group -->       
    </form>
  </div>
<hr />
<div id="confirm-deletezone" class="alert alert-danger" style="display: none;">
  <p><strong>{$MLANG.zone_deleted_title}</strong></p>
  <p>{$MLANG.zone_deleted_desc}</p>
</div>
<div id="confirm-importzone" class="alert alert-alert" style="display: none;">
  <p><strong>{$MLANG.zone_imported_title}</strong></p>
  <p>{$MLANG.zone_imported_desc}</p>
</div>
<div id="confirm-template" class="alert alert-alert" style="display: none;">
  <p><strong>{$MLANG.template_applied_title}</strong></p>
  <p>{$MLANG.template_applied_desc}</p>
</div>
<div class="clear"></div>
{literal} 
<script>
jQuery(document).ready(function($){	
	table = $('#zonetable').dataTable( {

		"aoColumns": [
			{ "sWidth": "2%", "bSortable": false },
			{ "sWidth": "50%" },
			{ "sWidth": "18%" },
			{ "sWidth": "30%", "bSortable": false }
		],
		"bProcessing": true,
		"bServerSide": true,
		"sAjaxSource": "modules/addons/solutedns/data/client.zones.php",
		"bStateSave": true,
		
		"fnStateSaveParams": function (oSettings, oData) {
			//oData.oSearch.sSearch = "";
			//oData.iStart = 0;
		},
		"fnPreDrawCallback": function( oSettings ) {
			//NProgress.start();
		},
		"fnDrawCallback": function( oSettings ) {
		  //NProgress.done();
		},
		"oLanguage": {
			"oPaginate": {
				"sPrevious": "Previous",
				"sNext": "Next"
			},
			"sEmptyTable": "No data available in table",
			"sInfo": '{/literal}{$MLANG.zone_sInfo}{literal}',
			"sInfoEmpty": '{/literal}{$MLANG.zone_sInfoEmpty}{literal}',
			"sInfoFiltered": '{/literal}{$MLANG.zone_sInfoFiltered}{literal}',
			"sLengthMenu": '{/literal}{$MLANG.zone_sLengthMenu}{literal}',
			"sLoadingRecords": '{/literal}{$MLANG.zone_sLoadingRecords}{literal}',
			"sProcessing": '{/literal}{$MLANG.zone_sProcessing}{literal}',
			"sSearch": '{/literal}{$MLANG.zone_sSearch}{literal}',
			"sZeroRecords": '{/literal}{$MLANG.zone_sZeroRecords}{literal}'
		}
	
	} );
	
});
</script> 
{/literal}
<form method="post" id="bulkactionform" name="bulkaction" action="index.php?m=solutedns">
  <input id="bulkaction" name="bulkupdate" type="hidden" />
  <table class="display table table-striped table-framed" id="zonetable">
    <thead>
      <tr>
        <th><input type="checkbox" onclick="toggleCheckboxes('zoneids')" /></th>
        <th>{$LANG.clientareahostingdomain}</th>
        <th>{$LANG.clientareahostingregdate}</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td colspan="5" class="dataTables_empty"><center>
            Loading data from server...
          </center></td>
      </tr>
    </tbody>
  </table>
  <div class="btn-group"> <a class="btn btn-default" href="#" data-toggle="dropdown"><i class="icon-folder-open icon-white"></i> {$LANG.withselected}</a> <a class="btn btn-default dropdown-toggle" href="#" data-toggle="dropdown"><span class="caret"></span></a>
    <ul class="dropdown-menu">
      <!--<li><a href="#" id="template" class="setbulkaction"><i class="icon-edit"></i> {$MLANG.apply_template}</a></li>-->
      <li><a href="#" id="delete" class="setbulkaction"><i class="icon-remove"></i> {$MLANG.btn_remove}</a></li>
    </ul>
  </div>
</form>
{/if}
<div style="clear: both;"></div>