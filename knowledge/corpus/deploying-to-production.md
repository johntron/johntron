# Deploying to production

We always want to ship high-quality code, so everything that goes to production should run through our various suites of automated tests. Many of these tests run long before a deployment commences in other non-prod pipelines. After these non-prod pipelines complete, there will be an artifact in the form of a Docker image. This artifact - combined with an appropriate set of configuration - can be deployed to other environments as well, including prod.

## Docker images (code)

Every build should upload a resulting Docker image to a container registry, and these images are tagged with metadata like the git branch name and commit the image is based on. Simply search the container registry for the image corresponding to the commit you’d like to deploy; however, it needs valid configuration in the form of Kubernetes manifests - see the next section.

## Kubernetes manifests (configuration)

For a variety of reasons, we want the things to deploy to be exactly the same as the things that were vetted in our pipelines, even if this vetting process (running tests) happens long before a deploy to production. Realistically, this isn’t possible, because production will always use different values for things like API URLs, API keys, and secrets; however, we can at least keep the application code exactly the same for all environments. All the other values that differ between environments can be thought of as configuration, and we use Kubernetes manifests to specify this part of a deploy.

## Git commits (code + configuration)

Git commit SHA’s can be thought of as a complete application - something that can be deployed - because they contain both the code (Docker image) and the configuration (Kubernetes manifests) necessary to start the application; however, we also need to consider the larger ecosystem of services.

## System dependencies

An important point to remember during deploy is that our application is not an island. It relies on other services, and it’s been built with lots of assumptions around access, behavior, performance, data formats, and protocols. We’ve also made assumptions about the infrastructure our application runs on.

It’s possible to deploy one set of Docker container and Kubernetes manifests one day, then deploy this identical set again another day and completely different results; the application might behave exactly the same as the previous day, but if a dependency has changed how it responds to our requests, things might break. For this reason, we should avoid checking out old commits and deploying these - see “Reverting changes (rolling forward)” below.

## Initiating a deploy

We should have a pipeline that we can manually trigger for deploying to prod. When we run this pipeline, we can enter the SHA for the code + configuration we’d like to deploy. The pipeline should simply checkout the commit, compile Kubernetes manifests, and commence the deployment.

## Applying fixes to production (rolling forward)

As much as we try to avoid it, a major bug may eventually be deployed to production. In this scenario, we might be inclined to checkout the commit that’s currently in production and apply changes to fix the problem - see “Hotfixes” below; however, we have to consider any other changes that might have been made - to our code and the larger ecosystem - since the previous deploy to production. We also have to recognize that it’s difficult as humans to predict side-effects even from very simple changes.

Our preferred process for getting fixes into production should be:

1. Checkout master with all of our recent changes
2. Use git revert or apply manual fixes and commit
3. Deploy using all of our normal pipelines and processes

This ensures the new code with the revert is vetted using our extensive automated testing and against real, up-to-date services and infrastructure. More importantly it avoids the error-prone, time-consuming process of modifying old code and getting something working in the current ecosystem.

Hesitant? Don’t want to deploy all the latest changes to production just to fix a bug in old code? Here’s a few important points to consider and use as justification: 

* When things aren’t working in production, there tends to be a false sense of urgency. Take a breath and consider how quickly you really need to make the change. What’s the impact? What happens if you take the time to do the right thing?
* We’ll be using feature flags to keep new functionality inactive until we’re ready to release it - even if it’s deployed, it should be dormant. If it’s not new functionality, it’s probably a minor design update or an unrelated fix - we probably want to deploy this.
* Following manual processes for a fix in production diverge from the inherently more mature processes that have been engineered for success. Doing anything other than a normal deploy is inherently error-prone simply for the fact that we do it less often.
* The ability to deploy changes to production quickly and with high confidence is one of the primary reasons for investing so much in automated testing. We should leverage this automation, not avoid it.
* Even if there are manual steps we need to follow (e.g. requesting manual exploratory testing), we would should be following these steps anyways, regardless of how we apply a change.
* The more frequently we deploy the latest changes from master, the less painful our entire process will become. Going through this process gives us a better understanding of the friction and gaps, so we can improve and deploy with more speed / confidence / quality in the future.

Granted, there will still be extreme circumstances that necessitate other approaches. Keep reading.

## Hotfixes (danger zone ⚠️)

Commit SHA’s are what we use to deploy our application, and the commits we typically work with in deploys are to the master branch only; however, we can deploy any commit, even if it’s not on master. For example, it’s possible to checkout a commit that has already been deployed to production, make changes, and the create a new commit. The resulting commit SHA can then be used to deploy a commit to any environment, including prod. This would essentially be a hotfix in the traditional sense.

This form of update to an environment is dangerous, because systems change - the upstream dependencies and credentials used during the first deploy may no longer work the same way. Naively deploying assuming the the things outside of our application are the same is a recipe for disaster. We should instead prefer to follow our normal deployment process for all but the most urgent situations.

## Fast-tracking configuration changes (danger zone ⚠️)

Kubernetes Deployment manifests (deployment.yaml) typically specify a Docker image based on the same commit sha as the deployment.yaml file itself; however, there’s no reason this image tag and git commit have to match. In fact, we can deploy a previously-built copy of our application with a new set of configuration by simply hard-coding the container tag into the Kubernetes manifest and creating a new commit. 

This should be used carefully, because subtle bugs can exist simply due to differences in configuration; test suites that might run as part of a normal deployment process might catch these issues.