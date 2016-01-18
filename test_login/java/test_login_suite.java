import junit.framework.Test;
import junit.framework.TestSuite;

public class Test_login_suite {

  public static Test suite() {
    TestSuite suite = new TestSuite();
    suite.addTestSuite(test_login_password_empty.class);
    suite.addTestSuite(test_login_correct_email_and_password.class);
    suite.addTestSuite(test_login_correct_email_incorrect_password.class);
    suite.addTestSuite(test_login_email_empty.class);
    suite.addTestSuite(test_login_empty_form.class);
    suite.addTestSuite(test_login_fake_email.class);
    return suite;
  }

  public static void main(String[] args) {
    junit.textui.TestRunner.run(suite());
  }
}
