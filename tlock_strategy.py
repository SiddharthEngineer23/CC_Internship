from __future__ import (absolute_import, division, print_function,
                        unicode_literals)

from datetime import datetime  # For datetime objects
import os.path  # To manage paths
import sys  # To find out the script name (in argv[0])
import math

#check seasonality

#recessionary

#certainty

# Import the backtrader platform
import backtrader as bt
from backtrader.indicators import EMA, SMA
import backtrader.feeds as feed

# Create a Stratey
class MyStrategy(bt.Strategy):

    def log(self, txt, dt=None):
        ''' Logging function not this strategy'''
        dt = dt or self.datas[0].datetime.date(0)
        print('%s, %s' % (dt.isoformat(), txt))
    
    def __init__(self):
        self.dataclose = self.datas[0].close
        self.ema = EMA(self.dataclose, period=30)
        #self.crossover = bt.ind.CrossOver(self.ema, self.dataclose)

    def next(self):

        if (self.ema[0] - self.dataclose[0]) > 0.6:
            # self.log('BUY CREATE, %.2f' % self.dataclose[0])
            # self.log('Close, %.2f' % self.dataclose[0])
            # self.log('EMA, %.2f' % self.ema[0])
            self.log('Difference, %.2f' % (self.ema[0] - self.dataclose[0]))

            order = self.buy()

if __name__ == '__main__':
    cerebro = bt.Cerebro(stdstats=False)
    cerebro.addstrategy(MyStrategy)

    data = feed.GenericCSVData(
        dataname = 'C:/Users/ME/Documents/Project I/treasury.csv',

        # fromdate = datetime(2007, 1, 1),
        # todate = datetime(2012, 1, 1),

        nullvalue = float('NaN'),
        dtformat = ('%m/%d/%Y'),

        datetime = 0,
        time = -1,
        high = -1,
        low = -1,
        volume = -1,
        openinterest = -1,

        close = 5,
        open = 2,
    )

    cerebro.adddata(data)

    cerebro.broker.setcash(100000.0)

    cerebro.run()
    #cerebro.plot(volume=False)
        