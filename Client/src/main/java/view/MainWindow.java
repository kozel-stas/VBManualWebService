package view;

import com.teamdev.jxbrowser.chromium.Browser;
import com.teamdev.jxbrowser.chromium.swing.BrowserView;
import org.apache.thrift.transport.TTransportException;

import javax.swing.JFrame;
import javax.swing.WindowConstants;
import java.awt.BorderLayout;
import java.rmi.RemoteException;


public class MainWindow {

    public MainWindow() throws TTransportException, RemoteException {

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
