import org.apache.thrift.transport.TTransportException;
import view.MainWindow;

import java.rmi.RemoteException;

public class Main {

    public static void main (String [] args) throws TTransportException, RemoteException {
        new MainWindow();
    }

}
