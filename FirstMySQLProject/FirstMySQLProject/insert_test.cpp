#include <stdlib.h> 
#include <iostream> 

#include "mysql_connection.h" 
#include <cppconn/driver.h> 
#include <cppconn/exception.h> 
#include <cppconn/prepared_statement.h> 
using namespace std;

// for demonstration only. never save your password in the code! 
const string server = "tcp://127.0.0.1:3306"; // 데이터베이스 주소 
//tcp방식을 이용해서 통신(127.0.0.1는 자기 컴퓨터 주소를 의미,데이터베이스는 3306번사용 )
const string username = "user"; // 데이터베이스 사용자 
const string password = "1234"; // 데이터베이스 접속 비밀번호 

// mysql -u user -p , pasword =1234


//main문은 CREATE테이블 연결, 생성 
//INSERT 데이터 추가 
//CRUD 코드 
int main()
{
    // MySQL Connector/C++ 초기화 
    sql::Driver* driver; // 추후 해제하지 않아도 Connector/C++가 자동으로 해제해 줌 
    sql::Connection* con;
    sql::Statement* stmt;
    sql::PreparedStatement* pstmt;

    try
    {
        driver = get_driver_instance();
        con = driver->connect(server, username, password);
    }
    catch (sql::SQLException e)
    {
        cout << "Could not connect to server. Error message: " << e.what() << endl;
        system("pause");
        exit(1);
    }

    // please create database "cpp_db" ahead of time 
    con->setSchema("cpp_db");

    // 데이터베이스 쿼리 실행 
    stmt = con->createStatement();
    stmt->execute("DROP TABLE IF EXISTS inventory");
    cout << "Finished dropping table (if existed)" << endl;
    stmt->execute("CREATE TABLE inventory (department_id serial PRIMARY KEY, department_name VARCHAR(50),manager_id INTEGER, location VARCHAR(50));");
    cout << "Finished creating table" << endl;
    delete stmt;

    pstmt = con->prepareStatement("INSERT INTO inventory(department_id, department_name,manager_id,location) VALUES(?,?,?,?)");
    pstmt->setInt(1, 1);
    pstmt->setString(2, "Engineering");
    pstmt->setInt(3, 1);
    pstmt->setString(4, "New York");

    pstmt->execute();
    cout << "One row inserted." << endl;


    pstmt->setInt(1, 2);
    pstmt->setString(2, "Sales");
    pstmt->setInt(3, 5);
    pstmt->setString(4, "Los Angeles");
    pstmt->execute();
    cout << "One row inserted." << endl;



    pstmt->setInt(1, 3);
    pstmt->setString(2, "Marketing");
    pstmt->setInt(3, 7);
    pstmt->setString(4, "Chicago");
    pstmt->execute();
    cout << "One row inserted." << endl;


    pstmt->setInt(1, 4);
    pstmt->setString(2, "Accounting");
    pstmt->setInt(3, 8);
    pstmt->setString(4, "Houston");
    pstmt->execute();
    cout << "One row inserted." << endl;


    pstmt->setInt(1, 5);
    pstmt->setString(2, "IT");
    pstmt->setInt(3, 10);
    pstmt->setString(4, "San Francisco");
    pstmt->execute();
    cout << "One row inserted." << endl;

    // MySQL Connector/C++ 정리 
    delete pstmt;
    delete con;
    system("pause");

    return 0;
}