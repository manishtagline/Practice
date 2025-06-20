📘 QuestionBank - Exam Portal Platform

QuestionBank is a full-stack web application for conducting online exams. Admins can create exams with questions, and users can log in, take exams, and view their results. The system evaluates answers, stores results, and supports role-based access.

🧠 Tech Stack

🔧 Backend

Spring Boot 3

Spring MVC

Hibernate / JPA (MySQL)

JSP optionally

🎨 Frontend

JSP Pages with JSTL

Bootstrap 5

JavaScript (form validation)

🗂️ Project Structure

QuestionBank/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/questionbanksite/
│   │   │       ├── controller/
│   │   │       ├── entity/
│   │   │       ├── repository/
│   │   │       └── service/
│   │   └── resources/
│   │       ├── application.properties
│   │       └── templates/ (if using Thymeleaf)
├── pom.xml
└── README.md

🚀 Features

👨‍💼 Admin Panel:

Create/Edit/Delete Exams

Manage Questions

👨‍🎓 User Panel:

Login/Register

View Available Exams

Take Exam (MCQ/Text based)

Get Results

✅ Auto Evaluation:

Auto compare answers (MCQs)

View answer details

🔐 Authentication:

Session-based login

Logout 

⚙️ Setup Instructions

📦 Backend Setup

Clone the repository:

git clone https://github.com/manishtagline/QuestionBank.git
cd QuestionBank

Configure Database in application.properties:

spring.datasource.url=jdbc:mysql://localhost:3306/questionbank
spring.datasource.username=root
spring.datasource.password=your_password
spring.jpa.hibernate.ddl-auto=update
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp

Run using IDE or command:

./mvnw spring-boot:run

🌐 Frontend Access

Admin: /admin

User: /

Default JSP Pages:

loginPage.jsp

home.jsp

exam.jsp

questionpaper.jsp

submissionMessage.jsp

result.jsp

resultDetails.jsp

📸 UI Snapshots

🔐 Login Page



🏠 Home Page



📄 Question Paper



✅ Result Details



🙌 Contributing

Feel free to fork, improve, and submit pull requests! If you want to add features like email notifications, PDF reports, or role upgrades, contributions are welcome.

🧑‍💻 Author

👨‍💻 Developed by Manish Tagline

📜 License

This project is open source and available under the MIT License.

