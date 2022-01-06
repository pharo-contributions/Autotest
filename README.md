# Autotest
Autotest is a live testing tool for [Pharo](https://www.pharo.org)

## Video

Please check [Autotest for Pharo](https://vimeo.com/12666507) from [Laurent Laffont](https://vimeo.com/laurentlaffont)

## Install
You can install **Autotest** tool by executing the following load scripts:

```Smalltalk
Metacello new 
	repository: 'github://pharo-contributions/Autotest:main/src';
	baseline: 'Autotest';
	load 	
```	

## Run

You can run the code using:

```Smalltalk
AutotestDashboard showAutotestDashboard: true
```	
or manually changing the settings

# Screenshot

![Autotest in Pharo](https://raw.githubusercontent.com/pharo-contributions/Autotest/main/autotest.jpg "Autotest in Pharo 10")

## History

Autotest was originally created by Laurent Laffont in Pharo 2.0, back then hosted on SqueakSource, later on SmalltalkHub sourcecode server before it was migrated to GitHub. It received various contributions from members of the Pharo community like

- Laurent Laffont
- Benjamin Van Ryseghem
- Benoit Verhaeghe
- Sean DeNigris
- Daniel Uber
- Torsten Bergmann
- Dale Henrichs
- Mariano Martinez Peck
- Patrick Barroca
- Jannik Laval

Last source code was available on [http://smalltalkhub.com/LaurentLaffont/Autotest/index.html](http://smalltalkhub.com/LaurentLaffont/Autotest/index.html) and was then migrated over to GitHub. See also [Laurent Laffonts tweet](https://twitter.com/lolgzs/status/396669464764502016) and [Blog post](http://magaloma.blogspot.com/2010/06/autotest-for-pharo.html)

There was also another repo at [http://smalltalkhub.com/Pharo/AutoTest/mc/](http://smalltalkhub.com/Pharo/AutoTest/mc/)
