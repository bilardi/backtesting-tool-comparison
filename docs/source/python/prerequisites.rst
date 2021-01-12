Prerequisites
#############

For using the program language Python, you don't have to install nothing:
Python is already installed.

There are a lot of guide for `getting started with Python <https://wiki.python.org/moin/BeginnersGuide/>`_:
knowing the basics will be taken for granted.

But you have to install some specific packages and it is a best practice to use a virtual environment.
For unix,

.. code-block:: bash

    $ git clone https://github.com/bilardi/backtesting-tool-comparison
    $ cd backtesting-tool-comparison/
    $ python3 -m venv .env # create virtual environment
    $ source .env/bin/activate # enter in the virtual environment
    $ pip install --upgrade -r requirements.txt # install your dependences

And when you want to delete all environment,

.. code-block:: bash

    $ deactivate # exit when you will have finished the job
    $ rm -rf .env # remove the virtual environment it is a best practice

A short description of each package that you have to import is below.

.. code-block:: bash

    $ python
    import yfinance # for Yahoo Finance historical data of stock market
    import yahoo-fin # for Yahoo Finance historical data of stock market
    import yahoofinancials # for Yahoo Finance historical data of stock market
    import pandas_datareader # for historical data many sources
    import datetime # for datetime management
    import requests # for getting contents by url
    import quandl # for Quandl historical data
    import matplotlib # for plots
    import mplfinance # for financial plots
    import pandas # for data management
    import numpy # for data management
    import backtesting # for strategy management

If you want to use `Jupyter <https://jupyter.org/>`_, you can use directly the commands below

.. code-block:: bash

    $ git clone https://github.com/bilardi/backtesting-tool-comparison
    $ cd backtesting-tool-comparison/
    $ pip install --upgrade -r requirements.txt
    $ docker run --rm -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v "$PWD":/home/jovyan/ jupyter/scipy-notebook

Jupyter is very easy for `having a GUI virtual environment <https://jupyter-docker-stacks.readthedocs.io/it/latest/>`_: knowing the basics will be taken for granted.

You can find all scripts descripted in this tutorial on `GitHub <https://github.com/bilardi/backtesting-tool-comparison/tree/master/src/>`_.

* the .py files in src/ folder, the you can use on shell
* the .ipynb files in docs/sources/python/ folder, that you can use on Jupyter or browse on this tutorial
