<%-- 
    Document   : meoBooksAction
    Created on : 11.05.2018, 13:38:18
    Author     : Didier Meo
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    /* Step 1) Get the data from the form */
    String strID_Book   = request.getParameter("ID_Book");
    String strTitle     = request.getParameter("Title");
    String strAuthor    = request.getParameter("Author");
    String strEditor    = request.getParameter("Editor");
    String strISBN      = request.getParameter("ISBN");
    String strEYear     = request.getParameter("EYear");
    String straction    = request.getParameter("Action");

    /* Step 2) Initialize Variables */
    String strresult   = "Database was treated";
    String strquery    = "";
    String strdbdriver = "com.mysql.jdbc.Driver";

    /* Step 3) Create a query  */
    if (straction.equals("new"))
    {   strquery  = " insert into tb_books (ID_Book,Title,Author,Editor,ISBN,EYear)";
        strquery += " values (";
        strquery += "'" + strID_Book + "',";
        strquery += "'" + strTitle + "',";
        strquery += "'" + strAuthor + "',";
        strquery += "'" + strEditor + "',";
        strquery += "'" + strISBN + "',";
        strquery += "'" + strEYear + "')";
    }

    if (straction.equals("delete"))
    {
        strquery  = " delete from tb_books where Author = ";
        strquery += "'" + strAuthor + "'";
    }

    if (straction.equals("update"))
    {   strquery  = " update tb_books";
        strquery += " set ID_Book=" + "'" + strID_Book + "',";
        strquery += " set Title=" + "'" + strTitle + "',";
        strquery += " set Author=" + "'" + strAuthor + "',";
        strquery += " set Editor=" + "'" + strEditor + "',";
        strquery +=" set ISBN=" + "'" + strISBN + "',";
        strquery += " set EYear=" + "'" + strEYear + "'";
        strquery += " where Author=" + "'" + strAuthor + "'";
    }
    
    if (!(straction.equals("search")))
    {
        /* Step 4) Make a database connection */
        Connection _dbconn = null;
        try
        {
             Class.forName(strdbdriver);
            /*  getConnection(URL,User,Pw) */
             _dbconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MEOBooks", "root", "") ;
            /*create a SQL Statement */
            Statement _statement = _dbconn.createStatement();
            _statement.execute(strquery);
        }
        catch (ClassNotFoundException e)
        {   strresult  = " Error creating database drive class!";
            strresult += " <br/>" +  e.toString();
        }
        catch (SQLException e)
        {   strresult  = " Error processing the SQL!";
            strresult += " <br/>" +  e.toString();
        }
        finally
        {
            /* We must close the database connection now */
            try
            {   if (_dbconn != null)
                { _dbconn.close(); }
            }
            catch (SQLException e)
            {   strresult  = "Error in closing connection.";
                strresult += " <br/>" +  e.toString();
            }
        }
    }
%>
    
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>meoBooksAction.jsp is a JSP Page with a database connectivity developed by Didier MEO</title>
        <link rel="stylesheet" href="../css/meo01.css"/>
        <link rel="stylesheet" href="../css/bootstrap.min.css" >
        <script type="text/javascript" src="../js/bootstrap/bootstrap.min.js" ></script>
        <script type="text/javascript" src="../js/jquery/jquery-3.3.1.min.js"></script>
    </head>
    <body>
        <div id="meodiv01">
            <%! String Txt = "JSP Page with a database connectivity developed by Didier MEO" ;
            %>    
            <table><tr><td><img src="../images/MEO_Consult50x50.png"></td><td><h1> <%= Txt %> </h1></td></tr></table>
        </div>
        <p></p>

        <%
            if (straction.equals("search"))
            {
                strquery  = "select * from tb_books where Author like "; //strquery  = "select * from tb_books where Author = "; 
                strquery += "'%" + strAuthor + "%'";

        %>
        <table>
            <%
                 Connection _dbconn = null;
                Class.forName(strdbdriver);
            /*  getConnection(URL,User,Pw) */
             _dbconn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MEOBooks", "root", "") ;
            /*create a SQL Statement */
                Statement _statement = _dbconn.createStatement();
                ResultSet rs = _statement.executeQuery(strquery);
                ResultSetMetaData resMetaData = rs.getMetaData();
                int iCols = resMetaData.getColumnCount();
            %>
            <tr>
                <%
                    for (int col = 1; col <= iCols; col++) {
                        out.print("<td><b>" + resMetaData.getColumnName(col) + "</b></td>");
                    }
                %>
            </tr>
            <%
                while (rs.next()) {
            %>
                <tr>
                    <%
                        strID_Book = rs.getString(1);
                        strTitle = rs.getString(2);
                        strAuthor = rs.getString(3);
                        strEditor = rs.getString(5); 
                        strISBN = rs.getString(4);
                        strEYear = rs.getString(6);
                        for (int col = 1; col <= iCols; col++) {
                            out.print("<td>" + rs.getString(col) + "</td>");
                        }
                    %>
                </tr>
            <%
                }
            %>
        </table>
        <%
            _dbconn.close();
        }
        %>
        The following query was submitted:  <i> <%=strquery%> </i> <br/><br/>

       <p> </p>
       <form method="get" >
               <table>
                   <tr>
                       <td>ID_Book</td>
                       <td><input type="text" name="ID_Book" value="<%= strID_Book %>" size="50"/></td>
                   </tr>
                   <tr>
                       <td>Title</td>
                       <td><input type="text" name="Title" value="<%= strTitle %>" size="50"/></td>
                   </tr>
                   <tr>
                       <td>Author</td>
                       <td><input type="text" name="Author" value="<%= strAuthor %>" size="50"/></td>
                   </tr>
                   <tr>
                       <td>Editor</td>
                       <td><input type="text" name="Editor" value="<%= strEditor %>" size="50"/></td>
                   </tr>
                   <tr>
                       <td>ISBN</td>
                       <td><input type="text" name="ISBN" value="<%= strISBN %>" size="50"/></td>
                   </tr>
                   <tr>
                       <td>EYear</td>
                       <td><input type="text" name="EYear" value="<%= strEYear %>" size="50"/></td>
                   </tr>
               </table>
       </form>
        <%
        if ((straction.equals("delete"))||(straction.equals("new"))){
        %>
                <a href="meoBooks.jsp"><p><h2>Click here for more ...</h2></p></a>
        <%
        }
        else
        {
        %>
        <a href="meoBooks.jsp?ID_Book=<%= strID_Book %>&Title=<%= strTitle %>&Author=<%= strAuthor %>&Editor=<%= strEditor %>&ISBN=<%= strISBN %>&EYear=<%= strEYear %>">
            <p><h2>Click here for more ...</h2></p></a>
        <%
        }
        %>
    </body>
</html>
