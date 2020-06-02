<?php
require(dirname(dirname(dirname(dirname(__FILE__)))).'/init.php');
$key  = "\$a4-mugb_qjOamj_fkaiznjaq2\$fmoz";
$uckey = "oPajn1k2-jJanKn3k18bajdhaiYa_p";
$apiresults = array( "result" => "error", "message" => "Unknown Error" );
$input = false;
if($_GET['data']){
    $data = str_replace(" ", "+", $_GET['data']);
    $input = json_decode(V2RaySocks_API_ucAuthcode($data, "DECODE", $uckey),true);
}
if(is_array($input) && !empty($input) && V2RaySocks_API_checkInput($input)){
    $email = $input['email'];
    $password = $input['password'];
    $password = WHMCS\Input\Sanitize::decode($password);
    $authentication = new WHMCS\Authentication\Client($email, $password);
    if($authentication->verifyFirstFactor()){
        $user = $authentication->getUser();
        $apiresults = array( "result" => "success", "name" => $user->firstname, "email" => $user->email, "package" => array());
        $query = V2RaySocks_API_queryToArray(\WHMCS\Database\Capsule::table('tblhosting')->where('userid', $user->id)->get());
        $products = V2RaySocks_API_RebuildProductArray(V2RaySocks_API_queryToArray(\WHMCS\Database\Capsule::table('tblproducts')->where('servertype', 'V2raySocks')->get()));
        $servers = V2RaySocks_API_queryToArray(\WHMCS\Database\Capsule::table('tblservers')->where('type', 'V2raySocks')->get());
        if(!empty($query)){
            $serverid = array();
            foreach($servers as $ser){
                $mysql = new mysqli($ser['ipaddress'], $ser['username'], decrypt($ser['password']));
                $servername = 'mysqlserver'.$ser['id'];
                $$servername = $mysql;
                $serverid[$ser['id']] = array();
            }
            foreach ($query as $queryq) {
                if(isset($serverid[$queryq['server']]) && isset($products[$queryq['packageid']])){
                    $sid = $queryq['server'];
                    $mysql = 'mysqlserver'.$sid;
                    $sql = $$mysql;
                    $sql->select_db($products[$queryq['packageid']]['configoption1']);
                    $resultsql = "SELECT * FROM `user` where `sid` = ". $queryq['id'];
                    $result = mysqli_fetch_array($sql->query($resultsql),MYSQLI_ASSOC);
                    $node = explode("\n",$products[$queryq['packageid']]['configoption4']);
                    $apiresults['package'][] = array(
                        "package" => $products[$queryq['packageid']]['name'],
                        "uuid"    => $result['uuid'],
                        "usage"   => $result['u'] + $result['d'],
                        "traffic" => $result['transfer_enable'],
                        "nodes"   => $node
                    );
                }
            }
        }
    }else{
        $apiresults = array( "result" => "error", "message" => "Email or Password Invalid" );
    }
}else{
    $apiresults = array( "result" => "error", "message" => "Illegal Data" );
}
echo(V2RaySocks_API_LicenseEncodePart(V2RaySocks_API_ucAuthcode(json_encode($apiresults), 'ENCODE', $uckey), $key));

function V2RaySocks_API_RebuildProductArray($query){
    $products = array();
    foreach ($query as $product) {
        $products[$product['id']] = $product;
    }
    return $products;
}

function V2RaySocks_API_queryToArray($query){
    $products = array();
    foreach ($query as $product) {
        $producta = array();
        foreach($product as $k => $produc){
            $producta[$k] = $produc;
        }
        $products[] = $producta;
    }
    return $products;
}

function V2RaySocks_API_checkInput($input){
    if(isset($input['email']) && isset($input['password'])){
        return true;
    }
    return false;
}

function V2RaySocks_API_ucAuthcode($str, $operation = "DECODE", $key = "", $expiry = 0){
    $ckey_length = 4;
    $key = md5($key);
    $keya = md5(substr($key, 0, 16));
    $keyb = md5(substr($key, 16, 16));
    $keyc = ($ckey_length ? ($operation == "DECODE" ? substr($str, 0, $ckey_length) : substr(md5(microtime()), 0 - $ckey_length)) : "");
    $cryptkey = $keya . md5($keya . $keyc);
    $key_length = strlen($cryptkey);
    $str = ($operation == "DECODE" ? base64_decode(substr($str, $ckey_length)) : sprintf("%010d", ($expiry ? $expiry + time() : 0)) . substr(md5($str . $keyb), 0, 16) . $str);
    $str_length = strlen($str);
    $result = "";
    $box = range(0, 255);
    $rndkey = array(  );
    for( $i = 0; $i <= 255; $i++ ) 
    {
        $rndkey[$i] = ord($cryptkey[$i % $key_length]);
    }
    for( $j = $i = 0; $i < 256; $i++ ) 
    {
        $j = ($j + $box[$i] + $rndkey[$i]) % 256;
        $tmp = $box[$i];
        $box[$i] = $box[$j];
        $box[$j] = $tmp;
    }
    for( $a = $j = $i = 0; $i < $str_length; $i++ ) 
    {
        $a = ($a + 1) % 256;
        $j = ($j + $box[$a]) % 256;
        $tmp = $box[$a];
        $box[$a] = $box[$j];
        $box[$j] = $tmp;
        $result .= chr(ord($str[$i]) ^ $box[($box[$a] + $box[$j]) % 256]);
    }
    if( $operation == "DECODE" ) 
    {
        if( (substr($result, 0, 10) == 0 || 0 < substr($result, 0, 10) - time()) && substr($result, 10, 16) == substr(md5(substr($result, 26) . $keyb), 0, 16) ) 
        {
            return substr($result, 26);
        }

        return "";
    }

    return $keyc . str_replace("=", "", base64_encode($result));
}

function V2RaySocks_API_licenseDecodePart($string, $key){
    $key = sha1($key);
    $strLen = strlen($string);
    $keyLen = strlen($key);
    $i = 0;
    while( $i < $strLen ) 
    {
        $ordStr = hexdec(base_convert(strrev(substr($string, $i, 2)), 36, 16));
        if( $j == $keyLen ) 
        {
            $j = 0;
        }

        $ordKey = ord(substr($key, $j, 1));
        $j++;
        $hash .= chr($ordStr - $ordKey);
        $i += 2;
    }
    return $hash;
}

function V2RaySocks_API_LicenseEncodePart($string, $key){
    $key = sha1($key);
    $strLen = strlen($string);
    $keyLen = strlen($key);
    $i = 0;
    $j = 0;
    $hash = '';
    while( $i < $strLen ) 
    {
        $ordStr = ord(substr($string, $i, 1));

        if( $j == $keyLen ) 
        {
            $j = 0;
        }

        $ordKey = ord(substr($key, $j, 1));
        $j++;

        $hash .= strrev(base_convert(dechex($ordStr + $ordKey), 16, 36));

        $i += 1;
    }
    return $hash;
}