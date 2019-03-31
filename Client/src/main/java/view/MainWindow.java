package view;

import com.google.common.collect.ImmutableList;
import com.teamdev.jxbrowser.chromium.Browser;
import com.teamdev.jxbrowser.chromium.JSFunctionCallback;
import com.teamdev.jxbrowser.chromium.JSValue;
import com.teamdev.jxbrowser.chromium.events.ConsoleEvent;
import com.teamdev.jxbrowser.chromium.events.ConsoleListener;
import com.teamdev.jxbrowser.chromium.events.ScriptContextAdapter;
import com.teamdev.jxbrowser.chromium.events.ScriptContextEvent;
import com.teamdev.jxbrowser.chromium.events.ScriptContextListener;
import com.teamdev.jxbrowser.chromium.swing.BrowserView;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.thrift.transport.TTransportException;

import javax.swing.JFrame;
import javax.swing.WindowConstants;
import java.awt.BorderLayout;


public class MainWindow {

    public MainWindow() throws TTransportException {

        Browser browser = new Browser();
        BrowserView view = new BrowserView(browser);

        JFrame frame = new JFrame("VBManualService");
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.add(view, BorderLayout.CENTER);
        frame.setSize(1920, 1080);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);

        browser.addScriptContextListener(new ScriptContextListenerImpl());

        browser.addConsoleListener(new ConsoleListenerImpl());

        browser.loadURL("file://C:/Users/a4tec/IdeaProjects/VBManualWebService/Client/src/main/resources/index.html");

    }

}
