## Hubot Cloud Foundry helpers 

###  Adds a number of (hopefully) helpful [Cloud Foundry](http://cloudfoundry.org)-related status commands to [hubot](http://hubot.github.com)

#### Commands:

Return CF Core information about the specified *API endpoint* 
    
    hubot cf core <API endpoint>

(more commands coming soon)

#### Installation:

**Script method**

```curl|wget https://github.com/andypiper/hubot-cf/raw/master/src/scripts/cf.coffee``` to your hubot installation's ```scripts``` directory.

**npm module method**

In your deployed ```hubot``` directory:

    npm install hubot-cf

Add an entry for ```hubot-cf``` to the ```external-scripts.json``` file (you may need to create this file if it is not present):

    ["hubot-cf"]
    
… and run hubot as normal.

#### License:

Apache 2: http://www.apache.org/licenses/LICENSE-2.0.html

#### References:

 * [cloudfoundry on Github](http://github.com/cloudfoundry)
 * [hubot](http://hubot.github.com)
