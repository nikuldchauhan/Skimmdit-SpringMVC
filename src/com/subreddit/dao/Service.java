package com.subreddit.dao;

import java.security.NoSuchAlgorithmException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;



public interface Service {
	public String getUniqueID() throws NoSuchAlgorithmException;
	public String getTime();
	public Map getSortedMap(HttpServletRequest request);
}
