<?php 
		header('Content-Type: text/xml; charset=utf-8');
		$cname=$_GET["symbol"];		
		$simage="http://chart.finance.yahoo.com/t?s=".$cname."&amp;lang=enUS&amp;width=300&amp;height=180";
		$cstock=rawurlencode("http://query.yahooapis.com/v1/public/yql?q=Select%20Name%2C%20Symbol%2C%20LastTradePriceOnly%2C%20Change%2C%20ChangeinPercent%2C%20PreviousClose%2C%20DaysLow%2C%20DaysHigh%2C%20Open%2C%20YearLow%2C%20YearHigh%2C%20Bid%2C%20Ask%2C%20AverageDailyVolume%2C%20OneyrTargetPrice%2C%20MarketCapitalization%2C%20Volume%2C%20Open%2C%20YearLow%20from%20yahoo.finance.quotes%20where%20symbol%3D%22".$cname."%22&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys");
		$cnews=rawurlencode("http://feeds.finance.yahoo.com/rss/2.0/headline?s=".$cname."&region=US&lang=en-US");
		$stock_data=simplexml_load_file($cstock);
		$news_data=simplexml_load_file($cnews);				
		
		//collecting info in variables---------
		$bid=$stock_data->results[0]->quote[0]->Bid;
		$bid=number_format((float)$bid,2, '.', ',');

		$change=$stock_data->results[0]->quote[0]->Change;
		$nochange=$stock_data->results[0]->quote[0]->Change; //for 0.00
		$sign=substr($change,0,1);
		if($sign=="+")
			$chr="+";
		else if ($sign=="-") {
			$chr="-";
		}
		else
			$chr="";
		//$change=number_format((float)substr($change,1),2, '.', ',');
		if($chr=="")
			$change=$stock_data->results[0]->quote[0]->Change;
		else
			$change=substr($stock_data->results[0]->quote[0]->Change,1);
		

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
		$name=str_replace("&","&amp;",$name);
		$name=str_replace("'","&apos;",$name);
		$name=str_replace("<","&lt;",$name);
		$name=str_replace(">","&gt;",$name);

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
		
		$sxml="<result>";	
		$sxml.="<Name>".$name."</Name>";			
		$sxml.="<Symbol>".$cname."</Symbol>";			
		$sxml.="<Quote>";			
		$sxml.="<ChangeType>".$chr."</ChangeType>";
		$sxml.="<Change>".$change."</Change>";
		$sxml.="<ChangeInPercent>".$changep."</ChangeInPercent>";
		$sxml.="<LastTradePriceOnly>".$ltprice."</LastTradePriceOnly>";
		$sxml.="<PreviousClose>".$pclose."</PreviousClose>";
		$sxml.="<DaysLow>".$dlow."</DaysLow>";
		$sxml.="<DaysHigh>".$dhigh."</DaysHigh>";
		$sxml.="<Open>".$open."</Open>";
		$sxml.="<YearLow>".$ylow."</YearLow>";
		$sxml.="<YearHigh>".$yhigh."</YearHigh>";
		$sxml.="<Bid>".$bid."</Bid>";
		$sxml.="<Volume>".$vol."</Volume>";
		$sxml.="<Ask>".$ask."</Ask>";
		$sxml.="<AverageDailyVolume>".$avgdv."</AverageDailyVolume>";
		$sxml.="<OneYearTargetPrice>".$oneytp."</OneYearTargetPrice>";
		$sxml.="<MarketCapitalization>".$mcap."</MarketCapitalization>";
		//$sxml.="</Quote></result>";	
		$sxml.="</Quote><News>";	
		foreach($news_data->channel[0]->item as $items)
					{
						//$new_title=new SimpleXMLElement($items->title);
						//$new_link=new SimpleXMLElement($items->link);						
						$new_title=$items->title;
						$new_link=$items->link;						
						$new_title=str_replace('<','&lt;',$new_title);
						$new_title=str_replace('>','&gt;',$new_title);
						$new_title=str_replace('&','&amp;',$new_title);						
						$new_title=str_replace("'",'&#39;',$new_title);//
						$new_title=str_replace('"','&quot;',$new_title);//
						$new_link=str_replace('<','&lt;',$new_link);
						$new_link=str_replace('>','&gt;',$new_link);
						$new_link=str_replace('&','&amp;',$new_link);
						$new_link=str_replace("'",'&apos;',$new_link);
						$new_link=str_replace('"','&quot;',$new_link);
						$sxml.="<Item><Title>".$new_title."</Title><Link>".$new_link."</Link></Item>";	
					}
		$sxml.="</News>";		
		$sxml.="<StockChartImageURL>".$simage."</StockChartImageURL></result>";
		echo $sxml;	
		
?>



