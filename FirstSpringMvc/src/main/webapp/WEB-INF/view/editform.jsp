<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html>
<head>
    <title>Edit Employee</title>
    <style>
        /* Background image and page style */
        body {
            font-family: Arial, sans-serif;
            background: url('https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1350&q=80') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            color: #333;
        }

        /* Form container with a translucent background */
        .form-container {
            background: rgba(255, 255, 255, 0.9);
            max-width: 450px;
            margin: 60px auto;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #004080;
            font-weight: 600;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        td {
            padding: 10px 8px;
            vertical-align: middle;
        }

        td:first-child {
            font-weight: bold;
            color: #004080;
            width: 100px;
        }

        /* Style input fields */
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 8px 10px;
            border: 1.8px solid #ccc;
            border-radius: 4px;
            font-size: 1em;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus, input[type="number"]:focus {
            border-color: #004080;
            outline: none;
        }

        input[type="submit"] {
            background-color: #004080;
            border: none;
            color: white;
            padding: 10px 18px;
            font-size: 1.1em;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
            width: 100%;
            margin-top: 15px;
        }

        input[type="submit"]:hover {
            background-color: #002a50;
        }

        /* Link style */
        .back-link {
            display: block;
            margin-top: 20px;
            text-align: center;
            font-weight: 500;
            color: #004080;
            text-decoration: none;
            font-size: 1em;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Edit Employee</h2>
    <form:form action="../editsave" method="post" modelAttribute="employee">
        <form:hidden path="id" />
        <table>
            <tr>
                <td>Name:</td>
                <td><form:input path="name" /></td>
            </tr>
            <tr>
                <td>Salary:</td>
                <td><form:input path="salary" /></td>
            </tr>
            <tr>
                <td>Designation:</td>
                <td><form:input path="designation" /></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Update" /></td>
            </tr>
        </table>
    </form:form>
    <a class="back-link" href="viewemp">Back to Employee List</a>
</div>
</body>
</html>
