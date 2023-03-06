<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="java.net.*,java.io.*" %>
<%
        String code = request.getParameter("code");
        String appID = "478393655583465"; // 자신의 appID로 수정
        String appSecret = "d509222be4a9be06c40bbba145a36c25"; // 자신의 app secret로 수정
        String callbackUrl = "http://" + request.getServerName() + ":8080/fxpear/callback.jsp";
        String access_token_url = "https://graph.facebook.com/oauth/access_token?" 
                + "client_id="+ appID 
                + "&redirect_uri=" + URLEncoder.encode(callbackUrl, "UTF-8") 
                + "&client_secret=" + appSecret + "&code=" + code;
        
System.out.println("access_token_url======"+access_token_url);
        URL yahoo = new URL(access_token_url);
        URLConnection yc = yahoo.openConnection();
        BufferedReader in = new BufferedReader(
                                new InputStreamReader(
                                yc.getInputStream()));
        String inputLine = null;
        out.println("<br/>access_token response =======================");
        while ((inputLine = in.readLine()) != null) 
            out.println(inputLine);
        out.println("<br/>access_token response =======================");
        in.close();
%>
<br />code : <%= code %>  <br />