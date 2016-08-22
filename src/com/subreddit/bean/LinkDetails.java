package com.subreddit.bean;

public class LinkDetails {
	private String user;
	private String linkd;
	private String linka;
	private int vote;
	private String date;
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getLinkd() {
		return linkd;
	}
	public void setLinkd(String linkd) {
		this.linkd = linkd;
	}
	public String getLinka() {
		return linka;
	}
	public void setLinka(String linka) {
		this.linka = linka;
	}
	public int getVote() {
		return vote;
	}
	public void setVote(int vote) {
		this.vote = vote;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
}
