package view;

import com.teamdev.jxbrowser.chromium.events.ConsoleEvent;
import com.teamdev.jxbrowser.chromium.events.ConsoleListener;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class ConsoleListenerImpl implements ConsoleListener {

    private final static Logger LOG = LogManager.getLogger(ConsoleListenerImpl.class);

    @Override
    public void onMessage(ConsoleEvent consoleEvent) {
        switch (consoleEvent.getLevel()) {
            case LOG:
                LOG.info(consoleEvent.getMessage());
                break;
            case DEBUG:
                LOG.debug(consoleEvent);
                break;
            case ERROR:
                LOG.error(consoleEvent);
                break;
            case WARNING:
                LOG.warn(consoleEvent);
                break;
        }
    }

}
