/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package tubes5server;

import java.sql.*;
import java.util.*;
import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;
/**
 *
 * @author M.ECKY.RABANI
 */
public class Tubes5Protocol {
    boolean gettask = false;
    boolean getlog = false;
    
    public void parseLog(String input) {
        String[] log = input.split("&");
        for (String s : log) {
            String[] task = s.split("%");
            Timestamp tm = Timestamp.valueOf(task[3]);
            if (tm.after(Tubes5Server.timestamp)) {
                try {
                    Connection conn = DBConnect.getConnection();
                    Statement stt = conn.createStatement();
                    String query = "update task set status = '" + task[2]+ "' where taskname = '" + task[0] + "'";
                    stt.executeUpdate(query);
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Fail updating database");
                } catch (NullPointerException e) {
                    System.err.println("Fail updating database");
                }
            }
        }
    }
    
    public String processInput(String input) {
        String output = null;
        
        if (input.equalsIgnoreCase("list")) {
            getlog = true;
        }
        else if (input.equalsIgnoreCase("update")) {
            gettask = true;
        }
        else if (input.equalsIgnoreCase("list2")) {
            try {
                Connection conn = DBConnect.getConnection();
                Statement stt = conn.createStatement();
                String query = "select taskname,status from task";
                ResultSet rs = stt.executeQuery(query);

                String out = "";
                while (rs.next()) {
                    out += rs.getString("taskname") + ":" + rs.getString("status") + "-";
                }
                output = out;
                conn.close();
            } catch (SQLException e) {
                System.out.println("Fail getting task list");
                output = "Fail to get list task";
            } catch (NullPointerException e) {
                System.out.println("Fail getting task list");
                output = "Fail to get list task";
            }
        }
        else {
            if (!gettask && !getlog && !input.equalsIgnoreCase("isalive")) {
                HashMap<String,String> listuser = new HashMap<String,String>();
                try {
                    Connection conn = DBConnect.getConnection();
                    Statement stt = conn.createStatement();
                    String query = "select username,password from user";
                    ResultSet rs = stt.executeQuery(query);

                    while (rs.next()) {
                        listuser.put(rs.getString("username"), rs.getString("password"));
                    }

                    String[] user = input.split("-");

                    output = "fail";
                    for (String s : listuser.keySet()) {
                        if (s.equals(user[0])) {
                            if (user[1].equals(listuser.get(s))) {
                                output = "success";
                            }
                        }
                    }

                    conn.close();
                } catch (SQLException e) {
                    System.out.println("Fail validating user");
                    output = "Fail to validate";
                } catch (NullPointerException e) {
                    System.out.println("Fail validating user");
                    output = "Fail to validate";
                }
            }
            else if (gettask && !getlog) {
                try {
                    Connection conn = DBConnect.getConnection();
                    Statement stt = conn.createStatement();
                    
                    String[] update = input.split("%");
                    
                    String status;
                    if (update[2].equalsIgnoreCase("INCOMPLETE"))
                        status = "INCOMPLETE";
                    else
                        status = "COMPLETE";
                    
                    String query = "update task set status = '" + status + "' where taskname = '" + update[0] + "'";
                    stt.executeUpdate(query);
                    Tubes5Server.timestamp = Timestamp.valueOf(update[3]);
                    gettask = false;
                    conn.close();
                } catch (SQLException e) {
                    System.err.println("Fail updating database");
                    output = "Fail to update database";
                } catch (NullPointerException e) {
                    System.err.println("Fail updating database");
                    output = "Fail to update database";
                }
            }
            else if (!gettask && getlog) {
                if (!input.equals("")) {
                    parseLog(input);
                    try {
                        Connection conn = DBConnect.getConnection();
                        Statement stt = conn.createStatement();
                        String query = "select taskname,status from task";
                        ResultSet rs = stt.executeQuery(query);

                        String out = "";
                        while (rs.next()) {
                            out += rs.getString("taskname") + ":" + rs.getString("status") + "-";
                        }
                        output = out;
                        conn.close();
                    } catch (SQLException e) {
                        System.out.println("Fail getting task list");
                        output = "Fail to get list task";
                    } catch (NullPointerException e) {
                        System.out.println("Fail getting task list");
                        output = "Fail to get list task";
                    }
                    getlog = false;
                }
                else if (!input.equalsIgnoreCase("isalive")) {
                    try {
                        Connection conn = DBConnect.getConnection();
                        Statement stt = conn.createStatement();
                        String query = "select taskname,status from task";
                        ResultSet rs = stt.executeQuery(query);

                        String out = "";
                        while (rs.next()) {
                            out += rs.getString("taskname") + ":" + rs.getString("status") + "-";
                        }
                        output = out;
                        conn.close();
                    } catch (SQLException e) {
                        System.out.println("Fail getting task list");
                        output = "Fail to get list task";
                    } catch (NullPointerException e) {
                        System.out.println("Fail getting task list");
                        output = "Fail to get list task";
                    }
                    getlog = false;
                }
            }
        }
        System.out.println(output);
        return output;
    }
}
