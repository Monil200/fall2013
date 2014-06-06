
<!DOCTYPE HTML>
<HTML>
<head>
	<style>
	.content
	{border:2px solid black;
	text-align:justify;
	height:50px;
	width:375px;
	padding:20px;
	}	
	hr.rule 
	{
    height: 6px;
    background-color:black;  
    width:100%;
	}
	div.result
	{margin-left:auto;
	margin-right:auto;
	width:60%;
	}
	</style>
	<script>
	function sanity()
	{var c=document.forms["stock"]["cname"].value;
	c=c.trim();	
	var regspace=/\s+/g
	if(c.length==0)
		{alert("Please enter a Company Symbol.");
		return false;
		}
	if(regspace.test(c))
		{alert("Please enter a valid Company Symbol without spaces");
		return false;
		}

	}
	</script>
</head>
<body>
<form name="stock" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>">
<center>
<h2>Market Stock Search</h2>
<div class="content">
Company Sybmol: <input type="text" name="cname"> <input type="submit" name="submit" id="submit" value="search" onclick="return sanity()"><br>
Example:<i>GOOG,MSFT,YHOO,FB,APPL...etc</i>
</center>
</div>

<?php if(isset($_POST["submit"]))
	{	
		$cname=$_POST["cname"];
		$cname=trim($cname);
		$cname=str_replace(" ","+",$cname);
		/*if(strlen($cname)==0)
			{	print "<script>"; 
				print "alert('Please enter a company Symbol')"; 
				print "</script>";
				die();
			}*/
		$cstock="http://query.yahooapis.com/v1/public/yql?q=Select%20Name%2C%20Symbol%2C%20LastTradePriceOnly%2C%20Change%2C%20ChangeinPercent%2C%20PreviousClose%2C%20DaysLow%2C%20DaysHigh%2C%20Open%2C%20YearLow%2C%20YearHigh%2C%20Bid%2C%20Ask%2C%20AverageDailyVolume%2C%20OneyrTargetPrice%2C%20MarketCapitalization%2C%20Volume%2C%20Open%2C%20YearLow%20from%20yahoo.finance.quotes%20where%20symbol%3D%22".$cname."%22&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";
		$cnews="http://feeds.finance.yahoo.com/rss/2.0/headline?s=".$cname."&region=US&lang=en-US";
		$stock_data=@simplexml_load_file($cstock);
		$news_data=@simplexml_load_file($cnews);
		echo "<div class='result'>";
		if(!$stock_data || !$news_data)
			{
				echo "<center><br><font size='5'><b>Unexpected Error..Try again Later.</b></font></cente";
				die();
			}
		
		//collecting info in variables---------
		$bid=$stock_data->results[0]->quote[0]->Bid;
		$bid=number_format((float)$bid,2, '.', ',');

		$change=$stock_data->results[0]->quote[0]->Change;
		$nochange=$stock_data->results[0]->quote[0]->Change; //for 0.00
		$sign=substr($change,0,1);
		$change=number_format((float)substr($change,1),2, '.', ',');
		

		$dlow=$stock_data->results[0]->quote[0]->DaysLow;
		$dlow=number_format((float)$dlow,2, '.', ',');

		$dhigh=$stock_data->results[0]->quote[0]->DaysHigh;
		$dhigh=number_format((float)$dhigh,2, '.', ',');

		$ylow=$stock_data->results[0]->quote[0]->YearLow;
		$ylow=number_format((float)$ylow,2, '.', ',');

		$yhigh=$stock_data->results[0]->quote[0]->YearHigh;
		$yhigh=number_format((float)$yhigh,2, '.', ',');

		$mcap=$stock_data->results[0]->quote[0]->MarketCapitalization;//not required
		$bill=substr($mcap,strlen($mcap)-1,strlen($mcap));
		$mcapnew=substr($mcap,0,strlen($mcap)-1);
		$mcapnew=number_format((float)$mcapnew,2, '.', ',');
		$mcap=$mcapnew.$bill;

		$ltprice=$stock_data->results[0]->quote[0]->LastTradePriceOnly;
		$ltprice=number_format((float)$ltprice,2, '.', ',');

		$name=$stock_data->results[0]->quote[0]->Name;

		$open=$stock_data->results[0]->quote[0]->Open;
		$open=number_format((float)$open,2, '.', ',');

		$pclose=$stock_data->results[0]->quote[0]->PreviousClose;
		$pclose=number_format((float)$pclose,2, '.', ',');

		$changep=$stock_data->results[0]->quote[0]->ChangeinPercent;
		//$changep=number_format((float)$changep,2);//not sure..% not coming..

		$symbol=$stock_data->results[0]->quote[0]->Symbol;

		$oneytp=$stock_data->results[0]->quote[0]->OneyrTargetPrice;
		$oneytp=number_format((float)$oneytp,2, '.', ',');

		$vol=$stock_data->results[0]->quote[0]->Volume;
		$vol=number_format((float)$vol);//--diff

		$ask=$stock_data->results[0]->quote[0]->Ask;
		$ask=number_format((float)$ask,2, '.', ',');

		$avgdv=$stock_data->results[0]->quote[0]->AverageDailyVolume;
		$avgdv=number_format((float)$avgdv);//diff
		//var collection over..

		$imgn="http://www-scf.usc.edu/~csci571/2014Spring/hw6/down_r.gif";
		$imgp="http://www-scf.usc.edu/~csci571/2014Spring/hw6/up_g.gif";		
		
		$flag=TRUE;
		//if($bid==0.00 && $change==0.00 && $dlow==0.00 && $dhigh==0.00 && $ylow==0.00 && $yhigh==0.00 && $vol==0 && $avgdv==0 && $pclose==0.00 && $ltprice==0.00 && $oneytp==0.00 && $open==0.00 && $ask==0.00)
		if((string)$stock_data->results[0]->quote[0]->Change==="")
			{
				echo "<center><br><font size='5'><b>Stock Information Not Available</b></font></center>";				
				$flag=FALSE;
			}
		else
		{	echo "<center><br><font size='5'><b>Search Results</b></font></center><br>";
			if($sign=="-")// || ($sign!="-" && $sign!="+"))
				{
					echo "<font size='5'><b>".$name."(".$symbol.")</b></font>"."&nbsp;&nbsp;".$ltprice."&nbsp;&nbsp;<font color='red'><image src=".$imgn.">".substr($change,0)."(".substr($changep,1).")</font><br>";
				}
			else if($sign=="+")
				{
					echo "<font size='5'><b>".$name."(".$symbol.")</b></font>"."&nbsp;&nbsp;".$ltprice."&nbsp;&nbsp;<font color='green'><image src=".$imgp.">".substr($change,0)."(".substr($changep,1).")</font><br>";											
				}
			else
				{
					echo "<font size='5'><b>".$name."(".$symbol.")</b></font>"."&nbsp;&nbsp;".$ltprice."&nbsp;&nbsp;<font color='green'>".substr($nochange,0)."(".substr($changep,1).")</font><br>";										
				}
			echo "<hr class='rule'/>";
			//table creation-------------
			echo "<div class='fonts'>";			
			echo "<table width=100%>";
				echo "<tr>";
					echo "<td width='30%'> Prev Close:</td>";
					echo "<td width='10%'>".$pclose."</td>";
					echo "<td width='40%'> Days Range:</td>";
					echo "<td width='20%' align='right'>".$dlow." - ".$dhigh."</td>";
				echo "</tr>";
				echo "<tr>";
					echo "<td width='30%'> Open:</td>";
					echo "<td width='10%'>".$open."</td>";
					echo "<td width='40%'> 52wk Range:</td>";
					echo "<td width='20%' align='right'>".$ylow." - ".$yhigh."</td>";
				echo "</tr>";
				echo "<tr>";
					echo "<td width='30%'> Bid:</td>";
					echo "<td width='10%'>".$bid."</td>";
					echo "<td width='40%'> Volume:</td>";
					echo "<td width='20%' align='right'>".$vol."</td>";
				echo "</tr>";
				echo "<tr>";
					echo "<td width='30%'> Ask:</td>";
					echo "<td width='10%'>".$ask."</td>";
					echo "<td width='40%'> Avg Vol(3m):</td>";
					echo "<td width='20%' align='right'>".$avgdv."</td>";
				echo "</tr>";
				echo "<tr>";
					echo "<td width='30%'> 1y Target Est:</td>";
					echo "<td width='10%'>".$oneytp."</td>";
					echo "<td width='40%'> Market Cap:</td>";
					echo "<td width='20%' align='right'>".$mcap."</td>";
				echo "</tr>";
			echo "</table><br>";
			echo "</div>";
		}
			
		if($news_data->channel[0]->title=="Yahoo! Finance: RSS feed not found" && $flag==FALSE)
			{
				//do nothing;
				echo "<center><br><font size='5'><b>Financial Company News is not available</b></font></center>";
			}
		else 
			{echo "<font size='5'><b>News Headlines</b></font>";
			echo "<hr class='rule'>";
			if($news_data->channel[0]->title=="Yahoo! Finance: RSS feed not found" && $flag==TRUE)
				{					
					echo "<center><br><font size='5'><b>Financial Company News is not available</b></font></center>";
				}
			else
				{
				echo "<ul>";
				foreach($news_data->channel[0]->item as $items)
					{
						//echo "<li><a href='".$items->link."' target='_blank'>".$items->title."</a></li>";	
						echo "<li><a href='".$items->link."' target='_blank'>".htmlentities($items->title, ENT_QUOTES, 'UTF-8')."</a></li>";	
					}
				echo "</ul>";				
				}
			}				
		echo "</div>"; //res div
	}
?>


</body>
</HTML>



