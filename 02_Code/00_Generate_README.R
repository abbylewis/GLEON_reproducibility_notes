# Make a README file
pak::pak("EIvimeyCook/READMEBuilder")
#renv::install("EIvimeyCook/READMEBuilder")
library(READMEBuilder)
build_readme()

# Use RENV to archive package versions

renv::init() #Initialize
renv::snapshot() #Store a record of current versions
renv::restore() #Someone on a new computer could run this to get your same versions
renv::update() #Update all packages
renv::snapshot() #Save these new versions in the lockfile
