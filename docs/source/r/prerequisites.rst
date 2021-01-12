Prerequisites
#############

For using the program language R, you have to `install r <https://cran.r-project.org/mirrors.html>`_.

For mac,

.. code-block:: bash

    $ brew install r

There are a lot of guide for `getting started with R <https://cran.r-project.org/doc/contrib/Paradis-rdebuts_en.pdf>`_: knowing the basics will be taken for granted.
For installing some packages, you can use `RStudio <https://rstudio.com/products/rstudio/download/#download>`_ or directly console

.. code-block:: bash

    $ r
    # general tools
    install.packages("httr")
    install.packages("jsonlite")
    install.packages("plotly")
    install.packages("devtools")
    # for downloading data
    install.packages("quantmod") # for Yahoo finance historical data of stock market
    install.packages("Quandl")
    devtools::install_github("amrrs/coinmarketcapr") # for Crypto currencies
    devtools::install_github("amrrs/coindeskr") # for Crypto currencies
    # for processing the data: in addition to Quantmod also QuantStrat
    devtools::install_github("braverock/blotter")
    devtools::install_github("braverock/quantstrat")

If you want to use `Jupyter <https://jupyter.org/>`_, you can use directly the commands below

.. code-block:: bash

    $ git clone https://github.com/bilardi/backtesting-tool-comparison
    $ cd backtesting-tool-comparison/
    $ docker run --rm -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes -v "$PWD":/home/jovyan/ jupyter/r-notebook

Jupyter is very easy for `having a GUI virtual environment <https://jupyter-docker-stacks.readthedocs.io/it/latest/>`_: knowing the basics will be taken for granted.

You can find all scripts descripted in this tutorial on `GitHub <https://github.com/bilardi/backtesting-tool-comparison/>`_:

* src/r/, the script that you can use on RStudio
* the .ipynb files in docs/sources/r/, that you can use on Jupyter or browse on this tutorial
