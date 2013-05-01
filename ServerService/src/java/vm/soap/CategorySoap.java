/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.soap;

import vm.dao.CategoryDAO;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import java.sql.Date;
/**
 *
 * @author Rian
 */

@WebService(serviceName = "CategorySoap")
public class CategorySoap {
    
    @WebMethod(operationName = "addCategory")
    public int addCategory(@WebParam(name = "categoryid") int idcategory, @WebParam(name = "categoryname") String namecategory, @WebParam(name = "username") String username, @WebParam(name = "createddate") Date datecreated){
        CategoryDAO categoryDao = new CategoryDAO();
        return categoryDao.addCategory(idcategory,namecategory,username,datecreated);
    }
    
}
