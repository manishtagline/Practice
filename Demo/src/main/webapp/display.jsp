
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
        crossorigin="anonymous">
</head>
<body>
<table class="table">
  <tr>
    <th>Id</th>
    <th>Username</th>
    <th>Email</th>
    <th>Phone</th>
    <th>Address</th>
    <th colspan="2">Action</th>
  </tr>

  <c:forEach items="${data}" var="dt">
    <tr>
      <td>${dt.getId()}</td>
      <td>${dt.getName()}</td>
      <td>${dt.getEmail()}</td>
      <td>${dt.getPhone() }</td>
      <td>${dt.getAddress() }</td>
      <td><a href="delete?uid=${dt.getId()}" class="btn btn-danger">Delete</a></td>
    </tr>
  </c:forEach>

</table>
</body>
</html>
