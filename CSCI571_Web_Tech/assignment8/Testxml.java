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


public class Testxml extends HttpServlet {
    private static final String CONTENT_TYPE = "text/html";

    public void doGet(HttpServletRequest request, 
		      HttpServletResponse response) throws ServletException, 
		      IOException {
    	String u="http://default-environment-q5c8xqdcnr.elasticbeanstalk.com/?symbol=";
    	String sym=request.getParameter("cname");
        //String sym="GOOG";
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
    	try {
    		response.setContentType("text/json");
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
    	 
    		String name=root.getElementsByTagName("Name").item(0).getTextContent();    		
    		String symbol=root.getElementsByTagName("Symbol").item(0).getTextContent();
    		String img=root.getElementsByTagName("StockChartImageURL").item(0).getTextContent();
    		
    		NodeList quote=root.getElementsByTagName("Quote");
    		String sign=quote.item(0).getChildNodes().item(0).getTextContent();    		
    		String change=quote.item(0).getChildNodes().item(1).getTextContent();
    		String changep=quote.item(0).getChildNodes().item(2).getTextContent();
    		String ltprice=quote.item(0).getChildNodes().item(3).getTextContent();
    		String pclose=quote.item(0).getChildNodes().item(4).getTextContent();
    		String dlow=quote.item(0).getChildNodes().item(5).getTextContent();
    		String dhigh=quote.item(0).getChildNodes().item(6).getTextContent();
    		String open=quote.item(0).getChildNodes().item(7).getTextContent();
    		String ylow=quote.item(0).getChildNodes().item(8).getTextContent();
    		String yhigh=quote.item(0).getChildNodes().item(9).getTextContent();
    		String bid=quote.item(0).getChildNodes().item(10).getTextContent();
    		String vol=quote.item(0).getChildNodes().item(11).getTextContent();
    		String ask=quote.item(0).getChildNodes().item(12).getTextContent();
    		String avgdv=quote.item(0).getChildNodes().item(13).getTextContent();
    		String oneytp=quote.item(0).getChildNodes().item(14).getTextContent();
    		String mcap=quote.item(0).getChildNodes().item(15).getTextContent();
    		    		
    		NodeList news=root.getElementsByTagName("News");    		
    		String title[]=new String[news.item(0).getChildNodes().getLength()];
    		String link[]=new String[news.item(0).getChildNodes().getLength()];
    		//out.println("<br>"+news.getLength());
    		//out.println("<br>"+news.item(0).getChildNodes().getLength());
    		//out.println("<br>"+news.item(0).getChildNodes().item(0).getChildNodes().item(0).getTextContent());
    		//out.println("<br>"+news.item(0).getChildNodes().item(0).getChildNodes().item(1).getTextContent());
    		
    		for(int i=0;i<news.item(0).getChildNodes().getLength();i++)
    		{
    			title[i]=news.item(0).getChildNodes().item(i).getChildNodes().item(0).getTextContent();
    			//out.println("<br>"+title[i]+"title--->"+i);
    			link[i]=news.item(0).getChildNodes().item(i).getChildNodes().item(1).getTextContent();
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
    		 try
    	      {
    	      StringWriter o= new StringWriter();
    	      parent.writeJSONString(o);
    	      String jsonText = o.toString();
    	      out.println(jsonText);
    	      }
    	      catch(Exception e){}
    		
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