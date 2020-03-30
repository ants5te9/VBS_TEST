import sys
from PyQt5.QtWidgets import QDialog, QApplication
from PyQt5.QtWidgets import QTableWidget, QTableWidgetItem
from PyQt5.QtWidgets import QPushButton, QVBoxLayout


class Main(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)

        table = QTableWidget(2, 3)
        self.table = table

        header = ["A", "B", "C"]
        data = [["apple", "1", "100"], ["banana", "2", "200"]]

        table.setHorizontalHeaderLabels(header)

        for i in range(len(data)):
            for j in range(len(data[i])):
                table.setItem(i, j, QTableWidgetItem(data[i][j]))

        button = QPushButton("Check")
        button.clicked.connect(self.buttonClicked)

        layout = QVBoxLayout()
        layout.addWidget(table)
        layout.addWidget(button)

        self.setLayout(layout)

        self.setWindowTitle("table")
        self.show()

    def buttonClicked(self):
        for i in range(self.table.rowCount()):
            for j in range(self.table.columnCount()):
                print(self.table.item(i, j).text(), end=" ")
            print()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    win = Main()
    sys.exit(app.exec_())
