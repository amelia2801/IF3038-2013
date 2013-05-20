/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import javax.swing.JCheckBox;
import java.util.ArrayList;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.Socket;
import java.sql.Timestamp;
import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;
import java.io.FileInputStream;
import java.io.DataInputStream;
/**
 *
 * @author TOSHIBA
 */
public class MainFrame extends javax.swing.JFrame {
    private String username;
    private String password;
    private String path ="E:\\";
    private String filecontent = "";
    
    Socket socket = null;
    PrintWriter out = null;
    BufferedReader in = null;
    /**
     * Creates new form MainFrame
     */
    public MainFrame() {
        initComponents();
    }
    
    public void SetStatus(String status) {
        jLabel1.setText(status);
    }
    
    public MainFrame(String username, String password, Socket socket, PrintWriter out, BufferedReader in){
       initComponents();
       try {
            FileInputStream fstream = new FileInputStream(path+username+"\\log.txt");
            DataInputStream in_read = new DataInputStream(fstream);
            BufferedReader br = new BufferedReader(new InputStreamReader(in_read));
            String strLine = "";
            while ((strLine = br.readLine()) != null){
                filecontent += strLine + "&";
            }
            in_read.close();
        } catch (IOException e) {
            System.err.println("Failed to read log");
            filecontent = "";
        }
        
        try {
            this.socket = socket;
            this.out = out;
            this.in = in;
            this.username = username;
            welcomeLabel.setText("Welcome, "+username);
            jLabel1.setText("Connected to server");
            
            String fromserver = "";
            String fromuser;

            fromuser = "list";
            out.println(fromuser);
            fromserver = in.readLine();
            
            out.println(filecontent);
            fromserver = in.readLine();
            
            String[] listtask = fromserver.split("-");

            ArrayList<String> container = new ArrayList<String>();
            for (String s : listtask)
            {
                container.add(s);
            }
            JCheckBox checkbox;

            list.setLayout(new java.awt.GridLayout(container.size(),1));
            for (int i = 0 ; i < container.size(); i++){
                String namestatus = container.get(i);
                String[] attribute = namestatus.split(":");
                checkbox  = new JCheckBox(attribute[0]);
                checkbox.setName(attribute[0]);
                if (attribute[1].equals("COMPLETE")){
                    checkbox.setSelected(true);
                }else{
                    checkbox.setSelected(false);
                }
                checkbox.addActionListener(new Checked());
                list.add(checkbox);
            }
            list.revalidate();
            list.repaint();
            File file = new File(path+username+"log.txt");
            file.delete();
            
            new CheckConnection(socket,this).start();
        } catch (IOException e) {
            System.err.println("Failed to get list of task");
            System.exit(1);
        }
    }
    
    public boolean Reconnect() {
        try {
            try {
                socket = new Socket("user",8888);
                out = new PrintWriter(socket.getOutputStream(),true);
                in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            } catch (UnknownHostException e) {
                System.err.println("Host named \"user\" is not found");
            } catch (IOException e) {
                System.err.println("Failed to connect to \"user\"");
                return false;
            }
            
            jLabel1.setText("Connected to server");
            
            try {
                FileInputStream fstream = new FileInputStream(path+username+"\\log.txt");
                DataInputStream in_read = new DataInputStream(fstream);
                BufferedReader br = new BufferedReader(new InputStreamReader(in_read));
                String strLine = "";
                while ((strLine = br.readLine()) != null){
                    filecontent += strLine + "&";
                }
                in_read.close();
            } catch (IOException e) {
                System.err.println("Failed to read log");
                filecontent = "";
            }
            
            String fromserver = "";
            String fromuser;

            fromuser = "list";
            out.println(fromuser);
            fromserver = in.readLine();
            
            out.println(filecontent);
            fromserver = in.readLine();
            
            String[] listtask = fromserver.split("-");

            ArrayList<String> container = new ArrayList<String>();
            for (String s : listtask)
            {
                container.add(s);
            }
            JCheckBox checkbox;

            list.setLayout(new java.awt.GridLayout(container.size(),1));
            for (int i = 0 ; i < container.size(); i++){
                String namestatus = container.get(i);
                String[] attribute = namestatus.split(":");
                checkbox  = new JCheckBox(attribute[0]);
                checkbox.setName(attribute[0]);
                if (attribute[1].equals("COMPLETE")){
                    checkbox.setSelected(true);
                }else{
                    checkbox.setSelected(false);
                }
                checkbox.addActionListener(new Checked());
                list.add(checkbox);
            }
            list.revalidate();
            list.repaint();
            File file = new File(path+username+"log.txt");
            file.delete();
            
            new CheckConnection(socket,this).start();
            return true;
        } catch (IOException e) {
            System.err.println("Failed to get list of task");
            return false;
        }
    }
    
    class Checked implements ActionListener{
        public void actionPerformed(ActionEvent e){
            JCheckBox changed_element = (JCheckBox) e.getSource();
            Timestamp timestamp = new Timestamp(e.getWhen());
            String initialvalue = "";
            String value = "";
            if (changed_element.isSelected()){
                initialvalue = "INCOMPLETE";
                value = "COMPLETE";
            }else{
                initialvalue = "COMPLETE";
                value = "INCOMPLETE";
            }
            
            String content = changed_element.getName()+"%"+ initialvalue +"%"+value+"%"+timestamp;
            
            out.println("update");
            out.println(content);
            
            try {
                File dir = new File(path+username);
                dir.mkdirs();
                File file = new File(dir,"log.txt");
                if (!file.exists()){
                    file.createNewFile();
                }else{
                    content = "\n"+content;
                }
                    FileWriter fw = new FileWriter(file.getAbsoluteFile(),true);
                    BufferedWriter bw = new BufferedWriter(fw);
                    bw.write(content);
                    bw.close();
            }catch (IOException exp){
                System.err.println("Failed to write log");
            }
        }
    }
    

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        welcomeLabel = new javax.swing.JLabel();
        listtask = new javax.swing.JScrollPane();
        list = new javax.swing.JPanel();
        logoutButton = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        welcomeLabel.setFont(new java.awt.Font("Tahoma", 0, 24)); // NOI18N
        welcomeLabel.setText("Welcome ,");
        welcomeLabel.setBorder(new javax.swing.border.SoftBevelBorder(javax.swing.border.BevelBorder.RAISED));

        list.setLayout(new java.awt.GridLayout(1, 0));
        listtask.setViewportView(list);

        logoutButton.setText("Log Out");
        logoutButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                logoutButtonActionPerformed(evt);
            }
        });

        jLabel1.setText("....");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(welcomeLabel, javax.swing.GroupLayout.DEFAULT_SIZE, 453, Short.MAX_VALUE)
                    .addComponent(listtask)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jLabel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGap(18, 18, 18)
                        .addComponent(logoutButton, javax.swing.GroupLayout.PREFERRED_SIZE, 87, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(welcomeLabel, javax.swing.GroupLayout.PREFERRED_SIZE, 64, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(listtask, javax.swing.GroupLayout.PREFERRED_SIZE, 100, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(logoutButton, javax.swing.GroupLayout.DEFAULT_SIZE, 35, Short.MAX_VALUE)
                    .addComponent(jLabel1))
                .addContainerGap())
        );

        getAccessibleContext().setAccessibleName("frame");

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void logoutButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_logoutButtonActionPerformed
        // TODO add your handling code here:
        try {
            out.close();
            in.close();
            socket.close();
            Tubes5Client loginform = new Tubes5Client();
            loginform.setVisible(true);
            loginform.setFocusable(true);
            loginform.reset();
            this.setVisible(false);
        } catch (IOException e) {
            System.err.println("Problem with the server");
        }
    }//GEN-LAST:event_logoutButtonActionPerformed

    
    
    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(MainFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(MainFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(MainFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(MainFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new MainFrame().setVisible(true);
            }
        });
    }
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel list;
    private javax.swing.JScrollPane listtask;
    private javax.swing.JButton logoutButton;
    private javax.swing.JLabel welcomeLabel;
    // End of variables declaration//GEN-END:variables
}
