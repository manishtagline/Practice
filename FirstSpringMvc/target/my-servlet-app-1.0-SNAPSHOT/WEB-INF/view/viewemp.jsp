<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>View Employees</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('https://images.unsplash.com/photo-1549921296-3a6b4c21e3d3');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: #333;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #ffffff;
            background-color: rgba(0, 0, 0, 0.6);
            padding: 10px;
            border-radius: 8px;
        }

        table {
            width: 90%;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
        }

        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        a {
            color: #0066cc;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }

        .add-button {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px;
            background-color: #28a745;
            color: white;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
        }

        .add-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<h2>Employee List</h2>

<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Salary</th>
        <th>Designation</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="emp" items="${listOfEmployee}">
        <tr>
            <td>${emp.getId()}</td>
            <td>${emp.getName()}</td>
            <td>${emp.getSalary()}</td>
            <td>${emp.getDesignation()}</td>
            <td>
                <a href="edit/${emp.getId()}">Edit</a> |
                <a href="delete/${emp.getId()}" onclick="return confirm('Are you sure? You want to delete!!')">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>

<a href="empform" class="add-button">Add New Employee</a>

</body>
</html>
