import sys
from PyQt5.QtWidgets import QDialog, QApplication
from PyQt5.QtWidgets import QVBoxLayout
from PyQt5.QtWidgets import QTreeView, QFileSystemModel
from PyQt5.QtCore import QDir


class Main(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)

        model = QFileSystemModel()
        index = model.setRootPath(QDir.currentPath())

        tree_view = QTreeView()
        tree_view.setModel(model)
        tree_view.setRootIndex(index)

        layout = QVBoxLayout()
        layout.addWidget(tree_view)
        self.setLayout(layout)

        self.setWindowTitle("filesystem")
        self.resize(640, 480)
        self.show()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    win = Main()
    sys.exit(app.exec_())
