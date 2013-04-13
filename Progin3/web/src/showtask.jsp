<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="progin3.DbUtil" %>

<%
    Connection con = DbUtil.getConnection();
    ResultSet r = null;
    Statement st = con.createStatement();
    String s_user = (String) session.getAttribute("user");
	
    r= st.executeQuery("SELECT * FROM `kategori` natural join `user` natural join `anggota` WHERE `user`.username='"+s_user+"'");
	
	int catType = Integer.parseInt(request.getParameter("cat"));
	
	if (catType==0){
            while (r.next())
            {
                out.print("<li>");
                out.print("<div class=\"judulkategoriwrap\">");
                out.print("<div class=\"judulkategori\">"+r.getString("nama_kategori")+"</div>");
                out.print("<div class=\"kategoriaddtugas\">");
                out.print("<a href=\"MakeTask.jsp?idcat="+r.getString("id_kategori")+"&iduser="+r.getString("id_user")+"\">+</a>");
                out.print("<a href=\"deleteCat.jsp?idcat="+r.getString("id_kategori")+"\">x</a>");
                out.print("</div></div>"); 
                Statement sTugas = con.createStatement();
                ResultSet rTugas = sTugas.executeQuery("SELECT * FROM `tugas` natural join `user` natural join `kategori` natural join `anggota` WHERE `user`.username='"+s_user+"' AND `kategori`.nama_kategori='"+r.getString("nama_kategori")+"'");	
                while(rTugas.next()){
                    out.print("<div class=\"tugaswrap\">");
                    out.print("<input type=\"checkbox\" id=\"checklist"+rTugas.getString("id_tugas")+"\" ");
                    if (rTugas.getString("status_tugas").equals("done")){
                        out.print("checked");
                    }
                    out.print(" name=\"check\" onclick=\"changevalues("+rTugas.getString("id_tugas")+");\" />");
                    out.print("<a class=\"kategoritugas\" href=\"taskdetails.jsp?idtask="+rTugas.getString("id_tugas")+"&iduser="+rTugas.getString("id_user")+"\">"+rTugas.getString("nama_tugas")+"<span>Tag: ");	
                    Statement sTag = con.createStatement();
                    ResultSet rTag = sTag.executeQuery("SELECT * FROM `tag` natural join `tugas` WHERE `tugas`.nama_tugas='"+rTugas.getString("nama_tugas")+"'");
                    if (rTag.next()){
                        out.print(rTag.getString("label"));
                    }else{
                        out.print("-");
                    }
                    while(rTag.next()){
                        out.print(", "+rTag.getString("label"));
                    }
                    out.print("</span></a>");
                    out.print("<div class=\"kategoritugastanggal\">"+rTugas.getString("deadline")+"</div>");
                    out.print("</div>");
                }
                out.print("</li>");
            }
        }else{
            while(r.getRow() != catType){
                r.next();
            }
            out.print("<li>");
            out.print("<div class=\"judulkategoriwrap\">");
            out.print("<div class=\"judulkategori\">"+r.getString("nama_kategori")+"</div>");
            out.print("<div class=\"kategoriaddtugas\">");
            out.print("<a href=\"MakeTask.jsp?idcat="+r.getString("id_kategori")+"&iduser="+r.getString("id_user")+"\">+</a>");
            out.print("<a href=\"deleteCat.jsp?idcat="+r.getString("id_kategori")+"\">x</a>");
            out.print("</div></div>");
            Statement sTugas = con.createStatement();
            ResultSet rTugas = sTugas.executeQuery("SELECT * FROM `tugas` natural join `user` natural join `kategori` natural join `anggota` WHERE `user`.username='"+s_user+"' AND `kategori`.nama_kategori='"+r.getString("nama_kategori")+"'");	
            while(rTugas.next()){
                out.print("<div class=\"tugaswrap\">");
                out.print("<input type=\"checkbox\" id=\"checklist"+rTugas.getString("id_tugas")+"\" ");
                if (rTugas.getString("status_tugas").equals("done")){
                    out.print("checked");
                }
                out.print(" name=\"check\" onclick=\"changevalues("+rTugas.getString("id_tugas")+");\" />");
                out.print("<a class=\"kategoritugas\" href=\"taskdetails.jsp?idtask="+rTugas.getString("id_tugas")+"&iduser="+rTugas.getString("id_user")+"\">"+rTugas.getString("nama_tugas")+"<span>Tag: ");	
                Statement sTag = con.createStatement();
                ResultSet rTag = st.executeQuery("SELECT * FROM `tag` natural join `tugas` WHERE `tugas`.nama_tugas='"+rTugas.getString("nama_tugas")+"'");
                if (rTag.next()){
                    out.print(rTag.getString("label"));
                }else{
                    out.print("-");
                }
                while(rTag.next()){
                    out.print(", "+rTag.getString("label"));
                }
                out.print("</span></a>");
                out.print("<div class=\"kategoritugastanggal\">"+rTugas.getString("deadline")+"</div>");
                out.print("</div>");
            }
        }
%>