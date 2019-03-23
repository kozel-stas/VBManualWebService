package view;

import org.eclipse.swt.SWT;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.graphics.Point;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.widgets.*;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class MainWindow {
    private static final int HEIGHT = 1000;
    private static final int WIDTH = 1517;
    private Display display;
    private Shell shell;

    public MainWindow() {
        display = new Display();
        shell = new Shell(display, SWT.TITLE | SWT.CLOSE);
        shell.setModified(false);
        shell.setSize(WIDTH, HEIGHT);
        centerWindow();
        new Shell(display).open();
        while (!shell.isDisposed()) {
            if (!display.readAndDispatch()) {
                display.sleep();
            }
        }
        display.dispose();
    }

    private void centerWindow() {
        Rectangle rectangle = shell.getDisplay().getBounds();
        Point p = shell.getSize();
        int nLeft = (rectangle.width - p.x) / 2;
        int nTop = (rectangle.height - p.y) / 2;
        shell.setBounds(nLeft, nTop, p.x, p.y);
    }

}
