package view;

import com.teamdev.jxbrowser.chromium.Browser;

public class ErrorListener {

    private final Browser browser;

    public ErrorListener(Browser browser) {
        this.browser = browser;
    }

    public void translateExceptionToUI(String message) {
        browser.executeJavaScript("alert(\"" + message + "\");");
    }

}
