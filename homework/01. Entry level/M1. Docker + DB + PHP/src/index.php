<html lang="en">
  <head>
    <title>Music Styles Downloads</title>
    <link rel="stylesheet" href="style.css" type="text/css" />
  </head>
  <body>
    <h1>ASKO MDownloads</h1>
    <table>
      <tr>
        <th>musicstyle</th>
        <th>trackname</th> 
        <th>downloads</th>
      </tr>
      <?php
        $mysqli = new mysqli("asko_database", "root", "admin", "music");
        $result = $mysqli->query("SELECT * FROM MusicDownloadsTable"); 
        foreach ($result as $row) {
      echo
      "<tr>
        <td>{$row['musicstyle']}</td>
        <td>{$row['trackname']}</td>
        <td>{$row['downloads']}</td>
      </tr>";
       } 
       ?>
    </table>
    <?php
      phpinfo();
    ?>
  </body>
</html>
