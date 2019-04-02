package view;

import com.teamdev.jxbrowser.chromium.ProtocolHandler;
import com.teamdev.jxbrowser.chromium.URLRequest;
import com.teamdev.jxbrowser.chromium.URLResponse;

import java.io.DataInputStream;
import java.io.InputStream;
import java.net.URL;

public class ProtocolHandlerImpl implements ProtocolHandler {
    @Override
    public URLResponse onRequest(URLRequest urlRequest) {
        try {
            URLResponse response = new URLResponse();
            URL path = new URL(urlRequest.getURL());
            InputStream inputStream = path.openStream();
            DataInputStream stream = new DataInputStream(inputStream);
            byte[] data = new byte[stream.available()];
            stream.readFully(data);
            response.setData(data);
            String mimeType = getMimeType(path.toString());
            response.getHeaders().setHeader("Content-Type", mimeType);
            return response;
        } catch (Exception ignored) {

        }
        return null;
    }

    private static String getMimeType(String path) {
        if (path.endsWith(".html")) {
            return "text/html";
        }
        if (path.endsWith(".css")) {
            return "text/css";
        }
        if (path.endsWith(".js")) {
            return "text/javascript";
        }
        return "text/html";
    }
}
