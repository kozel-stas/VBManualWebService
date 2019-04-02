package view;

import com.teamdev.jxbrowser.chromium.Browser;
import com.teamdev.jxbrowser.chromium.BrowserType;
import com.teamdev.jxbrowser.chromium.ProtocolHandler;
import com.teamdev.jxbrowser.chromium.URLRequest;
import com.teamdev.jxbrowser.chromium.URLResponse;
import com.teamdev.jxbrowser.chromium.swing.BrowserView;
import org.apache.thrift.transport.TTransportException;

import javax.swing.JFrame;
import javax.swing.WindowConstants;
import java.awt.BorderLayout;
import java.io.DataInputStream;
import java.io.InputStream;
import java.net.URL;
import java.rmi.RemoteException;


public class MainWindow {

    public MainWindow() throws TTransportException, RemoteException {

        Browser browser = new Browser(BrowserType.HEAVYWEIGHT);
        BrowserView view = new BrowserView(browser);

        JFrame frame = new JFrame("VBManualService");
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.add(view, BorderLayout.CENTER);
        frame.setSize(1920, 1080);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);

        browser.addScriptContextListener(new ScriptContextListenerImpl());

        browser.addConsoleListener(new ConsoleListenerImpl());

        browser.getContext().getProtocolService().setProtocolHandler("jar", new ProtocolHandlerImpl());

        browser.loadURL(getClass().getResource("/index.html").toString());

    }

}
