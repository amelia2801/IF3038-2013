/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.dao;

/**
 *
 * @author Rian
 */
public class UserDAO {
    public int addUser(User user) {
        vm.soap.user.UserSoap_Service service = new vm.soap.user.UserSoap_Service();
        vm.soap.user.UserSoap port = service.getUserSoapPort();
        return port.addUser(user.toJsonObject().toString());
    }
}
