package config;

public class Configs {

    private static final String SOAP_URL = "http://localhost/axis2/services/VBManualSOAPService";
    private static final String KEY_SOAP_URL = "soap.url";

    private static final String RPC_URL = "localhost";
    private static final String KEY_RPC_URL = "rpc.url";

    private static final int RPC_PORT = 9090;
    private static final String KEY_RPC_PORT = "rpc.port";

    public static String getSoapUrl() {
        String systemPr = System.getProperty(KEY_SOAP_URL);
        if (systemPr == null || systemPr.isEmpty()) {
            return SOAP_URL;
        }
        return systemPr;
    }

    public static String getRpcUrl() {
        String systemPr = System.getProperty(KEY_RPC_URL);
        if (systemPr == null || systemPr.isEmpty()) {
            return RPC_URL;
        }
        return systemPr;
    }

    public static int getRpcPort() {
        String systemPr = System.getProperty(KEY_RPC_PORT);
        if (systemPr == null || systemPr.isEmpty() || !isValidNumber(systemPr)) {
            return RPC_PORT;
        }
        return Integer.valueOf(systemPr);
    }

    private static boolean isValidNumber(String num) {
        try {
            Integer.valueOf(num);
            return true;
        } catch (NumberFormatException ignored) {

        }
        return false;
    }


}
