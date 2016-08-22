package com.subreddit.controller;

import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.support.XmlWebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.subreddit.bean.LinkDetails;
import com.subreddit.bean.LinkForm;
import com.subreddit.bean.SharedBean;
import com.subreddit.dao.Service;

@Controller
@RequestMapping("/link")
public class link {
	
	@RequestMapping(value="/linksubmit")
	public ModelAndView linkSubmit(LinkForm l, HttpServletRequest request) throws NoSuchAlgorithmException
	{
		String linkd = l.getLinkd();
		String linka = l.getLinka();
		ServletContext servletcontext = request.getServletContext();
		XmlWebApplicationContext context = new XmlWebApplicationContext();
		context.setServletContext(servletcontext);
		context.setConfigLocations(new String[]{"/WEB-INF/dispatcher-servlet.xml"});
		context.refresh();
		context.start();
		LinkDetails ll = (LinkDetails) context.getBean("linkdetails");
		ll.setLinkd(linkd);
		ll.setLinka(linka);
		ll.setUser((String)request.getSession().getAttribute("user"));
		Service s = (Service) context.getBean("service");
		String formattedDate = s.getTime();
		ll.setDate(formattedDate);
		ll.setVote(1);
		SharedBean sb = (SharedBean) context.getBean("shared");
		String key = s.getUniqueID();
		sb.getLinkdetails().put(key, ll);
		return new ModelAndView("redirect:/");
	}
	
	@RequestMapping(value="/logout")
	public ModelAndView logout(HttpServletRequest request)
	{
		request.getSession().invalidate();
		return new ModelAndView("redirect:/");
	}
}
