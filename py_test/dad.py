#!/usr/bin/python3
# -*- coding: utf-8 -*-


import sys
from PyQt5.QtWidgets import (QPushButton, QWidget, 
    QLineEdit, QApplication)

# QPushButtonを継承
class Button(QPushButton):

    def __init__(self, title, parent):
        super(Button, self).__init__(title, parent)

        # ボタンに対してドロップ操作を可能にする
        self.setAcceptDrops(True)


    def dragEnterEvent(self, e):

        # ドラッグ可能なデータ形式を設定
        if e.mimeData().hasFormat('text/plain'):
            e.accept()
        else:
            e.ignore() 

    def dropEvent(self, e):

        # ドロップしたときにボタンラベルを入れ替える
        self.setText(e.mimeData().text()) 


class Example(QWidget):

    def __init__(self):
        super(Example, self).__init__()

        self.initUI()


    def initUI(self):

        edit = QLineEdit('', self)
        # ドラッグ可能にする
        edit.setDragEnabled(True)
        edit.move(30, 65)

        button = Button("Button", self)
        button.move(250, 65)

        self.setWindowTitle('Simple drag & drop')
        self.setGeometry(300, 300, 300, 150)


if __name__ == '__main__':

    app = QApplication(sys.argv)
    ex = Example()
    ex.show()
    app.exec_()
