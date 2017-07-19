{*<!--
/*********************************************************************************
** The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
*
 ********************************************************************************/
-->*}
{strip}
<!DOCTYPE html>
<html>
	<body bgcolor="#FFFFFF" text="#000000" background="http://crm2u.com.br/poc/layouts/vlayout/skins/images/proseguo_puestadelsoltenerife.jpg">
	<head>
		<title>Vtiger login page</title>
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
		<meta name="apple-touch-fullscreen" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
		<!-- for Login page we are added -->
		<link href="libraries/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="libraries/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
		<script src="libraries/jquery/jquery.min.js"></script>
		<script src="libraries/jquery/boxslider/jqueryBxslider.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	</head>
	<body id="myclogin">
<style>
	#page{
		margin-left: 0px !important;
	}
	body{
		padding-left: 0px;
		padding-right: 0px;
	}
#myclogin { background: url(http://crm2u.com.br/poc/layouts/vlayout/skins/images/proseguo_puestadelsoltenerife.jpg);    background-size: cover; }
.myclogincontainer{ margin-left: auto; margin-right: auto;  margin-bottom: 20px;margin-top: 20px;}
.controls .login-icon {
  width: 16px;
  margin-right: 5px;
  color: #fff;
    margin-top: -11px;
  border-radius: 4px;
  text-shadow: none!important;
  padding: 3px 6px;
}
.login-box{    width: auto!important;
    height:420px!important;    background: rgba(0,0,0,0.6)!important;    border: none;
    box-shadow: none;
}
.btn-mazzy {
background-color: #039be5!important;background-image:none!important;
  border-color: #028bce!important;
  color: #ffffff!important; padding: 4px 6px;
  font-size: 14px;
  line-height: 1.5;
  border-radius: 3px!important;text-shadow: none!important;}
.btn-mazzy:hover {
background-color: #028bce!important;
  border-color: #028bce!important;
  color: #ffffff!important; padding: 4px 6px;
  font-size: 14px;
  line-height: 1.5;
  border-radius: 3px!important;text-shadow: none!important;}

input[type="text"], input[type="password"] {
   outline: none!important; position: relative!important;
    width: 100%!important;
    background: 0 0!important;
    padding: 8px 0px 8px 4px!important;
    font-size: 16px!important;
    line-height: 1.4!important;
    font-weight: 500!important;
    border: none !important;
    border-bottom: 1px solid #ffffff !important;
    box-shadow: none!important;
    color: #ffffff !important;
    z-index: 1!important;
height:20px!important;
transition:inherit!important;border-radius:0px!important;}
input[type="text"]:focus, input[type="password"]:focus {    border-bottom: 1px solid #039BE5 !important;}

</style>
			<div class="row-fluid">
				<div class="span12">
					<div class="content-wrapper"  style="min-width:100%;">
						<div class="container-fluid">
							<div class="row">
					<div class="span4">&nbsp;</div>
								<div class="span4 myclogincontainer" style="text-align: center;">
									<div class="login-area"  style="margin: 20% 0%; float: none;">
										<div class="login-box" id="loginDiv">
											<div class="">
				<img style="margin: 20px 0 30px;" src="layouts/vlayout/skins/images/logo.png">
				<a target="_blank" href="http://{$COMPANY_DETAILSCOMPANY_DETAILS.website}">{$COMPANY_DETAILS.name}</a>
		</div>
											<form class="login-form" style="padding:20px; margin:0;" action="index.php?module=Users&action=Login" method="POST">
			{if isset($smarty.request.error)}
			<div class="alert alert-error">
				<p>Invalid username or password.</p>
			</div>
			{/if}
												{if isset($smarty.request.fpError)}
													<div class="alert alert-error">
														<p>Invalid Username or Email address.</p>
													</div>
												{/if}
												{if isset($smarty.request.status)}
													<div class="alert alert-success">
														<p>Mail was send to your inbox, please check your e-mail.</p>
													</div>
												{/if}
												{if isset($smarty.request.statusError)}
													<div class="alert alert-error">
														<p>Outgoing mail server was not configured.</p>
													</div>
												{/if}



												<div class="control-group">
													<div class="controls">
														
														<input autocomplete="off" type="text" id="username" name="username" placeholder="Username ">
													</div>
												</div>



											<div class="control-group">
													<div class="controls">
														<input type="password" id="password" name="password" placeholder="Password">
													</div>
												</div>


												<div class="control-group signin-button">
													<div class="controls" id="forgotPassword">
														<button type="submit" class="btn btn-large btn-mazzy sbutton">Login</button>
														&nbsp;&nbsp;&nbsp;<a style="color:#fff;">Esqueceu a senha?</a>
													</div>
												</div>
												{* Retain this tracker to help us get usage details *}
												<img style="opacity:0" src='//stats.vtiger.com/stats.php?uid={$APPUNIQUEKEY}&v={$CURRENT_VERSION}&type=U' alt='' title='' border=0 width='1px' height='1px'>
											</form>
											
				</div>
										
										<div class="login-box hide" id="forgotPasswordDiv">
											<form class="login-form" style="margin:0;" action="forgotPassword.php" method="POST">
												<div class="">
													<h3 class="login-header">Forgot Password</h3>
			</div>
			<div class="control-group">
													
				<div class="controls">
					<span class="btn btn-blue login-icon"> <i class="fa fa-user"></i> </span>
														<input type="text" id="user_name" name="user_name" onkeyup="return forceLower(this);" placeholder="Username">
				</div>
			</div>
												<div class="control-group">
													<div class="controls">
														<span class="btn btn-blue login-icon"> <i class="fa fa-envelope"></i> </span>
														<input type="text" id="emailId" name="emailId"  placeholder="Email">
													</div>
		</div>
												<div class="control-group signin-button">
													<div class="controls" id="backButton">
														<input type="submit" class="btn btn-success sbutton" value="Submit" name="retrievePassword">
														&nbsp;&nbsp;&nbsp;<a>Back</a>
		</div>
	</div>
</form>
										</div>
										
									</div>
								</div>
								<div class="span4">&nbsp;</div>
							</div>

					

						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="navbar navbar-inverse" style="min-width:100%; margin:0px;  position:fixed; bottom:0px;">
			<div class="navbar-inner">
				<div class="container-fluid">
					<div class="row-fluid">
						<div class="span12" >
							<div class="footer-content" style="text-align:center;">

							</div>
						</div>
						
					</div>   
				</div>    
			</div>   
		</div>
	</body>
	<script>

                function forceLower(strInput) 
                {
                  strInput.value=strInput.value.toLowerCase();
                }​
		jQuery(document).ready(function(){
			jQuery("#forgotPassword a").click(function() {
				jQuery("#loginDiv").hide();
				jQuery("#forgotPasswordDiv").show();
			});
			
			jQuery("#backButton a").click(function() {
				jQuery("#loginDiv").show();
				jQuery("#forgotPasswordDiv").hide();
			});
			
			jQuery("input[name='retrievePassword']").click(function (){
				var username = jQuery('#user_name').val();
				var email = jQuery('#emailId').val();
				
				var email1 = email.replace(/^\s+/,'').replace(/\s+$/,'');
				var emailFilter = /^[^@]+@[^@.]+\.[^@]*\w\w$/ ;
				var illegalChars= /[\(\)\<\>\,\;\:\\\"\[\]]/ ;
				
				if(username == ''){
					alert('Please enter valid username');
					return false;
				} else if(!emailFilter.test(email1) || email == ''){
					alert('Please enater valid email address');
					return false;
				} else if(email.match(illegalChars)){
					alert( "The email address contains illegal characters.");
					return false;
				} else {
					return true;
				}
				
			});
		});
	</script>
</html>	
{/strip}
