

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

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
public class CheckConnection extends Thread {
    private Socket socket = null;
    private MainFrame mainframe = null;
    
    public CheckConnection(Socket socket, MainFrame mainframe) {
        super("CheckConnection");
        this.socket = socket;
        this.mainframe = mainframe;
    }
    
    @Override
    public void run() {
        try {
            PrintWriter out = new PrintWriter(socket.getOutputStream(),true);
            BufferedReader in  = new BufferedReader(
                    new InputStreamReader(socket.getInputStream()));

            while (socket.isConnected()) {
                sleep(3000);
                out.println("list2");
                String input = in.readLine();
                mainframe.Update(input);
            }
            
            out.close();
            in.close();
            socket.close();
        } catch (SocketException e) {
            System.err.println("Failed connecting to server");
            mainframe.SetStatus("Disconnected from server");
            while (!mainframe.Reconnect()) {
                System.out.println("masuk");
            }
        } catch (IOException e) {
            System.err.println("Failed connecting to server");
            mainframe.SetStatus("Disconnected from server");
            while (!mainframe.Reconnect()) {
                System.out.println("masuk");
            }
        } catch (InterruptedException e) {
            System.err.println("Failed connecting to server");
            mainframe.SetStatus("Disconnected from server");
            while (!mainframe.Reconnect()) {  
                System.out.println("masuk");
            }
        }
    }
}
