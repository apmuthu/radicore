<?php

// this checks that person.last_addr_no = count(person_addr.person_id)

$link = mysqli_connect("localhost", "tony", "tony") or die("Could not connect to MySQL");

$result = mysqli_select_db($link, 'xample');
$result = mysqli_query($link, 'SELECT person_id,last_addr_no FROM x_person ORDER BY person_id');

while ($person_data = mysqli_fetch_assoc($result)) {
    $person_id = $person_data['person_id'];
    $result2 = mysqli_query($link, "SELECT count(*) FROM x_person_addr WHERE person_id='$person_id'");
    $count   = mysqli_fetch_row($result2);
    if ($count[0] != $person_data['last_addr_no']) {
        $query = "UPDATE x_person SET last_addr_no='$count[0]' WHERE person_id='$person_id'";
        echo $query ."<br>\n";
        $x = mysqli_query($link, $query);
    } // if
} // while

mysqli_close($link);

?>
