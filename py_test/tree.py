import sys
from PyQt5.QtWidgets import QDialog, QApplication
from PyQt5.QtWidgets import QTreeWidget, QTreeWidgetItem
from PyQt5.QtWidgets import QPushButton, QVBoxLayout
from PyQt5.QtCore import Qt


class Main(QDialog):
    def __init__(self, parent=None):
        super(Main, self).__init__(parent)

        tree_widget = QTreeWidget()
        self.tree_widget = tree_widget
        tree_widget.setAlternatingRowColors(True)

        branch1 = QTreeWidgetItem()
        branch1.setText(0, "branch1")

        branch2 = QTreeWidgetItem()
        branch2.setText(0,"branch2")

        def addItem(branch, name, num, num2):
            item = QTreeWidgetItem(branch)
            item.setFlags(item.flags() | Qt.ItemIsEditable)
            item.setText(0, name)
            item.setText(1, str(num))
            item.setText(2, str(num2))

        addItem(branch1, "apple", 1, 100)
        addItem(branch1, "banana", 2, 200)
        addItem(branch2, "lemon", 3, 300)
        addItem(branch2, "orange", 4, 400)

        tree_widget.addTopLevelItem(branch1)
        tree_widget.addTopLevelItem(branch2)

        tree_widget.setColumnCount(3)
        tree_widget.setHeaderLabels(["A", "B", "C"])

        branch1.setExpanded(True)
        branch2.setExpanded(True)

        button = QPushButton("Check")
        button.clicked.connect(self.buttonClicked)

        layout = QVBoxLayout()
        layout.addWidget(tree_widget)
        layout.addWidget(button)

        self.setLayout(layout)

        self.setWindowTitle("tree")
        self.show()

    def buttonClicked(self):
        for i in range(self.tree_widget.topLevelItemCount()):
            branch = self.tree_widget.topLevelItem(i)
            print(branch.text(0))
            for j in range(branch.childCount()):
                item = branch.child(j)
                print("  ")
                for k in range(item.columnCount()):
                    print(item.text(k))
                print("")

        print("find: lemon")
        items = self.tree_widget.findItems("lemon", Qt.MatchRecursive)
        item = items[0]
        print("  ")
        for k in range(item.columnCount()):
            print(item.text(k))
        print("")


if __name__ == "__main__":
    app = QApplication(sys.argv)
    win = Main()
    sys.exit(app.exec_())
 