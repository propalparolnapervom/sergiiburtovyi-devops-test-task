<?php echo file_get_contents("header.html"); ?>
<?php
$host = "${DB_HOST}";
$user = "${DB_USER_NAME}";
$password = "${DB_USER_PWD}";
$database = "${DB_NAME}";
$table = "${DB_TABLE_NAME}";

try {
  $db = new PDO("mysql:host=$host;dbname=$database", $user, $password);
  echo "<h2>The list of messages you have already submitted to the DB via <a href=\"insert_into_db_table.html\">DB demo: Insert data</a> page</h2><ol>";
  foreach($db->query("SELECT id, message FROM $table ORDER BY 1 ASC") as $row) {
    echo "<li>" . $row['message'] . "</li>";
  }
  echo "</ol>";
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}
?>
<?php echo file_get_contents("footer.html"); ?>