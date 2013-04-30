/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.dao;

import vm.model.Category;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;

/**
 *
 * @author Rian
 */
public class CategoryDAO extends DataAccessObject {
    public int addCategory(int idcategory, String namecategory, String username, Date datecreated) {
        try {
            PreparedStatement preparedStatement = conn.prepareStatement("INSERT INTO 'category'('categoryid','categoryname','username','createddate') VALUES (?,?,?,?);");
            preparedStatement.setInt(1, idcategory);
            preparedStatement.setString(2, namecategory);
            preparedStatement.setString(3, username);
            preparedStatement.setDate(4, datecreated);
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }
}
