<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Gatagrind1.aspx.cs" Inherits="Jqueryeasyui3.Gatagrind1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" type="text/css" href="Styles/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="Styles/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="Styles/demo.css">
	<style type="text/css">
		#fm{
			margin:0;
			padding:10px 30px;
		}
		.ftitle{
			font-size:14px;
			font-weight:bold;
			color:#666;
			padding:5px 0;
			margin-bottom:10px;
			border-bottom:1px solid #ccc;
		}
		.fitem{
			margin-bottom:5px;
		}
		.fitem label{
			display:inline-block;
			width:80px;
		}
	</style>
	<script type="text/javascript" src="Scripts/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="Scripts/jquery.easyui.min.js"></script>
    <script type="text/javascript">
       $(document).ready(function(){
            $.ajax({
                   type: 'POST',
                   url: 'GetData.ashx',
                   contentType: 'application/json; charset=utf-8',
                   dataType: 'json',
                   success: function (json) {
                             $("#dg").datagrid("loadData",json);
                         }
                });
            });           
    </script>
	<script type="text/javascript">
	    var url;
	    function newUser() {
	        $('#dlg').dialog('open').dialog('setTitle', 'New User');
	        $('#fm').form('clear');
	        url = 'save_user.ashx';
	    }
	    function editUser() {
	        var row = $('#dg').datagrid('getSelected');
	        if (row) {
	            $('#dlg').dialog('open').dialog('setTitle', 'Edit User');
	            $('#fm').form('load', row);
	            url = 'update_user.ashx?id=' + row.id;
	        }
	    }
	    function saveUser() {
	        $('#fm').form('submit', {
	            url: url,
	            onSubmit: function () {
	                return $(this).form('validate');
	            },
	            success: function (result) {
	                var result = eval('(' + result + ')');
	               
	                if (result.success) {
	                    $('#dlg').dialog('close'); 	// close the dialog
	                    $('#dg').datagrid('reload'); // reload the user data
	                } else {
	                    $.messager.show({
	                        title: 'Error',
	                        msg: result.msg
	                    });
	                }
	            }
	        });
	    }
	    function removeUser() {
	        var row = $('#dg').datagrid('getSelected');
	        if (row) {
	            $.messager.confirm('Confirm', 'Are you sure you want to remove this user?', function (r) {
	                if (r) {
	                    $.post('remove_user.ashx', { id: row.id }, function (result) {
	                       if (result.success) {
	                            $('#dg').datagrid('reload'); // reload the user data
	                        } else {
	                            $.messager.show({	// show error message
	                                title: 'Error',
	                                msg: result.msg
	                            });
	                        }
	                    }, 'json');
	                }
	            });
	        }
	    }
	</script>
</head>
<body>
    <h2>Basic CRUD Application</h2>
	<div class="demo-info" style="margin-bottom:10px">
		<div class="demo-tip icon-tip">&nbsp;</div>
		<div>Click the buttons on datagrid toolbar to do crud actions.</div>
	</div>
	
	<table id="dg" title="My Users" class="easyui-datagrid" style="width:700px;height:250px"
			url="GetData.ashx"
			toolbar="#toolbar" pagination="true"
			rownumbers="true" fitColumns="true" singleSelect="true">
		<thead>
			<tr>
				<th field="firstname" width="50">First Name</th>
				<th field="lastname" width="50">Last Name</th>
				<th field="phone" width="50">Phone</th>
				<th field="email" width="50">Email</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">New User</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">Edit User</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeUser()">Remove User</a>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<div class="ftitle">User Information</div>
		<form id="fm" method="post" novalidate>
			<div class="fitem">
				<label>First Name:</label>
				<input name="firstname" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>Last Name:</label>
				<input name="lastname" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>Phone:</label>
				<input name="phone">
			</div>
			<div class="fitem">
				<label>Email:</label>
				<input name="email" class="easyui-validatebox" required="true">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">Save</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>
	</div>

</body>
</html>
