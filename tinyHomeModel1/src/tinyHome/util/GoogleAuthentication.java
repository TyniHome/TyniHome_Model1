package tinyHome.util;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
    
    public GoogleAuthentication(){
        passAuth = new PasswordAuthentication("tinyHomeAD", "home!tiny@ad");
    }
 
    public PasswordAuthentication getPasswordAuthentication() {
        return passAuth;
    }
}
