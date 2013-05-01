/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package vm.model;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;

import org.json.JSONModel;
import org.json.JSONObject;

/**
 *
 * @author Rian
 */
public class User extends JSONModel {
    private String username;
    private String password;
    private String fullname;
    private Date birthday;
    private String email;
    private Date join;
    private String aboutme;
    private String avatar;
    
    public String getUsername(){
        return username;
    }
    
    public String getPassword(){
        return password;
    }
    
    public String getFullname(){
        return fullname;
    }
    
    public Date getBirthday(){
        return birthday;
    }
    
    public String getEmail(){
        return email;
    }
    
    public Date getJoin(){
        return join;
    }
    
    public String getAboutme(){
        return aboutme;
    }
    
    public String getAvatar(){
        return avatar;
    }
    
    @Override
    public JSONObject toJsonObject() {
        JSONObject jObject = new JSONObject();

        jObject.put("username", username);
        jObject.put("password", password);
        jObject.put("fullname", fullname);
        jObject.put("birthday", birthday);
        jObject.put("email", email);
        jObject.put("join", join);
        jObject.put("aboutme",aboutme);
        jObject.put("avatar", avatar);

        return jObject;
    }

    @Override
    public void fromJsonObject(JSONObject jObject) {
        this.username = jObject.getString("username");
        this.password = jObject.getString("password");
        this.fullname = jObject.getString("fullname");
        this.birthday = java.sql.Date.valueOf(jObject.getString("birthday"));
        this.email = jObject.getString("email");
        this.join = java.sql.Date.valueOf(jObject.getString("join"));
        this.aboutme = jObject.getString("aboutme");
        this.avatar = jObject.getString("avatar");
    }
}
