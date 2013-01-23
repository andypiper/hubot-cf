## Hubot Cloud Foundry helpers 

Adds a number of (hopefully) helpful [Cloud Foundry](http://cloudfoundry.org)-related status commands to [hubot](http://hubot.github.com)

#### Commands:

Return [Cloud Foundry Core](http://core.cloudfoundry.com) information about the specified *API endpoint* 
    
    hubot cf-core <API endpoint>        

Return information about the status of cloudfoundry.com (via the [Status blog](http://status.cloudfoundry.com))

    hubot cf-status

Return the most recent tweet from the [@cloudfoundry Twitter account](http://twitter.com/cloudfoundry)

    hubot cf-tweet

(more commands coming soon)

#### Installation:

**npm module method**

In your deployed ```hubot``` directory:

    npm install hubot-cf

Add an entry for ```hubot-cf``` to the ```external-scripts.json``` file (you may need to create this file, if it is not present):

    ["hubot-cf"]
    
Run hubot as normal, and the scripts should become available.

#### License:

Apache 2: http://www.apache.org/licenses/LICENSE-2.0.html

#### References:

 * [cloudfoundry on Github](http://github.com/cloudfoundry)
 * [hubot](http://hubot.github.com)

#### Love it/hate it/ideas?

Tweet [@andypiper](http://twitter.com/andypiper) or open an issue on the Github Issue Tracker.