/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.bb;

import java.sql.Connection;
import vm.util.DbUtil;

/**
 *
 * @author User
 */
public abstract class DataAccessObject {
    protected Connection conn;
    
    public DataAccessObject(){
        conn = DbUtil.getConnection();
    }
}
