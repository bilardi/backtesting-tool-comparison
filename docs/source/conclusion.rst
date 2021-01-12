Conclusion
##########

Historical data
***************

The samples that you find in this tutorial they use the same **data reader**: `Yahoo Finance API <https://rapidapi.com/apidojo/api/yahoo-finance1>`_. 

This is a tutorial, so it is for educational purpose, and it is not important the results. 
Each historical data contains some differences among others, so it is very important understanding when using which source.

At the beginning, when you test your code, or learn your instruments, you can also use free historical data.
In a perfect system, when your QT system will become your demo and your business, you have to use paid historical data of the trading platform where you will do your demo and your business.

Why do you have to use the same historical data of the trading platform where you will do your demo and your business ?

* for avoiding the closing differences or other, that they would completely change the backtesting results
* for being prepared for any issue related to those data that will be used for your business (see the `Comparison <https://backtesting-tool-comparison.readthedocs.io/en/latest/comparison.html>`_ section for details)

Analysis
********

You cannot make backtesting without defining your trading strategy. And you may not use your trading strategy live without analyze the financial historical data by backtesting.

You can use existing indicators and yours for defining **resistence points** and **signals**.

Coming soon.

Best practice
*************

You can use the command line, an IDE or a (Jupyter) notebook for your favorite language or directly a trading platform console, but the rules below do not change: you have to

* evaluate your data source and to check (*) that your driver is working properly
* test your code by TDD every time that you change it
* check (*) your algorithm and its parameters by your backtesting system
* evaluate the hosting where you run your QT system and to check (*) that your QT system did not reach its limits
* define when your QT system does not have to work

(*) it would be great if each check can run to warn you with a channel you follow about

* information of the next release of your driver, your hosting, .. or your trading platform
* your algorithm performance

At the beginning, the checks can be executed with a wide cadence, until you find how often each check should be performed according to your expectations.
In a perfect system, when your QT system will become your business, the checks will be executed continuously or with a tight cadence.
