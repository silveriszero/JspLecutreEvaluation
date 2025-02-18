package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class NaverMail extends Authenticator {
	@Override 
	protected PasswordAuthentication getPasswordAuthentication() {
		final String username ="eunyoun0519@naver.com";
		final  String appPassword = "Q49B31KFGYE1";
		return new PasswordAuthentication(username,appPassword);
	}
}
