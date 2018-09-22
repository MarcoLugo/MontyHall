# Monty Hall Paradox (SAS vs. Python)

I was recently looking for a comparison between SAS and Python on the more technical side of things and instead stumbled on a [article](https://blogs.sas.com/content/sgf/2016/10/12/the-monty-hall-paradox-sas-vs-python/) about a fun paradox. The article was written by SAS Principal Solutions Architect, Andrew Christian, and posted in the SAS Users' blog.

As you probably already guessed, it is the Monty Hall Problem, from [Wikipedia](https://en.wikipedia.org/wiki/Monty_Hall_problem#The_paradox): 

> Suppose you're on a game show, and you're given the choice of three doors: Behind one door is a car; behind the others, goats. You pick a door, say No. 1, and the host, who knows what's behind the doors, opens another door, say No. 3, which has a goat. He then says to you, "Do you want to pick door No. 2?" Is it to your advantage to switch your choice?

The problem uses the following assumptions, again from [Wikipedia](https://en.wikipedia.org/wiki/Monty_Hall_problem#Standard_assumptions):

> The host must always open a door that was not picked by the contestant (Mueser and Granberg 1999).
> The host must always open a door to reveal a goat and never the car.
> The host must always offer the chance to switch between the originally chosen door and the remaining closed door.

In the article, Andrew brings up a point that sparked my interest:

> In terms of number of lines of code required, SAS wins hands down.  I only needed 57 lines of code to get the result in SAS, compared to 74 lines in Python. I realize that experience has a lot to do with it, but I think there is an inherent verbosity to the Python code that is not necessarily there in SAS. [...] In terms of speed, SAS wins.  On my laptop, I could change the number of rows from 10,000 to 100,000 without noticing much of a difference in speed (0.25 – 0.5 seconds).  In Python, anything over 10,000 got slow.  10,000 rows was 6 seconds, 100,000 rows was 2 minutes 20 seconds.

In the comments, someone does their own implementation of the Monty Hall Problem in Python with much better results, as Andrew puts it:

> Zangror's code above runs on my computer in less than 3 seconds for 10,000 observations and 10 seconds for 100,000 observations. While it still doesn't equate to SAS' performance, this is a marked improvement and proves the point that regardless of the hardware, performance is still largely in the hands of the coder.
If your code runs slow, it's easy to blame the computer or maybe even the language, but you should always take a hard look at your code and see if your contributing to the problem. Oftentimes, you are. As was the case for me in this example.

From this, I decided to first benchmark their own code on my own computer (and yes, I may need to upgrade my rig soon):

 Language        | Average Time (s)     | Std. Dev. Time (s)  | File | Line Count
| ------------- |:-------------:|:-------------:|:-------------:|:-------------:|
| Python      | 276 | 54.1 | AChristian_MontyHallParadox.ipynb | 74
| SAS      | 0.64 | N/A | AChristian_MontyHallParadox.sas | 57
| Python      | 8.57 | 0.0264 | Zangror_MontyHallParadox.ipynb | 33

I added my own two implementations and was pleasantly surprised with the results, the updated table is below:

 Language        | Average Time (s)     | Std. Dev. Time (s)  | File | Line Count
| ------------- |:-------------:|:-------------:|:-------------:|:-------------:|
| Python      | 276 | 54.1 | AChristian_MontyHallParadox.ipynb | 74
| SAS      | 0.64 | N/A | AChristian_MontyHallParadox.sas | 57
| Python      | 8.57 | 0.0264 | Zangror_MontyHallParadox.ipynb | 33
| Python      | 0.847 | 0.00696 | MontyHallParadox.ipynb | 40
| Python      | 0.135 | 0.00183 | MontyHallParadox2.ipynb | 61

We see that the first implementation is 315 times faster than Andrew's implementation and is very close to the SAS benchmark from Andrew (32% slower but still under a second so not really noticeable). It is also  more than 10 times faster than Zangror's own implementation. As for the second implementation, it is over 6 times faster than the first one, which makes it 1978 times faster than Andrew's benchmark and over 63 times faster than Zangror's own implementation. However, personally, I prefer the first implementation to the second one as it is easier to read and to maintain and unless we are running the simulation thousands of times there should be no practical difference in the outcome as long as it is below a second.

Have you tackled this problem before? Drop me a message :)

