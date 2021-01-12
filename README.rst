Getting started
===============

These contents can help you to start with your **quantitative trading** (quant trading or QT) system: you can find some samples for the main steps.

There are

* many platforms can give you historical data
* a lot of program languages that you can use for implementing your strategies
* many trading systems that you can use for backtesting your system

Read the documentation on `readthedocs <https://backtesting-tool-comparison.readthedocs.io/en/latest/>`_ for

* a sample of the main backtesting steps for a few of the main languages are used for statistical analysis, graphics representation and reporting
* `comparison <https://backtesting-tool-comparison.readthedocs.io/en/latest/comparison.html>`_ among languages and methods for **backtesting** your strategies
* the `best practices <https://backtesting-tool-comparison.readthedocs.io/en/latest/conclusion.html>`_ for your **quant trading system**

Goals
#####

These contents can be useful at the beginning, when you are newbie programmer.

And it can help you to evaluate which data, language or trading system you need.

Disclaimer
##########

The strategies contained in this tutorial, are some simple samples for having an idea how to use the libraries:
those strategies are for the educational purpose only. All investments and trading in the stock market involve risk:
any decisions related to buying/selling of stocks or other financial instruments should only be made after a thorough research,
backtesting, running in demo and seeking a professional assistance if required.

Contribution
############

The documentation for **R** and **Python** languages, it has been powered by `Jupyter <https://jupyter.org/>`_:

.. code-block:: bash

    $ git clone https://github.com/bilardi/backtesting-tool-comparison
    $ cd backtesting-tool-comparison/
    $ pip install --upgrade -r requirements.txt
    $ docker run --rm -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v "$PWD":/home/jovyan/ jupyter/datascience-notebook

For testing on your local client the documentation, see this `README.md <https://github.com/bilardi/backtesting-tool-comparison/blob/master/docs/README.md>`_ file.

License
#######

These contents are released under the MIT license. See `LICENSE <https://github.com/bilardi/backtesting-tool-comparison/blob/master/LICENSE>`_ for details.
