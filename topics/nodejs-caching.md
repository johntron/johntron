# Nodejs: caching

# Pros
* Fast, duh...

# Cons
* Rendering is managed out-of-band (e.g. in cache config), so debugging is nontrivial
* Cache could explode if keys are too specific (could cause OOM errors)
