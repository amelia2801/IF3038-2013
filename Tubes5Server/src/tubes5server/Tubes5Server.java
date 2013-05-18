/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package tubes5server;

import java.io.*;
import java.net.*;
/**
 *
 * @author M.ECKY.RABANI
 */
public class Tubes5Server {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws IOException {
        ServerSocket serversocket = null;
        
        try {
            serversocket = new ServerSocket(8888);
        } catch (IOException e) {
            System.err.println("Fail to listen to port 8888");
            System.exit(1);
        }
        
        //listening for client
        try {
            while (true) {
                new Tubes5Thread(serversocket.accept()).start();
            }
        } catch (IOException e) {
            System.err.println("Accepting client failed");
        }
        
        System.out.println("Server closed");
        serversocket.close();
    }
}
