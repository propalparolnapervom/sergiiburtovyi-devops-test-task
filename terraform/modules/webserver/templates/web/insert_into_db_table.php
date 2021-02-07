<?php echo file_get_contents("header.html"); ?>
<?php
$host = "${DB_HOST}";
$db_name = "${DB_NAME}";
$db_table = "${DB_TABLE_NAME}";
$username = "${DB_USER_NAME}";
$password = "${DB_USER_PWD}";
$connection = null;
try{
$connection = new PDO("mysql:host=" . $host . ";dbname=" . $db_name, $username, $password);
$connection->exec("set names utf8");
}catch(PDOException $exception){
echo "Connection error: " . $exception->getMessage();
}

function saveData($message){
global $connection;
$query = "INSERT INTO ${DB_TABLE_NAME} (message) VALUES(:message)";

$callToDb = $connection->prepare( $query );
$message=htmlspecialchars(strip_tags($message));
$callToDb->bindParam(":message",$message);

if($callToDb->execute()){
return '<h4 style="text-align:center;">Thnx for inserting data to the DB via our WebServer from the DevOps Test Task!</h4><h4 style="text-align:center;">You can now use <a href="select_from_db_table.php">DB demo: Select data</a> page to view it.</h4>';
}
}

if( isset($_POST['submit'])){
$message = htmlentities($_POST['message']);

$result = saveData($message);
echo $result;
}
else{
echo '<h4 style="text-align:center;">A very detailed error message ...</h4>';
}
?>
<?php echo file_get_contents("footer.html"); ?>