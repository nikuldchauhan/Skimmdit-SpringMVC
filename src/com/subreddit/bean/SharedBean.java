package com.subreddit.bean;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;



public class SharedBean {
	private Map user = new ConcurrentHashMap();
	private Map linkdetails = new ConcurrentHashMap();
	private Map like = new ConcurrentHashMap();
	private Map unlike = new ConcurrentHashMap();
	
	public Map getUser() {
		return user;
	}
	public Map getLinkdetails() {
		return linkdetails;
	}
	public Map getLike() {
		return like;
	}
	public Map getUnlike() {
		return unlike;
	}
	public void setUser(Map user) {
		this.user = user;
	}
	public void setLinkdetails(Map linkdetails) {
		this.linkdetails = linkdetails;
	}
	public void setLike(Map like) {
		this.like = like;
	}
	public void setUnlike(Map unlike) {
		this.unlike = unlike;
	}
}
