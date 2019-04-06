package view;

import com.teamdev.jxbrowser.chromium.Browser;
import com.teamdev.jxbrowser.chromium.JSFunctionCallback;
import com.teamdev.jxbrowser.chromium.JSValue;
import com.teamdev.jxbrowser.chromium.events.ScriptContextEvent;
import com.teamdev.jxbrowser.chromium.events.ScriptContextListener;
import model.Article;
import model.Author;
import model.Topic;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.thrift.transport.TTransportException;
import services.DataProvider;
import services.RESTDataProvider;
import services.RPCDataProvider;
import services.SOAPDataProvider;

import java.rmi.RemoteException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.stream.Collectors;

public class ScriptContextListenerImpl implements ScriptContextListener {

    private final static Logger LOG = LogManager.getLogger(ScriptContextListenerImpl.class);

    private final Map<String, DataProvider> dataProviders = new HashMap<>();

    private DataProvider dataProvider;
    private ErrorListener errorListener;

    public ScriptContextListenerImpl(Browser browser) {
        dataProviders.put("RPC", new RPCDataProvider());
        dataProviders.put("SOAP", new SOAPDataProvider());
        dataProviders.put("REST", new RESTDataProvider());
        errorListener = new ErrorListener(browser);
        initDataProviders();
    }

    @Override
    public void onScriptContextCreated(ScriptContextEvent event) {
        Browser browser = event.getBrowser();
        JSValue window = browser.executeJavaScriptAndReturnValue("window");
        window.asObject().setProperty("getTopics", (JSFunctionCallback) args -> dataProvider.getTopics());
        window.asObject().setProperty("getArticles", (JSFunctionCallback) args -> dataProvider.getArticles((String) args[0]));
        window.asObject().setProperty("getArticle", (JSFunctionCallback) args -> dataProvider.getArticles((String) args[1]).stream().filter(val -> val.getId().equals(args[0])).collect(Collectors.toList()).get(0));
        window.asObject().setProperty("getTopic", (JSFunctionCallback) args -> dataProvider.getTopics().stream().filter(val -> val.getId().equals(args[0])).collect(Collectors.toList()).get(0));
        window.asObject().setProperty("getAuthors", (JSFunctionCallback) args -> dataProvider.getAuthors());
        window.asObject().setProperty("registerAuthor", (JSFunctionCallback) args -> dataProvider.registerAuthor(new Author("NAN", (String) args[0], (String) args[1], (String) args[2])));
        window.asObject().setProperty("registerDataProvider", (JSFunctionCallback) args -> switchDataProviderOrUseDefault((String) args[0]));
        window.asObject().setProperty("addTopic", (JSFunctionCallback) args -> dataProvider.addTopic(new Topic("NAN", (String) args[0], dataProvider.getAuthors().stream().filter(val -> val.getId().equals(args[1])).collect(Collectors.toList()).get(0))));
        window.asObject().setProperty("addArticle", (JSFunctionCallback) args -> dataProvider.addArticle((String) args[0], new Article("NAN", (String) args[1], (String) args[2], dataProvider.getAuthors().stream().filter(val -> val.getId().equals(args[3])).collect(Collectors.toList()).get(0))));
        window.asObject().setProperty("updateArticle", (JSFunctionCallback) args -> dataProvider.updateArticle((String) args[0], new Article((String) args[1], (String) args[2], (String) args[3], dataProvider.getAuthors().stream().filter(val -> val.getId().equals(args[4])).collect(Collectors.toList()).get(0))));
        window.asObject().setProperty("deleteTopic", (JSFunctionCallback) args -> {
            dataProvider.deleteTopic(dataProvider.getTopics().stream().filter(val -> val.getId().equals(args[0])).collect(Collectors.toList()).get(0));
            return null;
        });
        window.asObject().setProperty("deleteArticle", (JSFunctionCallback) args -> {
            dataProvider.deleteArticle((String) args[0], (String) args[1]);
            return null;
        });
    }

    @Override
    public void onScriptContextDestroyed(ScriptContextEvent scriptContextEvent) {

    }

    private DataProvider switchDataProviderOrUseDefault(String provider) {
        this.dataProvider = dataProviders.getOrDefault(provider, dataProviders.get(dataProvider.toString()));
        LOG.info("DataProvider was switched to {}", dataProvider);
        return this.dataProvider;
    }

    private void initDataProviders() {
        Iterator<DataProvider> iterator = dataProviders.values().iterator();
        while (iterator.hasNext()) {
            DataProvider dataProvider = iterator.next();
            try {
                dataProvider.init(errorListener);
                this.dataProvider = dataProvider;
            } catch (Exception e) {
                iterator.remove();
                errorListener.translateExceptionToUI("DataProvider " + dataProvider + " is unavailable.");
                LOG.error("Exception during initialization " + dataProvider, e);
            }
        }
        if (this.dataProvider == null && dataProviders.isEmpty()) {
            throw new RuntimeException("No data providers.");
        }
        LOG.info("DataProvider was switched to {}", dataProvider);
    }
}
