/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.soap;

import vm.dao.UserDAO;
import vm.model.User;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import org.json.JSONObject;
import org.json.JSONTokener;

/**
 *
 * @author Rian
 */
@WebService(serviceName= "UserSoap")
public class UserSoap {
    
    @WebMethod(operationName="addUser")
    public int addUser(@WebParam(name = "addUser") String jsonUser) {
        User user = new User();
        user.fromJsonObject(new JSONObject(new JSONTokener(jsonUser)));
        UserDAO userDao = new UserDAO();
        return userDao.addUser(user);
    }
}
