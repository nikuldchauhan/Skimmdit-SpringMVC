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
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
String var = request.getParameter("var");
HttpSession s = request.getSession();
String user = (String) s.getAttribute("user");
ServletContext servletcontext = request.getServletContext();
XmlWebApplicationContext context = new XmlWebApplicationContext();
context.setServletContext(servletcontext);
context.setConfigLocations(new String[]{"/WEB-INF/dispatcher-servlet.xml"});
context.refresh();
context.start();
SharedBean sb = (SharedBean) context.getBean("shared");
if(var!=null)
{		 
	String ty = request.getParameter("ty");
	String pi = request.getParameter("pi");
	Map l = sb.getLike();
	Map link = sb.getLinkdetails();
	Map u = sb.getUnlike();
	if(ty.equals("up"))
	{	
		if(l.containsKey(user))
		{
			List<String> li = (List) l.get(user);
			if(li.contains(pi))
			{
				
				LinkDetails un = (LinkDetails)link.get(pi);
				int i = un.getVote();
				
				i--;
				li.remove(pi);
				un.setVote(i);
			}
			else
			{
				
				li.add(pi);
				LinkDetails un = (LinkDetails)link.get(pi);
				int i = un.getVote();
				
				if(u.containsKey(user))
				 {
					 List<String> liu= (List) u.get(user);
					 if(liu.contains(pi))
					 {
						
						 liu.remove(pi);
						 i++;
					 }	 
				 }	
				i++;
				un.setVote(i);
			}	
		}	
		else
			{
				
				List<String> li=new ArrayList<String>();
				li.add(pi);
				l.put(user, li);
				LinkDetails un = (LinkDetails)link.get(pi);
				int i = un.getVote();
				
				if(u.containsKey(user))
				 {
					 List<String> liu= (List) u.get(user);
					 if(liu.contains(pi))
					 {
						 liu.remove(pi);
						 i++;
					 }	 
				 }	
				i++;
				un.setVote(i);
			}		 
	}
	if(ty.equals("down"))
	{	
		if(u.containsKey(user))
		{
			List<String> li = (List) u.get(user);
			if(li.contains(pi))
			{
				
				LinkDetails un = (LinkDetails)link.get(pi);
				int i = un.getVote();
				
				i++;
				li.remove(pi);
				un.setVote(i);
			}
			else
			{
				
				LinkDetails un = (LinkDetails)link.get(pi);
				int i = un.getVote();
				
				if(i!=0)
				{	
				li.add(pi);
				if(l.containsKey(user))
				 {
					 List<String> liu= (List) l.get(user);
					 if(liu.contains(pi))
					 {
						 
						 liu.remove(pi);
						 if(i!=0)
							{	
							i--;
							}
					 }	 
				 }
				if(i!=0)
				{	
				i--;
				}
				un.setVote(i);}
			}	
		}	
		else
			{
			
			LinkDetails un = (LinkDetails)link.get(pi);
			int i = un.getVote();
			
			if(i!=0){
				List<String> li=new ArrayList<String>();
				li.add(pi);
				u.put(user, li);
				if(l.containsKey(user))
				 {
					 
					 List<String> liu= (List) l.get(user);
					 if(liu.contains(pi))
					 {
						 
						 liu.remove(pi);
						 if(i!=0)
							{	
							 i--;
							}
					 }	 
				 }
				if(i!=0)
				{	
				i--;
				}
				un.setVote(i);}
			}	
	}
}

Service ss = (Service) context.getBean("service");
Map m = ss.getSortedMap(request);
sb = (SharedBean) context.getBean("shared");
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
	ty = $(this).attr("ty");
	pi = $(this).attr("pi");
$.ajax({
	 url: "jsp/ajaxlink.jsp?var=vote1&ty="+ty+"&pi="+pi, 
	 success: function(result){
	        $("#main").html(result);
	    }
	    });
});
</script>