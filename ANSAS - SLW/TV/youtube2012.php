<?php
set_time_limit(0);
// get url from ?url= parameter
$v=$_GET["v"];
//$v="_7q0skpXPIs" ;
$search="".$_GET["search"];

$WORD="[A-Za-z0-9_=-]*";


if($search!="")
{
    require_once 'Zend/Gdata/YouTube.php';
    header ('Content-type: text/html; charset=utf-8');
    $yt = new Zend_Gdata_YouTube();
    $url="http://gdata.youtube.com/feeds/api/videos?q=$search&max-results=12&v=2";

    $videoFeed = $yt->getVideoFeed($url);
    foreach ($videoFeed as $videoEntry) {
    
      // echo "---------VIDEO----------<br>";
      echo $videoEntry->getVideoId()."|";
      echo $videoEntry->getVideoTitle() . "\n";
      //echo "\nDescription:<br>";
      
      //echo $videoEntry->getVideoDescription();
      //echo "<br><hr>";
    }
    
    die();
    
//    &start-index=11

}
//-$token = urldecode(file_get_contents("http://youtube.com/watch?v=$v&fmt=18",NULL));
// define what a "word" is for us

// get token value  from content scanning "t": "<token>"
//echo "$token";
//-preg_match_all("/ \"t\"\: \"($WORD)/",$token,$matches);
//-$token=urldecode($matches[1][0]);
// ask youtube video in mp4 format
//-$mp4file="http://www.youtube.com/get_video?fmt=18&video_id=$v&t=$token";
//-$file=fopen($mp4file,"rb") or die("Errore");
// send the right headers
//header("Content-Type: video/mp4");
//-fpassthru($file);

?>
<html>
<object><embed src="http://www.youtube.com/v/<?php echo $v ?>&autoplay=1&amp;hl=it_IT&amp;fs=0" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="1024" height="1024"></embed></object>
</html>
