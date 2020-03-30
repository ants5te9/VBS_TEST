# -*- coding: utf-8 -*-
import sys
from PyQt5 import QtCore as Qc, QtGui as Qg, QtWidgets as Qw    #（補足1）
from PyQt5.QtCore import Qt

import guiSample1                               #デザイナーで作った画面をインポートする

class MyForm(Qw.QMainWindow):               #MyFormという名前でQMainWindowのサブクラス作成

    def __init__(self, parent=None):        #クラスの初期化

        super().__init__(parent)            #上位クラスの初期化ルーチンを呼び出す（補足2）
        self.ui = guiSample1.Ui_Form()     #先ほど作ったhello.pyの中にあるクラスの
        self.ui.setupUi(self)               #このコマンドを実行する

if __name__ == '__main__':

    app = Qw.QApplication(sys.argv)         #パラメータは正しくはコマンドライン引数を与える
    wmain = MyForm()                        #MyFormのインスタンスを作って
    wmain.show()                            #表示する
    sys.exit(app.exec())                    #こうやって終了コードを渡して抜けるのが礼儀
