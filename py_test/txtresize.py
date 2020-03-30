#! /usr/bin/python3
# -*- coding: utf-8 -*-

from PyQt5 import QtCore
from PyQt5.QtGui import QFont
from PyQt5.QtWidgets import QApplication, QWidget, QGridLayout, QLabel, QSizePolicy

import sys

class QCustomLabel(QLabel):
    def __init__(self, text):
        super(QCustomLabel, self).__init__(text)
        self._font = QFont()
        self.setFont(self._font)
        self.setAlignment(QtCore.Qt.AlignVCenter | QtCore.Qt.AlignHCenter)
        self.setSizePolicy(QSizePolicy.Ignored, QSizePolicy.Ignored)
        self._fontScale = 1.0

    def setFontFamily(self, face):
        self._font.setFamily(face)

    def setFontScale(self, scale):
        self._fontScale = scale

    def resizeEvent(self, evt):
        width = self.size().width() / len(self.text())
        height = self.size().height()
        baseSize = 0
        if width > height:
            baseSize = height
        else:
            baseSize = width

        self._font.setPixelSize(baseSize * self._fontScale)
        self.setFont(self._font)


if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = QWidget()

    style = 'QWidget{background-color:#1976D2;} QLabel{color:#FFFFFF; background-color:#2196F3; border-color:#FF9800;}'
    app.setStyleSheet(style)

    layout = QGridLayout()
    layout.setContentsMargins(5, 5, 5, 5)

    labelA = QCustomLabel('あ')
    labelA.setFontFamily('源ノ角ゴシック Code JP M')
    layout.addWidget(labelA, 0, 0)

    labelB = QCustomLabel('あ')
    labelB.setFontFamily('源ノ角ゴシック Code JP M')
    labelB.setFontScale(2)
    layout.addWidget(labelB, 0, 1)

    window.setLayout(layout)
    window.resize(300, 200)
    window.show()
    sys.exit(app.exec_())
