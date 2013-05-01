/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.dao;

import vm.model.User;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Rian
 */
public class UserDAO extends DataAccessObject {
    public int addUser(User user) {
        try {
            PreparedStatement preparedStatement = conn.prepareStatement("INSERT INTO 'user'('username','password','fullname','birthday','email','join','aboutme','avatar') VALUES  (?,?,?,?,?,?,?,?);");
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getFullname());
            preparedStatement.setDate(4, user.getBirthday());
            preparedStatement.setString(5, user.getEmail());
            preparedStatement.setDate(6, user.getJoin());
            preparedStatement.setString(7, user.getAboutme());
            preparedStatement.setString(8, user.getAvatar());
            return preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }
}
