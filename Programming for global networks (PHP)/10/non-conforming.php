<?php 
// if the request comes from a file that contains the string "conforming.php" then render the page
	if(stristr($_SERVER['HTTP_REFERER'], "conforming.php")) {
session_start();

$str="";
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>Non-Conforming Content</title>
	</head>
	<body>


		<h1>This is a non-conforming page</h1>
		<p>Because you came from <?php echo $_SERVER['HTTP_REFERER']; 
//$str= $_SERVER['HTTP_REFERER'];
$GLOBALS['str']=$_SERVER['HTTP_REFERER'];
echo $str;

 ?>, you are 
			able to view the content on this page. </p>
	</body>

<?php $myVariable = $str;?>
<form method="post" action="last.php">
 <input type="hidden" name="text" value="<?php echo $myVariable; ?>">
 <button type="submit">Submit</button>
</form>
</html>
<?php
}
// if the referring page is not conforming.php, then redirect the user to the conforming version
else  {
header("Location: conforming.php");
}
?>	