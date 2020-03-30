import sys
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QPainter
from PyQt5.QtWidgets import QApplication, QWidget

class MainWindow(QWidget):
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.setWindowTitle("This is a pyqt sample")
        self.setGeometry(0, 0, 300, 200)
    
    def paintEvent(self, event):
        p = QPainter(self)
        p.setPen(Qt.red)
        p.setBrush(Qt.yellow)
        p.drawRect(10, 10, 20, 50)
        
        #cb = p.QPushButton('Close', self)
        #cb.setGeometry(10, 10, 60, 35)
        #cb.clicked.connect(QtGui.qApp.quit)

app = QApplication(sys.argv)
mainWindow = MainWindow()
mainWindow.show()
sys.exit(app.exec_())
