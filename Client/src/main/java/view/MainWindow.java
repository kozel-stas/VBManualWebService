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
import model.Topic;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.thrift.transport.TTransportException;
import services.DataProvider;
import services.RPCDataProvider;

import javax.swing.JFrame;
import javax.swing.WindowConstants;
import java.awt.BorderLayout;
import java.util.Collections;
import java.util.stream.Collectors;


public class MainWindow {

    private final static Logger LOG = LogManager.getLogger(MainWindow.class);

    private final DataProvider dataProvider;

    public MainWindow() throws TTransportException {
        dataProvider = new RPCDataProvider();

        Browser browser = new Browser();
        BrowserView view = new BrowserView(browser);

        JFrame frame = new JFrame("JxBrowser - Hello World");
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.add(view, BorderLayout.CENTER);
        frame.setSize(1920, 1080);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);

        browser.addScriptContextListener(new ScriptContextAdapter() {
            @Override
            public void onScriptContextCreated(ScriptContextEvent event) {
                Browser browser = event.getBrowser();
                JSValue window = browser.executeJavaScriptAndReturnValue("window");
                window.asObject().setProperty("getTopics", (JSFunctionCallback) args -> {
                    try {
                        return dataProvider.getTopics();
                    } catch (Exception e) {
                        LOG.error(e);
                    }
                    return Collections.emptyList();
                });
                window.asObject().setProperty("getArticles", (JSFunctionCallback) args -> {
                    try {
                        return dataProvider.getArticles((String) args[0]);
                    } catch (Exception e) {
                        LOG.error(e);
                    }
                    return Collections.emptyList();
                });
                window.asObject().setProperty("getTopic", (JSFunctionCallback) args -> {
                    try {
                        String id = (String) args[0];
                        return dataProvider.getTopics().stream().filter(val -> val.getId().equals(id)).collect(Collectors.toList()).get(0);
                    } catch (Exception e) {
                        LOG.error(e);
                    }
                    return Collections.emptyList();
                });
            }
        });

        browser.addConsoleListener(LOG::error);

        browser.loadURL("file://C:/Users/a4tec/IdeaProjects/VBManualWebService/Client/src/main/resources/index.html");

    }

}
