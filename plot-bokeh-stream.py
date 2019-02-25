import numpy as np
from functools import partial
from random import random
from random import choice
from threading import Thread
import time

from bokeh.models import ColumnDataSource
from bokeh.plotting import curdoc, figure

from bokeh.layouts import column
from bokeh.models import Button
from bokeh.palettes import RdYlBu3

from bokeh.util.hex import hexbin
from tornado import gen

from bokeh.transform import linear_cmap

fname = "data-array.txt"

# this must only be modified from a Bokeh session callback
source = ColumnDataSource(data=dict(x=[0], y=[0]))

# This is important! Save curdoc() to make sure all threads
# see the same document.
doc = curdoc()


@gen.coroutine
def update(x, y, x_hex, y_hex):
    source.stream(dict(x=[x], y=[y]))
    bin_size = 0.15
    bins = hexbin(x_hex, y_hex, bin_size)
    l_hex = p.hex_tile(
        q="q",
        r="r",
        size=0.1,
        line_color=None,
        source=bins,
        fill_color=linear_cmap("counts", "Viridis256", 0, max(bins.counts)),
    )


x_vec = [1.5, 1.5]
y_vec = [1.5, 1.5]
bins = hexbin(np.array(x_vec), np.array(y_vec), 0.1)


def blocking_task():
    while True:
        try:
        # try:
            with open(fname) as fn:
                data = fn.readline()
            X = np.array(eval(data))
            # do some blocking computation
            time.sleep(0.01)
            # for loop -----------
            # make a loop to plot all the data in the data-array.txt and not random selection of data
            x, y = choice(X[:, 0]), choice(X[:, 1]) # input a list here to plot <<-------
            print("x:", x, "y:", y)
            # but update the document from callback
            x_vec.append(x)
            y_vec.append(y)
            # end loop ------------
            doc.add_next_tick_callback(
                partial(update, x=x, y=y, x_hex=np.array(x_vec), y_hex=np.array(y_vec))
            )
        except:
            print('Did not update!!')
            pass


p = figure(
    toolbar_location=None,
    plot_width=800,
    plot_height=600,
)
p.border_fill_color = "black"
p.background_fill_color = "black"
p.outline_line_color = None
p.grid.grid_line_color = None

l = p.hex_tile(
    q="q",
    r="r",
    size=0.1,
    line_color=None,
    source=bins,
    fill_color=linear_cmap("counts", "Viridis256", 0, max(bins.counts)),
)

doc.add_root(p)

thread = Thread(target=blocking_task)
thread.start()
