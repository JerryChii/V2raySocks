<?php
require(dirname(dirname(dirname(dirname(__FILE__)))).'/init.php');
use WHMCS\Database\Capsule;
if(isset($_GET['sid']) && isset($_GET['token'])){
	$sid = $_GET['sid'];
	$token = $_GET['token'];
	$service = \WHMCS\Database\Capsule::table('tblhosting')->where('id', $sid)->where('username', $token)->first();
	if (empty($service)){
		die('Unisset or Uncorrect Token');
	}
	if ($service->domainstatus != 'Active' ) {
        die('Not Active');
    }
	$package = Capsule::table('tblproducts')->where('id', $service->packageid)->first();
	$server = Capsule::table('tblservers')->where('id', $service->server)->first();

	$dbhost = $server->ipaddress ? $server->ipaddress : 'localhost';
	$dbname = $package->configoption1;
	$dbuser = $server->username;
	$dbpass = decrypt($server->password);
	$db = new PDO('mysql:host=' . $dbhost . ';dbname=' . $dbname, $dbuser, $dbpass);
	$usage = $db->prepare('SELECT * FROM `user` WHERE `sid` = :sid');
	$usage->bindValue(':sid', $sid);
	$usage->execute();
	$usage = $usage->fetch();
	$servers = $package->configoption4;
	$noder = explode("\n",$servers);
	$results = "";
	foreach($noder as $nodee){
		$nodee = explode('|', $nodee);
		$results .= make_vmess($nodee,$usage['uuid']) . PHP_EOL;
	}
	echo(str_replace('=','',base64_encode($results)));
}else{
	die('Invaild');
}

function make_vmess($nodee,$uuid){
    $atr1 = array(
        "add" => $nodee[1],
        "host"=> $nodee[5],
        "id"  => $uuid,
        "net" => $nodee[7],
        "path"=> $nodee[6],
        "port"=> $nodee[2],
        "ps"  => $nodee[0],
        "tls" => $nodee[4],
        "v"   => 2
    );
    if ($nodee[9]){
        $atr1['aid'] = intval($nodee[9]);
    }else{
        $atr1['aid'] = 64;
    }
    if($nodee[3]){
        $atr1['type'] = $nodee[3];
    }else{
        $atr1['type'] = "none";
    }
    return "vmess://".base64_encode(json_encode($atr1));  
}