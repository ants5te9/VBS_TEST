import sys
from PyQt5.QtWidgets import QDialog, QApplication, QVBoxLayout
from PyQt5.QtCore import QTimer

import matplotlib
matplotlib.use("Qt5Agg")

from matplotlib.backends.backend_qt5agg \
    import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure
import numpy as np

import seaborn as sns
sns.set()


class Main(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)

        fig = Figure(figsize=(8, 6), dpi=80)

        axes = fig.add_subplot(111)
        self.axes = axes

        axes.set_xlabel("x")
        axes.set_ylabel("y")

        self.xmax = 0.

        x  = np.arange(0, self.xmax, 0.1)
        y  = np.sin(x)
        self.lines, = axes.plot(x, y, "o")

        canvas = FigureCanvas(fig)
        self.canvas = canvas

        layout = QVBoxLayout()
        layout.addWidget(canvas)

        self.setLayout(layout)

        self.timer = QTimer(self)
        self.timer.timeout.connect(self.updatePlot)
        self.timer.start(100) # msec

        self.setWindowTitle("plot_anime")
        self.show()

    def updatePlot(self):
        self.xmax += 0.1
        x  = np.arange(0, self.xmax, 0.1)
        y  = np.sin(x)
        self.lines.set_data(x, y)
        self.axes.relim()
        self.axes.autoscale_view()
        self.canvas.draw()


if __name__ == "__main__":
    app = QApplication(sys.argv)
    win = Main()
    sys.exit(app.exec_())
