<?php
	$project_name = "Jump & Learn";
	$base_url = 'http://' . $_SERVER['SERVER_NAME'] . substr($_SERVER['SCRIPT_NAME'], 0, strrpos($_SERVER['SCRIPT_NAME'], "/")+1);
	$profile_name = "DistributionGeneric_II.mobileprovision";
	$app_plist_name = "app.plist";
	$profile_url = $base_url . $profile_name;
	$app_plist_url = "itms-services://?action=download-manifest&url=" . $base_url . $app_plist_name;
?>

<!doctype html>
<html>
<head>
	<title><?php echo $project_name; ?></title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0;">
	<link rel="stylesheet" href="twitter-bootstrap/docs/assets/css/bootstrap.css">
	<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div class="header instructions-generic">
		<h3>Instruções</h3>
	</div>
	<div class="content row">
		<div class="content-right">
			<div class="download-box">
				<a href="<?php echo $profile_url; ?>" class="float-left button-link">
					<img src="image/icon_provisioning.png" alt="" >
					<p>Provisioning profile</p>
				</a>
				<a href="<?php echo $app_plist_url; ?>" class="float-left button-link button-download-app">
					<img src="image/icon_appstore.png" alt="" >
					<p>App download</p>
				</a>
				<div class="clear-float"></div>
			</div>
		</div>
	
		<div class="content-left">
			<h1>Instruções para instalar o aplicativo <?php echo $project_name; ?> no seu device.</h1>
			<h2>1. Baixe e autorize o Provisioning Profile</h2>
			<a href="<?php echo $profile_url; ?>" class="float-left button-link">
				<img src="image/icon_provisioning.png" alt="" >
			</a>
			<p>a.) Clique no botão ao lado para instalar o provisioning profile.</p>
			<p>b.) Clique ok na próxima janela para autorizar o profile. Depois, volte aqui para continuar com a instalação.</p>
			<br />

			<div class="clear-float"></div>
			<h2>2. Baixe o aplicativo</h2>
			<a href="<?php echo $app_plist_url; ?>" class="float-left button-link button-download-app">
				<img src="image/icon_appstore.png" alt="" >
			</a>
			<p>Clique no botão ao lado para instalar o app.</p>
			<br />
			<br />
		</div>

		<div class="clear-float"></div>
	</div>

</body>
</html>