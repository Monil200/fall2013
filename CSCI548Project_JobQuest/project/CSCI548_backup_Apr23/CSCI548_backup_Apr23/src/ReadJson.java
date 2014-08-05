

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.Console;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.ArrayList;
import java.util.Locale;
import java.util.Set;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.sun.xml.internal.bind.v2.schemagen.xmlschema.List;


public class ReadJson extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static boolean firstResultPage = true;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		JSONParser parser = new JSONParser();
		PrintWriter out=response.getWriter();
		response.setContentType("text/json");
		//out.print("<html><body>");	
		String type=request.getParameter("type");
		String searchPlace=request.getParameter("searchPlace");
		searchPlace = State.valueOfName(searchPlace).getAbbreviation();
		 
		try {	 
			Object obj = parser.parse(new FileReader("C:\\USC\\CSCI-548\\Project\\workspace\\CSCI548\\json\\diceall.json")); //job
			JSONObject jsonObject = (JSONObject) obj;	 //						 			
			obj = parser.parse(new FileReader("C:\\USC\\CSCI-548\\Project\\workspace\\CSCI548\\json\\company.json"));
			JSONObject jsonc=(JSONObject) obj;//companies
			obj=parser.parse(new FileReader("C:\\USC\\CSCI-548\\Project\\workspace\\CSCI548\\json\\"+type+".json"));
			JSONObject jsong=(JSONObject) obj;//glassdoor
			obj=parser.parse(new FileReader("C:\\USC\\CSCI-548\\Project\\workspace\\CSCI548\\json\\monster.json"));
			JSONObject jsonm=(JSONObject) obj;//monster
			
			//compnay data collection..
			JSONObject cresult=(JSONObject) jsonc.get("results");
			JSONArray ccollection=(JSONArray)cresult.get("collection1");
			int ccount=0;
			LinkedHashMap<String,Integer> cnamehm=new LinkedHashMap<String,Integer>();			
			
			ArrayList<String> chref=new ArrayList<String>();
			ArrayList<String> csalary=new ArrayList<String>();
			ArrayList<String> creview=new ArrayList<String>();
			ArrayList<String> cint=new ArrayList<String>();						
			ArrayList<String> curl=new ArrayList<String>();
			ArrayList<String> chq=new ArrayList<String>();
			ArrayList<String> crating=new ArrayList<String>();
			ArrayList<String> cstock=new ArrayList<String>();
			ArrayList<String> ceo_name=new ArrayList<String>();
			ArrayList<String> ceo_rating=new ArrayList<String>();
			ArrayList<String> csatisfaction=new ArrayList<String>();
			for(int i=0;i<ccollection.size();i++)
				{JSONObject element=(JSONObject)ccollection.get(i);//all comp data for 1 element
				JSONObject esalary=(JSONObject)element.get("csalary");
				JSONObject ereview=(JSONObject)element.get("creviews");
				JSONObject eint=(JSONObject)element.get("cinterviews");
				JSONObject ecname=(JSONObject)element.get("cname");
				//================================================				
				if(cnamehm.get((String)ecname.get("text"))==null)
					{cnamehm.put((String)ecname.get("text"),ccount++);				
					chref.add((String)ecname.get("href"));
					csalary.add((String)esalary.get("href"));
					try
					{
						creview.add((String)ereview.get("href"));
					}
					catch(Exception e)
						{creview.add("");						
						}
					cint.add((String)eint.get("href"));
					curl.add((String)element.get("curl"));
					chq.add((String)element.get("chq"));
					cstock.add((String)element.get("cstock"));
					crating.add((String)element.get("crating"));
					csatisfaction.add((String)element.get("csatisfaction"));
					ceo_name.add((String)element.get("ceo_name"));
					ceo_rating.add((String)element.get("ceo_rating"));									
					}									
				}						
			//comp data end..	
			//jobdiaognsis start			
			String key = request.getParameter("searchString");		
			//out.println(key);
			//String key="software developer";
			Boolean split=false;
			String[] splitkey = null;
			if(key.indexOf(" ")>0)
				{splitkey=key.split(" ");
				split=true;
				}
			//System.out.println(key.indexOf(" "));
			//String[] splitkey={"java","developer"};
			JSONObject result=(JSONObject)jsonObject.get("results");
			JSONArray collection=(JSONArray)result.get("collection1");
			LinkedHashMap<String,String> main=new LinkedHashMap<String,String>();
			LinkedHashMap<String,String> sec=new LinkedHashMap<String,String>();
			
			int rescount=0;
			int rescount_s=0;
			ArrayList<JobObject> res=new ArrayList<JobObject>();
			ArrayList<JobObject> res_s=new ArrayList<JobObject>();
			for(int i=0;i<collection.size();i++)
				{JobObject a=new JobObject();				
				JSONObject title=(JSONObject)collection.get(i);
				JSONObject tt=(JSONObject)title.get("job_title");		
				String jt=(String)tt.get("text");
				if(org.apache.commons.lang3.StringUtils.containsIgnoreCase(jt,key))
					{
						if(main.get((String)tt.get("href"))==null)
							{main.put((String)tt.get("href"),jt);
							a.job_title=jt;
							a.job_href=(String)tt.get("href");
							a.source="jobdiagnosis";
							try
								{
								if((String)title.get("job_date")!=null)
									a.job_date=new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse((String)title.get("job_date"));
								}
							catch(Exception e)
								{								
								}
							a.cname_text=(String)title.get("cname");
							try
							{
								int keyhm=(int)cnamehm.get(a.cname_text);							
								a.cname_href=chref.get(keyhm);
								a.curl=curl.get(keyhm);
								a.chq=chq.get(keyhm);
								a.cstock=cstock.get(keyhm);
								a.crating=crating.get(keyhm);
								a.csatisfaction=csatisfaction.get(keyhm);
								a.ceo_name=ceo_name.get(keyhm);
								a.ceo_rating=ceo_rating.get(keyhm);
								a.csalary_href=csalary.get(keyhm);
								a.creview_href=creview.get(keyhm);
								a.cint_href=cint.get(keyhm);
								res.add(rescount++,a);
							}
							catch(NullPointerException e)
								{						
								}
							
							}									
												
					}
				else if(split) //individual string matching
					{for(int j=0;j<splitkey.length;j++)
						{if(org.apache.commons.lang3.StringUtils.containsIgnoreCase(jt,splitkey[j]))
							{if(sec.get((String)tt.get("href"))==null)
								{sec.put((String)tt.get("href"),jt);
								a.job_title=jt;
								a.job_href=(String)tt.get("href");
								a.source="jobdiagnosis";
								try
									{
									if((String)title.get("job_date")!=null)
										a.job_date=new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse((String)title.get("job_date"));
									}
								catch(Exception e)
									{								
									}
								a.cname_text=(String)title.get("cname");								
								try
								{
									int keyhm=(int)cnamehm.get(a.cname_text);							
									a.cname_href=chref.get(keyhm);
									a.curl=curl.get(keyhm);
									a.chq=chq.get(keyhm);
									a.cstock=cstock.get(keyhm);
									a.crating=crating.get(keyhm);
									a.csatisfaction=csatisfaction.get(keyhm);
									a.ceo_name=ceo_name.get(keyhm);
									a.ceo_rating=ceo_rating.get(keyhm);
									a.csalary_href=csalary.get(keyhm);
									a.creview_href=creview.get(keyhm);
									a.cint_href=cint.get(keyhm);
									res_s.add(rescount_s++,a);
								}
								catch(NullPointerException e)
									{					
									}	
								
								}															
							}
						
						}
										
					}					
								
				}			
			//JSON preparation
			JSONObject parent=new JSONObject();
			JSONObject child=new JSONObject();
			JSONArray rescollection=new JSONArray();    		    		    	
  		    		    		
    		JSONObject resultg=(JSONObject)jsong.get("results");
			JSONArray collectiong=(JSONArray)resultg.get("collection1");	
			JSONArray collectiong2=(JSONArray)resultg.get("collection2");
			LinkedHashMap<String,String> maing=new LinkedHashMap<String,String>();
			LinkedHashMap<String,String> secg=new LinkedHashMap<String,String>();									
			
			int rescountg=0;
			int rescount_sg=0;
			ArrayList<JobObject> resg=new ArrayList<JobObject>();
			ArrayList<JobObject> res_sg=new ArrayList<JobObject>();
			for(int i=0;i<collectiong.size();i++)
				{JobObject a=new JobObject();				
				JSONObject title=(JSONObject)collectiong.get(i);//entire 1 job..
				JSONObject tt;
				JSONObject loc_cname;
				try{				
				tt=(JSONObject)title.get("job_title");//job_title
				loc_cname=(JSONObject)collectiong2.get(i);
				}
				catch(ClassCastException e){
					continue;
				}				
				catch(IndexOutOfBoundsException e){
					continue;
				}				 			
				
				String jt=(String)tt.get("text");
				if(org.apache.commons.lang3.StringUtils.containsIgnoreCase(jt,key))
					{//out.print(jt);
						if(maing.get((String)tt.get("href"))==null)
							{maing.put((String)tt.get("href"),jt);
							a.job_title=jt;
							a.job_href=(String)tt.get("href");
							a.source="glassdoor";
							try
								{
								if((String)title.get("job_date")!=null)
									a.job_date=new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse((String)title.get("job_date"));
								}
							catch(Exception e)
								{								
								}
							a.cname_text=(String)loc_cname.get("cname");
							//out.print(" company-->"+a.cname_text+"<br>");
							try
							{							
								int keyhm=(int)cnamehm.get((String)loc_cname.get("cname"));							
								a.cname_href=chref.get(keyhm);
								a.curl=curl.get(keyhm);
								//if((String)loc_cname.get("cname")!=null)
								//	a.chq=(String)loc_cname.get("cname");
								//else
								a.chq=chq.get(keyhm);
								a.cstock=cstock.get(keyhm);
								a.crating=crating.get(keyhm);
								a.csatisfaction=csatisfaction.get(keyhm);
								a.ceo_name=ceo_name.get(keyhm);
								a.ceo_rating=ceo_rating.get(keyhm);
								a.csalary_href=csalary.get(keyhm);
								a.creview_href=creview.get(keyhm);
								a.cint_href=cint.get(keyhm);
								res.add(rescount++,a);
							}
							catch(NullPointerException e)
								{					
								}	
							a.chq=(String)loc_cname.get("job_location");//we will always have cname for Glassdoor irrespective of its company info..
							
							}									
												
					}
				else if(split)//individual string matching
					{for(int j=0;j<splitkey.length;j++)
						{if(org.apache.commons.lang3.StringUtils.containsIgnoreCase(jt,splitkey[j]))							
							{//out.print(jt+"<br>");
							if(secg.get((String)tt.get("href"))==null)
								{secg.put((String)tt.get("href"),jt);
								a.job_title=jt;
								a.job_href=(String)tt.get("href");
								a.source="glassdoor";
								try
									{
									if((String)title.get("job_date")!=null)
										a.job_date=new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse((String)title.get("job_date"));
									}
								catch(Exception e)
									{								
									}
								a.cname_text=(String)loc_cname.get("cname");
								//out.print("single-->"+i+" company-->"+a.cname_text+"<br>");								
								try
								{
									int keyhm=(int)cnamehm.get((String)loc_cname.get("cname"));							
									a.cname_href=chref.get(keyhm);
									a.curl=curl.get(keyhm);
									//if((String)loc_cname.get("cname")!=null)
									//	a.chq=(String)loc_cname.get("cname");
									//else
									a.chq=chq.get(keyhm);
									a.cstock=cstock.get(keyhm);
									a.crating=crating.get(keyhm);
									a.csatisfaction=csatisfaction.get(keyhm);
									a.ceo_name=ceo_name.get(keyhm);
									a.ceo_rating=ceo_rating.get(keyhm);
									a.csalary_href=csalary.get(keyhm);
									a.creview_href=creview.get(keyhm);
									a.cint_href=cint.get(keyhm);
									res_sg.add(rescount_sg++,a);
								}
								catch(NullPointerException e)
									{}									
								}															
							}
						
						}
										
					}					
								
				}
			
			//monster start
			JSONObject resultm=(JSONObject)jsonm.get("results");
			JSONArray collectionm=(JSONArray)resultm.get("collection1");
			
			for(int i=0;i<collectionm.size();i++)
			{try
			{
			JobObject a=new JobObject();				
			JSONObject title;
			JSONObject tt;
			JSONObject comp;				
			
			title=(JSONObject)collectionm.get(i);
			tt=(JSONObject)title.get("job_title");
			comp=(JSONObject)title.get("cname");			
			
			String jt=(String)tt.get("text");
			if(org.apache.commons.lang3.StringUtils.containsIgnoreCase(jt,key))
				{
					if(main.get((String)tt.get("href"))==null)
						{main.put((String)tt.get("href"),jt);
						a.job_title=jt;
						a.job_href=(String)tt.get("href");
						a.source="monster";
						try
							{
							if((String)title.get("job_date")!=null)
								a.job_date=new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse((String)title.get("job_date"));
							}
						catch(Exception e)
							{								
							}
						a.cname_text=(String)comp.get("text");
						try
						{
							int keyhm=(int)cnamehm.get(a.cname_text);							
							a.cname_href=chref.get(keyhm);
							a.curl=curl.get(keyhm);
							a.chq=chq.get(keyhm);
							a.cstock=cstock.get(keyhm);
							a.crating=crating.get(keyhm);
							a.csatisfaction=csatisfaction.get(keyhm);
							a.ceo_name=ceo_name.get(keyhm);
							a.ceo_rating=ceo_rating.get(keyhm);
							a.csalary_href=csalary.get(keyhm);
							a.creview_href=creview.get(keyhm);
							a.cint_href=cint.get(keyhm);
							res.add(rescount++,a);
						}
						catch(NullPointerException e)
							{						
							}
						
						}									
											
				}
			else if(split) //individual string matching
				{for(int j=0;j<splitkey.length;j++)
					{if(org.apache.commons.lang3.StringUtils.containsIgnoreCase(jt,splitkey[j]))
						{if(sec.get((String)tt.get("href"))==null)
							{sec.put((String)tt.get("href"),jt);
							a.job_title=jt;
							a.job_href=(String)tt.get("href");
							a.source="monster";
							try
								{
								if((String)title.get("job_date")!=null)
									a.job_date=new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH).parse((String)title.get("job_date"));
								}
							catch(Exception e)
								{								
								}
							a.cname_text=(String)comp.get("text");								
							try
							{
								int keyhm=(int)cnamehm.get(a.cname_text);							
								a.cname_href=chref.get(keyhm);
								a.curl=curl.get(keyhm);
								a.chq=chq.get(keyhm);
								a.cstock=cstock.get(keyhm);
								a.crating=crating.get(keyhm);
								a.csatisfaction=csatisfaction.get(keyhm);
								a.ceo_name=ceo_name.get(keyhm);
								a.ceo_rating=ceo_rating.get(keyhm);
								a.csalary_href=csalary.get(keyhm);
								a.creview_href=creview.get(keyhm);
								a.cint_href=cint.get(keyhm);
								res_s.add(rescount_s++,a);
							}
							catch(NullPointerException e)
								{					
								}	
							
							}															
						}
					
					}
									
				}					
			}//end try
			catch(Exception e)
			{
				continue;
			}
			}//end for	
			
			
			ArrayList<JobObject> combinedJobsList = new ArrayList<JobObject>(res);
			combinedJobsList.addAll(res_sg);
			combinedJobsList.addAll(res_s);
			for(int i=combinedJobsList.size()-1; i>=0; i--){
				JobObject object = combinedJobsList.get(i);
				if(object.job_date==null){
					combinedJobsList.remove(i);
				}
				else if(object.chq != null && !object.chq.contains(" "+searchPlace)){
					combinedJobsList.remove(i);
				}
				else if(object.chq == null){
					combinedJobsList.remove(i);
				}
			}
			Collections.sort(combinedJobsList);
			
			for(int i=0; i<combinedJobsList.size();i++){
				JSONObject resone=new JSONObject();
				JSONObject jobd=new JSONObject();
				JSONObject cnamed=new JSONObject();
				JSONObject salaryd=new JSONObject();
				JSONObject intd=new JSONObject();
				JSONObject reviewd=new JSONObject();
				//out.println(((JobObject)combinedJobsList.get(i)).job_title+"<br>");
	    		if(((JobObject)combinedJobsList.get(i)).cname_text!=null)
					{jobd.put("href",((JobObject)combinedJobsList.get(i)).job_href);
					jobd.put("text",((JobObject)combinedJobsList.get(i)).job_title);
					resone.put("job_title",jobd);
					
					resone.put("source",((JobObject)combinedJobsList.get(i)).source);
					Date date;
					try{
					date = ((JobObject)combinedJobsList.get(i)).job_date;
					}
					catch(IndexOutOfBoundsException e)
					{
						date =null;
					}
					String dateStr = "";
					if(date != null){
						dateStr = date.toString();
						if(dateStr.contains(" 00:00:00 PDT")){
							int index = dateStr.indexOf(" 00:00:00 PDT");
							dateStr = dateStr.substring(0, index) + "," +
									dateStr.substring(index + 13);
						}
					}
					resone.put("job_date", dateStr);
					cnamed.put("href",((JobObject)combinedJobsList.get(i)).cname_href);
					cnamed.put("text",((JobObject)combinedJobsList.get(i)).cname_text);
					resone.put("cname",cnamed);
					
					resone.put("curl", ((JobObject)combinedJobsList.get(i)).curl);
					resone.put("chq", ((JobObject)combinedJobsList.get(i)).chq);
					resone.put("cstock", ((JobObject)combinedJobsList.get(i)).cstock);
					resone.put("csatisfaction", ((JobObject)combinedJobsList.get(i)).csatisfaction);
					resone.put("ceo_name", ((JobObject)combinedJobsList.get(i)).ceo_name);
					resone.put("ceo_rating", ((JobObject)combinedJobsList.get(i)).ceo_rating);
					resone.put("crating", ((JobObject)combinedJobsList.get(i)).crating);
					
					salaryd.put("href",((JobObject)combinedJobsList.get(i)).csalary_href);
					salaryd.put("text","Salary");
					resone.put("csalary",salaryd);
					
					reviewd.put("href",((JobObject)combinedJobsList.get(i)).creview_href);
					reviewd.put("text","Reviews");
					resone.put("creviews",reviewd);
					
					intd.put("href",((JobObject)combinedJobsList.get(i)).creview_href);
					intd.put("text","Interviews");
					resone.put("cinterviews",intd);
					}
	    		rescollection.add(resone); 
			}
    		
    		//cache rescollection to hardidsk
    		JSONObject resObject = new JSONObject();
    		resObject.put("rescollection", rescollection);
    		String fJson = "";
    		String rescollStr = resObject.toString();
    		//String contextPath = request.getContextPath();
    		//File resholder = new File(contextPath+"\\resholder.txt");
    		File resholder = new File("C:\\USC\\CSCI-548\\Project\\workspace\\CSCI548\\json\\resholder.txt");
    		resholder.createNewFile();
    		PrintWriter writer = new PrintWriter(resholder);
    		writer.write(rescollStr);
    		writer.flush();
    		writer.close();
    		
    		
    		JSONArray array = new JSONArray();
    		if(firstResultPage){
    			for(int i=0; i<10; i++){
    				JSONObject object = (JSONObject)rescollection.get(i);
    				array.add(object);
    			}
    		}
    		child.put("collection", rescollection);
    		parent.put("results", child);
			fJson=parent.toString();
    		out.println(fJson);
    		
    		//System.out.println(fJson);

			//out.print("</body></html>");
	 
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

