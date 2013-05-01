package Class;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.util.Properties;

public class ProxyUtil {
    
    private static Proxy proxy = null;
    
    public static final String CURCONNECTION = "http://localhost:9999/ServerService";
    
    public static Proxy getProxy() {
        try {
            Properties prop = new Properties();
            InputStream inputStream = ProxyUtil.class.getClassLoader().getResourceAsStream("/proxy.properties");
            prop.load(inputStream);
            
            String type = prop.getProperty("type");
            if ("DIRECT".equalsIgnoreCase(type)) {
                proxy = Proxy.NO_PROXY;
            } else {
                String hostname = prop.getProperty("hostname");
                int port = Integer.parseInt(prop.getProperty("port"));
                
                if ("HTTP".equalsIgnoreCase(type)) {
                    proxy = new Proxy(Proxy.Type.HTTP, new InetSocketAddress(hostname, port));
                } else if ("SOCKS".equalsIgnoreCase(type)) {
                    proxy = new Proxy(Proxy.Type.SOCKS, new InetSocketAddress(hostname, port));                    
                } else {
                    proxy = Proxy.NO_PROXY;
                    throw new IllegalArgumentException("Type doesn't supported, using direct proxy.");
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        return proxy;
    }
    
    public static String convertStreamToString( InputStream is) throws IOException
    {
        StringBuilder sb = new StringBuilder( Math.max( 16, is.available() ) );
        char[] tmp = new char[ 4096 ];

        try {
           InputStreamReader reader = new InputStreamReader( is);
           for( int cnt; ( cnt = reader.read( tmp ) ) > 0; ) {
                sb.append( tmp, 0, cnt );
            }
        } finally {
            is.close();
        }
        return sb.toString();
    }
}
