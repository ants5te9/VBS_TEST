import sys

from PyQt5 import QtCore, QtGui
from PyQt5.QtGui import QFont
from PyQt5.QtWidgets import QApplication, QWidget, QGridLayout, QLabel, QSizePolicy, QPushButton, QMessageBox


class Widget(QWidget):
    def __init__(self):
        super(Widget,self).__init__()
        self.setMyself()
        self.show()

    def setMyself(self):
        self.setGeometry(300,300,250,150)
        self.setWindowTitle('Close this Widget')
        btn1 = QPushButton("Button 1", self)
        btn1.move(30, 10)
        btn1.clicked.connect(self.myClose)

    def myClose(self,event):
        confirmObject = QMessageBox.question(self,'Message',
        'Are you sure to quit?',QMessageBox.Yes |
        QMessageBox.No,QMessageBox.No)

        if confirmObject == QMessageBox.Yes:
            event.accept()
        else:
            event.ignore()

def main():
    app = QApplication(sys.argv)
    ex = Widget()
    sys.exit(app.exec_())

if __name__ == '__main__':
    main()
