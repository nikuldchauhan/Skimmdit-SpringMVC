package com.subreddit.controller;

import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.support.XmlWebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.subreddit.bean.Login;
import com.subreddit.bean.SharedBean;
import com.subreddit.bean.Signup;
import com.subreddit.dao.Service;

@Controller
@RequestMapping("/")
public class Form {
	
	@RequestMapping(value="/",method = RequestMethod.GET)
	public ModelAndView printWelcome(ModelMap model,HttpServletRequest request) {
		
		HttpSession hs = request.getSession();
		String s = (String) hs.getAttribute("user");
		if(s!=null)
		{
			
			return new ModelAndView("link"); 
		}	
		return new ModelAndView("index");
	}
	
	@RequestMapping(value="/formlogin",method = RequestMethod.GET)
	public ModelAndView formlogin(HttpServletRequest request)
	{
		HttpSession hs = request.getSession();
		String s = (String) hs.getAttribute("user");
		if(s!=null)
		{
			
			return new ModelAndView("link"); 
		}	
		return new ModelAndView("index");
	}
	@RequestMapping(value="/formlogin",method = RequestMethod.POST)
	public ModelAndView formlogin(Login obj, HttpServletRequest request)
	{
		  ServletContext servletcontext = request.getServletContext();
		  XmlWebApplicationContext context = new XmlWebApplicationContext();
		  context.setServletContext(servletcontext);
		  context.setConfigLocations(new String[]{"/WEB-INF/dispatcher-servlet.xml"});
		  context.refresh();
		  context.start();
		  String un = obj.getUsername();
		  String pw = obj.getPassword();
		  SharedBean sb = (SharedBean) context.getBean("shared");
		  Service s = (Service) context.getBean("service");
		  Map m = sb.getUser();
		  if(m.containsKey(un) && pw.equals(m.get(un)))
		  {
			  request.getSession().setAttribute("user", un);
			  return new ModelAndView("link");
		  }
		  else
		  {
			  return new ModelAndView("index", "error", "Username or Password is incorrect");
		  } 
	}
	
	@RequestMapping(value="/signup")
	public ModelAndView signup()
	{
		 return new ModelAndView("signup");
	}
	
	@RequestMapping(value="/formsignup",method = RequestMethod.POST)
	public ModelAndView formsignup(Signup obj, HttpServletRequest request)
	{
		  ServletContext servletcontext = request.getServletContext();
		  XmlWebApplicationContext context = new XmlWebApplicationContext();
		  context.setServletContext(servletcontext);
		  context.setConfigLocations(new String[]{"/WEB-INF/dispatcher-servlet.xml"});
		  context.refresh();
		  context.start();
		  String un = obj.getUsername();
		  String pw = obj.getPassword();
		  SharedBean sb = (SharedBean) context.getBean("shared");
		  Map m = sb.getUser();
		  if(m.containsKey(un))
		  {
			  return new ModelAndView("signup", "error", "Username is already exist please try another");
		  }
		  else
		  {
			  m.put(un, pw);
			  return new ModelAndView("redirect:/");
		  }
	}
	
	@RequestMapping(value="/back")
	public ModelAndView back()
	{
		return new ModelAndView("index");
	}
	
}
