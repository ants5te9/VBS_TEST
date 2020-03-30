# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file '.\guiSample1.ui'
#
# Created by: PyQt5 UI code generator 5.6
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

class Ui_Form(object):
    def setupUi(self, Form):
        Form.setObjectName("Form")
        Form.resize(538, 437)
        self.splitter_4 = QtWidgets.QSplitter(Form)
        self.splitter_4.setGeometry(QtCore.QRect(10, 20, 518, 407))
        self.splitter_4.setOrientation(QtCore.Qt.Vertical)
        self.splitter_4.setObjectName("splitter_4")
        self.splitter_2 = QtWidgets.QSplitter(self.splitter_4)
        self.splitter_2.setOrientation(QtCore.Qt.Horizontal)
        self.splitter_2.setObjectName("splitter_2")
        self.listView = QtWidgets.QListView(self.splitter_2)
        self.listView.setObjectName("listView")
        self.splitter = QtWidgets.QSplitter(self.splitter_2)
        self.splitter.setOrientation(QtCore.Qt.Vertical)
        self.splitter.setObjectName("splitter")
        self.listView_2 = QtWidgets.QListView(self.splitter)
        self.listView_2.setObjectName("listView_2")
        self.tableView = QtWidgets.QTableView(self.splitter)
        self.tableView.setObjectName("tableView")
        self.splitter_3 = QtWidgets.QSplitter(self.splitter_4)
        self.splitter_3.setOrientation(QtCore.Qt.Horizontal)
        self.splitter_3.setObjectName("splitter_3")
        self.pushButton = QtWidgets.QPushButton(self.splitter_3)
        self.pushButton.setObjectName("pushButton")
        self.pushButton_2 = QtWidgets.QPushButton(self.splitter_3)
        self.pushButton_2.setObjectName("pushButton_2")

        self.retranslateUi(Form)
        QtCore.QMetaObject.connectSlotsByName(Form)

    def retranslateUi(self, Form):
        _translate = QtCore.QCoreApplication.translate
        Form.setWindowTitle(_translate("Form", "Form"))
        self.pushButton.setText(_translate("Form", "Open"))
        self.pushButton_2.setText(_translate("Form", "Close"))

