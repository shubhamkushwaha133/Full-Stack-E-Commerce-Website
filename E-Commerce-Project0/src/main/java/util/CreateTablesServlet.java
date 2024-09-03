package util;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import util.ConnectionProvider;

@WebServlet("/CreateTablesServlet")
public class CreateTablesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Connection con = ConnectionProvider.getCon();
            Statement st = con.createStatement();

            
            String q1 = "CREATE TABLE IF NOT EXISTS users (" +
                         "name VARCHAR(100), " +
                         "email VARCHAR(100) PRIMARY KEY, " +
                         "mobileNumber BIGINT, " +
                         "securityQuestion VARCHAR(200), " +
                         "answer VARCHAR(200), " +
                         "password VARCHAR(100), " +
                         "address VARCHAR(500), " +
                         "city VARCHAR(100), " +
                         "state VARCHAR(100), " +
                         "country VARCHAR(100))";

            String q2 = "CREATE TABLE IF NOT EXISTS product (" +
                         "id INT AUTO_INCREMENT PRIMARY KEY, " +
                         "name VARCHAR(500), " +
                         "category VARCHAR(200), " +
                         "price INT, " +
                         "active VARCHAR(10), " +
                         "image_path VARCHAR(255))";

            String q3 = "CREATE TABLE IF NOT EXISTS cart (" +
                         "email VARCHAR(100), " +
                         "product_id INT, " +
                         "quantity INT, " +
                         "price INT, " +
                         "total INT, " +
                         "address VARCHAR(500), " +
                         "city VARCHAR(100), " +
                         "state VARCHAR(100), " +
                         "country VARCHAR(100), " +
                         "mobileNumber BIGINT, " +
                         "orderdate VARCHAR(100), " +
                         "deliveryDate VARCHAR(100), " +
                         "paymentMethod VARCHAR(100), " +
                         "transactionId VARCHAR(100), " +
                         "status VARCHAR(10), " +
                         "PRIMARY KEY (email, product_id))";

            String q4 = "CREATE TABLE IF NOT EXISTS message (" +
                         "id INT AUTO_INCREMENT PRIMARY KEY, " +
                         "email VARCHAR(100), " +
                         "subject VARCHAR(200), " +
                         "body VARCHAR(1000))";

         
            //st.execute(q1);
            //st.execute(q2);
            //st.execute(q3);
            //st.execute(q4);

            con.close();

            response.getWriter().println("Tables created successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}

/*

CREATE TABLE IF NOT EXISTS favorites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_email VARCHAR(100),
    product_id INT,
    FOREIGN KEY (user_email) REFERENCES users(email),
    FOREIGN KEY (product_id) REFERENCES product(id)
);


// table description
 
 ---------- cart table
 email	varchar(100)	YES			
product_id	int	YES			
quantity	int	YES			
price	int	YES			
total	int	YES			
address	varchar(500)	YES			
city	varchar(100)	YES			
state	varchar(100)	YES			
country	varchar(100)	YES			
mobileNumber	bigint	YES			
orderdate	varchar(100)	YES			
deliveryDate	varchar(100)	YES			
paymentMethod	varchar(100)	YES			
transactionId	varchar(100)	YES			
status	varchar(10)	YES	

		
 --------- product table 
 id	int	YES	MUL		
name	varchar(500)	YES			
category	varchar(200)	YES			
price	int	YES			
active	varchar(10)	YES			
image_path	varchar(255)	YES			
favorites	tinyint(1)	YES		0	
pquantity	int	YES			
details	varchar(500)	YES			

--------- users table 
name	varchar(100)	YES			
email	varchar(100)	NO	PRI		
mobileNumber	bigint	YES			
securityQuestion	varchar(200)	YES			
answer	varchar(200)	YES			
password	varchar(100)	YES			
address	varchar(500)	YES			
city	varchar(100)	YES			
state	varchar(100)	YES			
country	varchar(100)	YES			
role	varchar(20)	YES		buyer	


---------- message table
id	int	NO	PRI		auto_increment
email	varchar(100)	YES			
subject	varchar(200)	YES			
body	varchar(1000)	YES			

--------  favorites
id	int	NO	PRI		auto_increment
user_email	varchar(100)	YES	MUL		
product_id	int	YES	MUL		




 */
