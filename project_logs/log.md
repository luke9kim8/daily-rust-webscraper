# Project Log
### 1/1/2022
Scalpel library can't scrape JS rendered pages so we need to use a browser automation tool like Selenium. `webdriver` is a Haskell wrapper around Selenium. I had issues trying to get the [example code](https://github.com/kallisti-dev/hs-webdriver/blob/master/examples/readme-example-beginner.md#hello-world) working. These steps helped me to get around them.

1. Make sure you have the selenium server .jar file installed in your project root
2. Make sure you export system property `export JAVA_TOOL_OPTIONS=webdriver.chrome.driver=/Users/lukekim/Utility/webdrivers/chromedriver`. If this doesn't work, set the property via command line `java -jar [path to selenium .jar file] -Dwebdriver.chrome.driver=/Users/lukekim/Utility/webdrivers/chromedriver`

I tried using `executeJS` in `webdriver` to spin until `document.readyState === 'complete'` but it doesn't work because it is set to loading once we start scrolling down. Selenium needs to scroll for a few seconds. Also this [post](https://stackoverflow.com/a/15136386/14213201) says Selenium by default waits for readyState to be complete (and a bit more).

Alternative is to send `arrowDown` key many times till we reach the end of the post. This is really janky but there is no scroll function in `webdriver`. We can do this with the control monad `replicateM_`.

We can now scroll till the end of the comment section, but now the comments are hidden behind a link (aka "Continue this thread"). This is not an issue when we use Firefox, but if I try to run the scraper with FF, it gives me `ConnectionFailure Network.Socket.connect: <socket: 71>: does not exist (Connection refused))`.

My next thought was to specify the path to selenium driver to webdriver browser as specified [here](https://hackage.haskell.org/package/webdriver-0.9.0.1/docs/Test-WebDriver-Capabilities.html#t:HasCapabilities). You can install the selenium driver from the selenium webpage, search for geckodriver in google.

Turns out using `geckodriver` as a browser binary does not work. I have to use the actual firefox binary, which is located in `/Applications/Firefox.app/Contents/MacOS/firefox-bin`


