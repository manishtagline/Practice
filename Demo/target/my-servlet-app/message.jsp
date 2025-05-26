
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Message Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background-color: #f4f4f4;
            text-align: center;
        }
        .message {
            padding: 20px;
            border-radius: 10px;
            font-size: 20px;
            display: inline-block;
            margin-top: 100px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 2px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 2px solid #f5c6cb;
        }
    </style>
</head>
<body>
<%
    String success = (String) request.getAttribute("success");
    String fail = (String) request.getAttribute("fail");

    if (success != null) {
%>
<div class="message success">
    <%= success %>
</div>
<%
} else if (fail != null) {
%>
<div class="message error">
    <%= fail %>
</div>
<%
} else {
%>
<div class="message error">
    No message to display.
</div>
<%
    }
%>

<br/>
<a href="register.jsp" class="btn">Register Again</a>
<a href="view" class="btn">View Table</a>
</body>
</html>
