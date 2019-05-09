package view;

import com.teamdev.jxbrowser.chromium.Browser;
import com.teamdev.jxbrowser.chromium.BrowserContext;
import com.teamdev.jxbrowser.chromium.BrowserContextParams;
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
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.FileSystems;
import java.nio.file.WatchService;
import java.rmi.RemoteException;
import java.util.concurrent.TimeUnit;


public class MainWindow {

    public MainWindow() {
        Browser browser = new Browser(BrowserType.HEAVYWEIGHT, new BrowserContext(new BrowserContextParams("/home/kozel-stas/" + System.getProperty("id", "1"))));
        BrowserView view = new BrowserView(browser);

        JFrame frame = new JFrame("VBManualService");
        frame.add(view, BorderLayout.CENTER);
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.setSize(1920, 1080);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);

        browser.addScriptContextListener(new ScriptContextListenerImpl(browser));

        browser.addConsoleListener(new ConsoleListenerImpl());

        browser.getContext().getProtocolService().setProtocolHandler("jar", new ProtocolHandlerImpl());

        browser.loadURL(getClass().getResource("/index.html").toString());

    }

}
