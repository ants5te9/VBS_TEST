from PyQt5 import QtCore, QtGui, QtWidgets

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(460, 275)
        self.centralwidget = QtWidgets.QWidget(MainWindow)              #全体のコンテナを作る
        self.centralwidget.setObjectName("centralwidget")
        self.pushButton = QtWidgets.QPushButton(self.centralwidget)     #ボタンを作り
        self.pushButton.setGeometry(QtCore.QRect(160, 50, 131, 41))     #位置とサイズ設定
        font = QtGui.QFont()                                            #フォントを作り
        font.setPointSize(10)
        font.setBold(True)
        font.setWeight(75)
        self.pushButton.setFont(font)                                   #ボタンに設定
        self.pushButton.setObjectName("pushButton")
        self.label = QtWidgets.QLabel(self.centralwidget)               #ラベルを作って
        self.label.setGeometry(QtCore.QRect(100, 140, 271, 41))         #位置とサイズ設定
        font = QtGui.QFont()                                            #またフォントを作り
        font.setFamily("メイリオ")
        font.setPointSize(10)
        self.label.setFont(font)                                        #ラベルに設定
        self.label.setObjectName("label")
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtWidgets.QMenuBar(MainWindow)                   #その他メニューとか
        self.menubar.setGeometry(QtCore.QRect(0, 0, 460, 21))
        self.menubar.setObjectName("menubar")
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)               #ステータスバーなども
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)
    
    #表示するテキストは多国語対応のためかこうやって一括に
    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow"))
        self.pushButton.setText(_translate("MainWindow", "押すな"))
        self.label.setText(_translate("MainWindow", "はろーわーるどっ！"))
