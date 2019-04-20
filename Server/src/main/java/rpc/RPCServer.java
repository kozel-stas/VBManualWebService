package rpc;

import core.config.ConfigConstants;
import core.services.DataLoader;
import core.services.VBManualManager;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.thrift.server.TServer;
import org.apache.thrift.server.TSimpleServer;
import org.apache.thrift.transport.TServerSocket;
import org.apache.thrift.transport.TServerTransport;
import org.apache.thrift.transport.TTransportException;
import rpc.service.VBManualProcessorImpl;
import rpc.service.gen.VBManualService;

public class RPCServer {

    private final Logger LOG = LogManager.getLogger(RPCServer.class);

    private final DataLoader dataLoader;
    private final VBManualManager vbManualManager;

    private Thread currentThread;
    private TServerTransport serverTransport;
    private TServer server;

    public RPCServer(DataLoader dataLoader, VBManualManager vbManualManager) {
        this.dataLoader = dataLoader;
        this.vbManualManager = vbManualManager;
    }

    public synchronized void startServerAsync() {
        if (currentThread == null) {
            currentThread = new Thread(() -> {
                startServer(new VBManualService.Processor<>(new VBManualProcessorImpl(vbManualManager, dataLoader)));
            });
            currentThread.start();
        } else {
            LOG.info("Server is already started.");
        }
    }

    public synchronized void stopServer() {
        if (currentThread == null || server == null || serverTransport == null) {
            LOG.info("Server is already stopped.");
        } else {
            server.stop();
            serverTransport.interrupt();
            serverTransport.close();
            currentThread.interrupt();
            currentThread = null;
        }
    }


    /**
     * @param processor class that works with all RPC requests.
     */
    private void startServer(VBManualService.Processor<VBManualService.Iface> processor) {
        try {
            serverTransport = new TServerSocket(ConfigConstants.RPC_PORT);
            server = new TSimpleServer(new TServer.Args(serverTransport).processor(processor));
            LOG.info("Starting RPC server ...");
            server.serve();
        } catch (TTransportException ex) {
            LOG.fatal("RPC server isn't started. ", ex);
        }
    }

}
