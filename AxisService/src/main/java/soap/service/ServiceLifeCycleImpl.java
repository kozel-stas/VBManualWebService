package soap.service;

import core.config.ConfigConstants;
import org.apache.axis2.context.ConfigurationContext;
import org.apache.axis2.description.AxisService;
import org.apache.axis2.engine.ServiceLifeCycle;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.LoggerContext;
import org.apache.logging.log4j.core.appender.ConsoleAppender;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.util.Properties;

public class ServiceLifeCycleImpl implements ServiceLifeCycle {

    @Override
    public void startUp(ConfigurationContext configurationContext, AxisService axisService) {
        configureLogger(axisService);
        configureServer(axisService);
    }

    private void configureServer(AxisService axisService) {
        URL url = axisService.getClassLoader().getResource("config.properties");
        if (url != null) {
            try {
                Properties properties = new Properties();
                properties.load(axisService.getClassLoader().getResourceAsStream("config.properties"));
                ConfigConstants.DB_PASSWORD = properties.getProperty("db.password", ConfigConstants.DB_PASSWORD);
                ConfigConstants.DB_LOGIN = properties.getProperty("db.login", ConfigConstants.DB_LOGIN);
                ConfigConstants.DB_URL = properties.getProperty("db.url", ConfigConstants.DB_URL);
            } catch (IOException ignored) {}
        } else {
            LogManager.getLogger(ServiceLifeCycleImpl.class).warn("Settings absent, will use default.");
        }
    }

    private void configureLogger(AxisService axisService) {
        final LoggerContext ctx = (LoggerContext) LogManager.getContext(false);
        URL url = axisService.getClassLoader().getResource("log4j2.xml");
        if (url != null) {
            try {
                ctx.setConfigLocation(url.toURI());
            } catch (URISyntaxException e) {
                e.printStackTrace();
                ctx.getConfiguration().addAppender(new ConsoleAppender.Builder<>().build());
            }
        } else {
            ctx.getConfiguration().addAppender(new ConsoleAppender.Builder<>().build());
        }
        ctx.updateLoggers();
        LogManager.getLogger(ServiceLifeCycleImpl.class).warn("Logger was successfully initialized.");
    }

    @Override
    public void shutDown(ConfigurationContext configurationContext, AxisService axisService) {

    }

}
