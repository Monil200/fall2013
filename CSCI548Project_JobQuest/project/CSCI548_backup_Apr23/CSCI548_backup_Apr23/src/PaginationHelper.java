

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


/**
 * Servlet implementation class PaginationHelper
 */
@WebServlet("/PaginationHelper")
public class PaginationHelper extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PaginationHelper() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			PrintWriter out=response.getWriter();
			response.setContentType("text/json");
			//String contextPath = request.getContextPath();
			File resholder = new File("C:\\USC\\CSCI-548\\Project\\workspace\\CSCI548\\json\\resholder.txt");
			JSONParser parser = new JSONParser();
			FileReader reader = new FileReader(resholder);
			JSONObject resObject = (JSONObject)parser.parse(reader);
			reader.close();
			JSONArray rescollection = (JSONArray)resObject.get("rescollection");
			int total_pages = Math.round(rescollection.size())/10;
			
			String fJson = "";
			int pageNum = Integer.parseInt(request.getParameter("page"));
			int startIdx = pageNum*10-9-1;
			int endIdx = pageNum*10-1;
			JSONArray array = new JSONArray();
			for(int i=startIdx; i<=endIdx; i++){
				if(rescollection.size()!=(pageNum-1)*10+i+1){
					JSONObject object = (JSONObject)rescollection.get(i);
					array.add(object);
				}
			}
			JSONObject child = new JSONObject();
			JSONObject parent = new JSONObject();
			child.put("collection", array);
			parent.put("results", child);
			fJson=parent.toString();
			out.println(fJson);
			System.out.println(fJson);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
