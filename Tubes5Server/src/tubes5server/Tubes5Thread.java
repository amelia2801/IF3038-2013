/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package tubes5server;

import java.io.*;
import java.net.*;
import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;
/**
 *
 * @author M.ECKY.RABANI
 */
public class Tubes5Thread extends Thread {
    private Socket socket = null;
    
    public Tubes5Thread(Socket socket) {
        super("Tubes5Thread");
        this.socket = socket;
    }
    
    @Override
    public void run() {
        try {
            PrintWriter out = new PrintWriter(socket.getOutputStream(),true);
            BufferedReader in  = new BufferedReader(
                    new InputStreamReader(socket.getInputStream()));

            String inputline, outputline;

            Tubes5Protocol protocol = new Tubes5Protocol();
            
            while ((inputline = in.readLine()) != null) {
                if (!inputline.equalsIgnoreCase("isalive")) {
                    outputline = protocol.processInput(inputline);
                    out.println(outputline);
                }
            }
            out.close();
            in.close();
            socket.close();
        } catch (SocketException e) {
            System.err.println("Client disconnected");
        } catch (IOException e) {
            System.err.println("Client disconnected");
        }
    }
}
