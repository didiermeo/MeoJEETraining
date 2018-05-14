<%-- 
    Document   : meoBooks
    Created on : 02.02.2018, 13:32:28
    Author     : Didier MEO
--%>

<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>meoBooks.jsp is a JSP Page with a database connectivity developed by Didier MEO</title>
        <link rel="stylesheet" href="../css/meo01.css"/>
        <script type="text/javascript" src="../js/meo01.js" ></script>
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
                String strID_Book   = request.getParameter("ID_Book");
                if(strID_Book == null) strID_Book = "";
                String strTitle     = request.getParameter("Title");
                if(strTitle == null) strTitle = "";
                String strAuthor    = request.getParameter("Author");
                if(strAuthor == null) strAuthor = "";
                String strEditor    = request.getParameter("Editor");
                if(strEditor == null) strEditor = "";
                String strISBN      = request.getParameter("ISBN");
                if(strISBN == null) strISBN = "";
                String strEYear     = request.getParameter("EYear");
                if(strEYear == null) strEYear = "";
            %>
        <form id="bookForm" action="meoBooksAction.jsp" method="post" name="bookForm">
            <table>
                <tr>
                    <td>ID_Book</td>
                    <td><input type="text" id="ID_Book" name="ID_Book" value="<%= strID_Book %>" size="50"/></td>
                </tr>
                <tr>
                    <td>Title</td>
                    <td><input type="text" id="Title" name="Title" value="<%= strTitle %>" size="50"/></td>
                </tr>
                <tr>
                    <td class="meocol1">Author</td>
                    <td><input type="text" id="Author" name="Author" value="<%= strAuthor %>" size="50"/></td>
                </tr>
                <tr>
                    <td>Editor</td>
                    <td><input type="text" id="Editor" name="Editor" value="<%= strEditor %>" size="50"/></td>
                </tr>
                <tr>
                    <td>ISBN</td>
                    <td><input type="text" id="ISBN" name="ISBN" value="<%= strISBN %>" size="50"/></td>
                </tr>
                <tr>
                    <td>EYear</td>
                    <td><input type="text" id="EYear" name="EYear" value="<%= strEYear %>" size="50"/></td>
                </tr>
                <tr><td> Action </td>
                    <td align="middle">
                        <input type="radio" name="Action" value="new" checked /> New
                        <input type="radio" name="Action" value="update" /> Update
                        <input type="radio" name="Action" value="delete" /> Delete
                        <input class="meocol1" type="radio" name="Action" value="search" checked /> Search
                    </td>
                </tr>
                <tr>
                    <td><input type="button" id="btnClear" name="btnClear" value="Clear" onclick="bookClear()"></td><td align="middle"><input class="meocol2" type="Submit" value="EXECUTE" /> </td>
                </tr>
            </table>
        </form>
    </body>
</html>
