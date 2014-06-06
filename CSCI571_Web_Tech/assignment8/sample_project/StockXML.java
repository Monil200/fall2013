import javax.servlet.*;
import javax.servlet.http.*;

import java.io.*;
import java.net.*;
import java.util.*;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;

import org.json.simple.JSONObject;
import org.json.simple.JSONArray;

//JDOM


public class StockXML extends HttpServlet {
    private static final String CONTENT_TYPE = "text/html";

    public void doGet(HttpServletRequest request, 
		      HttpServletResponse response) throws ServletException, 
		      IOException {
    	String u="http://default-environment-q5c8xqdcnr.elasticbeanstalk.com/?symbol=";
    	String sym=request.getParameter("symbol");
        //String sym="GOOGhas";
    	u+=sym;
    	URL		 url;
    	URLConnection    urlConn;
    	
    	// URL of target page script.
    	url = new URL(u);
    	urlConn = url.openConnection();
    	urlConn.setRequestProperty("Content-Type","text/xml");
    	urlConn.setAllowUserInteraction(false);	
    	BufferedReader in = new BufferedReader(new InputStreamReader(urlConn.getInputStream()));
    	
    	InputStream fXmlFile =url.openStream();
    	PrintWriter out=response.getWriter();
    	response.setContentType("text/html");//c1
    	try {
    		;
    		//out.print("<html><body>");
    		 
    		//File fXmlFile = new File("C:/Users/Miral/Desktop/ass8/temp.xml");
    		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
    		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
    		Document doc = dBuilder.parse(fXmlFile);
    	 
    		//optional, but recommended
    		//read this - http://stackoverflow.com/questions/13786607/normalization-in-dom-parsing-with-java-how-does-it-work
    		doc.getDocumentElement().normalize();
    		Element root=doc.getDocumentElement();
    		//out.print("Root element :" + doc.getDocumentElement().getNodeName());
    	 
    		NodeList nameN=root.getElementsByTagName("Name");
    		Node nameE=(Node)nameN.item(0);
    		String name=nameE.getFirstChild().getNodeValue();    		
    		
    		NodeList symbolN=root.getElementsByTagName("Symbol");
    		Node symbolE=(Node)symbolN.item(0);
    		String symbol=symbolE.getFirstChild().getNodeValue();
    		    		
    		NodeList imgN=root.getElementsByTagName("StockChartImageURL");
    		Node imgE=(Node)imgN.item(0);
    		String img=imgE.getFirstChild().getNodeValue();    	    		    		
    		
    		NodeList quote=root.getElementsByTagName("Quote");
    		
    		NodeList signN=quote.item(0).getChildNodes();
    		String sign="";
    		try
    			{Node signE=(Node)signN.item(0);    		    		
    			sign=signE.getFirstChild().getNodeValue();
    			}
    		catch(NullPointerException ne)
    			{
    			sign="";
    			}
    		
    		
    		NodeList changeN=quote.item(0).getChildNodes();
    		Node changeE=(Node)changeN.item(1);
    		String change=changeE.getFirstChild().getNodeValue();
    		
    		NodeList changepN=quote.item(0).getChildNodes();
    		String changep="";
    		try
    			{Node changepE=(Node)changepN.item(2);    		    	
    			changep=changepE.getFirstChild().getNodeValue();
    			}
    		catch(NullPointerException ne)
				{
    			changep="";
				}
    		
    		
    		
    		NodeList ltpriceN=quote.item(0).getChildNodes();
    		Node ltpriceE=(Node)ltpriceN.item(3);
    		String ltprice=ltpriceE.getFirstChild().getNodeValue();
    		
    		NodeList pcloseN=quote.item(0).getChildNodes();
    		Node pcloseE=(Node)pcloseN.item(4);
    		String pclose=pcloseE.getFirstChild().getNodeValue();
    		
    		NodeList dlowN=quote.item(0).getChildNodes();
    		Node dlowE=(Node)dlowN.item(5);
    		String dlow=dlowE.getFirstChild().getNodeValue();
    		
    		NodeList dhighN=quote.item(0).getChildNodes();
    		Node dhighE=(Node)dhighN.item(6);
    		String dhigh=dhighE.getFirstChild().getNodeValue();
    		
    		NodeList openN=quote.item(0).getChildNodes();
    		Node openE=(Node)openN.item(7);
    		String open=openE.getFirstChild().getNodeValue();
    		
    		NodeList ylowN=quote.item(0).getChildNodes();
    		Node ylowE=(Node)ylowN.item(8);
    		String ylow=ylowE.getFirstChild().getNodeValue();
    		
    		NodeList yhighN=quote.item(0).getChildNodes();
    		Node yhighE=(Node)yhighN.item(9);
    		String yhigh=yhighE.getFirstChild().getNodeValue();
    		
    		NodeList bidN=quote.item(0).getChildNodes();
    		Node bidE=(Node)bidN.item(10);
    		String bid=bidE.getFirstChild().getNodeValue();
    		
    		NodeList volN=quote.item(0).getChildNodes();
    		Node volE=(Node)volN.item(11);
    		String vol=volE.getFirstChild().getNodeValue();
    		
    		NodeList askN=quote.item(0).getChildNodes();
    		Node askE=(Node)askN.item(12);
    		String ask=askE.getFirstChild().getNodeValue();
    		
    		NodeList avgdvN=quote.item(0).getChildNodes();
    		Node avgdvE=(Node)avgdvN.item(13);
    		String avgdv=avgdvE.getFirstChild().getNodeValue();
    		
    		NodeList oneytpN=quote.item(0).getChildNodes();
    		Node oneytpE=(Node)oneytpN.item(14);
    		String oneytp=oneytpE.getFirstChild().getNodeValue();
    		
    		NodeList mcapN=quote.item(0).getChildNodes();
    		Node mcapE=(Node)mcapN.item(15);
    		String mcap=mcapE.getLastChild().getNodeValue();
    		//out.print("<br>"+mcap);
    		//String mcap="monil";
    		
    		    		
    		NodeList news=root.getElementsByTagName("News");    		
    		String title[]=new String[news.item(0).getChildNodes().getLength()];
    		String link[]=new String[news.item(0).getChildNodes().getLength()];    		
    		//out.println("<br>"+news.item(0).getChildNodes().getLength());
    		//out.println("<br>TEST-->"+news.item(0).getChildNodes().item(0).getChildNodes().item(0).getNodeValue());
    		//out.println("<br>TEST-->"+news.item(0).getChildNodes().item(0).getChildNodes().item(1).getNodeValue());
    		
    		for(int i=0;i<news.item(0).getChildNodes().getLength();i++)
    		{
    			title[i]=news.item(0).getChildNodes().item(i).getChildNodes().item(0).getFirstChild().getNodeValue();
    			//out.println("<br>"+title[i]+"title--->"+i);
    			try
    				{
    					link[i]=news.item(0).getChildNodes().item(i).getChildNodes().item(1).getFirstChild().getNodeValue();    				
    				}
    			catch(NullPointerException ne)
    	    		{
    	    			link[i]="";
    	    		}
    			//out.println("<br>"+link[i]+"link--->"+i);
    		}    	
    		//out.println("<br>"+name);
    		//out.println("<br>"+symbol);
    		//out.println("<br>"+img+"<br>");
    		
    		JSONObject parent=new JSONObject();
    		JSONObject child=new JSONObject();
    		JSONObject quotej=new JSONObject();
    		
    		
    		child.put("Name",name);
    		child.put("Symbol",symbol);    		
    		quotej.put("ChangeType",sign);
    		quotej.put("Change",change);
    		quotej.put("ChangeInPercent",changep);    		    	
    		quotej.put("LastTradePriceOnly",ltprice);    		
    		quotej.put("Open",open);
    		quotej.put("YearLow",ylow);    		
    		quotej.put("YearHigh",yhigh);    		
    		quotej.put("Volume",vol);    		
    		quotej.put("OneYearTargetPrice",oneytp);    		
    		quotej.put("Bid",bid);    		
    		quotej.put("DaysLow",dlow);    	    	
    		quotej.put("DaysHigh",dhigh);
    		quotej.put("Ask",ask);
    		quotej.put("AverageDailyVolume",avgdv);    		
    		quotej.put("PreviousClose",pclose);    		
    		quotej.put("MarketCapitalization",mcap);
    		child.put("Quote",quotej);
    		child.put("StockChartImageURL",img);    			
    		JSONObject newsj=new JSONObject();
    		JSONArray item=new JSONArray();    		 	
    		for(int i=0;i<news.item(0).getChildNodes().getLength();i++)
    		{JSONObject lt=new JSONObject();   
    		lt.put("Link",link[i]);
    		//out.print("<br>"+link[i]);
    		lt.put("Title",title[i]); 
    		item.add(lt); 		
    		}
    		//newsj.put("Item", item);
    		newsj.put("Item", item);
    		child.put("News", newsj);
    		parent.put("result",child);      		
    		 /*try
    	      {
    	      StringWriter o= new StringWriter();
    	      parent.writeJSONString(o);
    	      String jsonText = o.toString();
    	      out.println(jsonText);
    	      }
    	      catch(Exception e){}*/
    		String fJson=parent.toString();
    		out.println(fJson);
    		
    	    } catch (Exception e){ 
    		e.printStackTrace();
    	    }
    	//out.println();
    	
	}
	
	
	
	
    
    public void doPost(HttpServletRequest request, 
		      HttpServletResponse response) throws ServletException, 
		      IOException {
    
    }
}