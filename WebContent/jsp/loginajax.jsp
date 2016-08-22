<%@ page import="org.springframework.web.context.support.XmlWebApplicationContext" %>
<%@ page import="com.subreddit.dao.Service" %>
<%@ page import="com.subreddit.bean.SharedBean" %>
<%@ page import="com.subreddit.bean.SharedBean" %>
<%@ page import="com.subreddit.bean.LinkDetails" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
ServletContext servletcontext = request.getServletContext();
XmlWebApplicationContext context = new XmlWebApplicationContext();
context.setServletContext(servletcontext);
context.setConfigLocations(new String[]{"/WEB-INF/dispatcher-servlet.xml"});
context.refresh();
context.start();
Service s = (Service) context.getBean("service");
Map m = s.getSortedMap(request);
SharedBean sb = (SharedBean) context.getBean("shared");
Map mm = sb.getLinkdetails();
Iterator<Map.Entry<String,Integer>> iter = m.entrySet().iterator();
boolean bool = true;
while (iter.hasNext())
{
	bool=false;
    Map.Entry<String,Integer> entry = iter.next();
    LinkDetails u = (LinkDetails) mm.get(entry.getKey());
    Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy h:mm:ss");
	String formattedDate = sdf.format(date);
	 String dateStart = u.getDate();
	    String dateStop = formattedDate;

	    SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd HH:mm:ss");

	    Date d1 = null;
	    Date d2 = null;
	    try {
	        d1 = format.parse(dateStart);
	        d2 = format.parse(dateStop);
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }

	    // Get msec from each, and subtract.
	    long diff = d2.getTime() - d1.getTime();
	    long diffSeconds = diff / 1000 % 60;
	    long diffMinutes = diff / (60 * 1000) % 60;
	    long diffHours = diff / (60 * 60 * 1000);
		
	    String user = (String) session.getAttribute("user");
	    boolean b = false;
	    if(user!=null)
	    {
	    	b = true;
	    }	
	    
	out.println("<div id='left' style='height:93px;width:40px;float:left;border:1px solid black;'>");
		out.println("<div id='up' style='height:30px;width:40px;border-bottom:1px solid black;'><img class='vo' ty='up' pi='"+entry.getKey()+"' style='cursor:pointer;' src='"+request.getContextPath()+"/images/caret-top-8x.png' width='25px' height='25px' /></div>");	
		out.println("<div id='middle' style='height:30px;width:40px;border-bottom:1px solid black;'>"+u.getVote()+"</div>");
		out.println("<div id='bottom' style='height:30px;width:40px;'><img class='vo' ty='down' pi='"+entry.getKey()+"' style='cursor:pointer;' src='"+request.getContextPath()+"/images/caret-bottom-8x.png' width='25px' height='25px' /></div>");
	out.println("</div>");
	out.println("<div id='right' style='height:93px;width:400px;float:left;border:1px solid black;'>");
	out.println("<a style='text-decoration:none,color:blue;' target='_blank' href='"+u.getLinka()+"'>"+u.getLinkd()+"</a>");
	out.println("</div>");
	out.println("<div id='blank' style='height:30px;width:40px;float:left;clear:left;'></div>");
	out.println("<div id='uservalue' style='height:30px;width:200px;float:left;border:1px solid black;'>"+u.getUser()+"</div>");
	out.println("<div id='time' style='height:30px;width:200px;float:left;border:1px solid black;'>"+Math.abs(diffMinutes)+" minutes ago</div>");
	out.println("<div style='width:10px;height:10px;clear:left;'></div>");
}
if(bool)
{out.println("There is no link to display");}	
%>
<script>
$(".vo").click(function(){
	$("#login").html("Please login first");
});
</script>