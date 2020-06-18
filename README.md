Synchronize github master/develop branch with a google cloud storage bucket.  
The action will look for buckets in the project associated with your credentials.

If the bucket matches the pattern 'bucket_pattern-dev' it will sync the develop branch.  
If the bucket matches the pattern 'bucket_pattern-prod' it will sync the master branch.

Requirements:
- An existing empty gcs bucket with an unique pattern that will be dedicated to only contain the git repository.  
WARNING: It will sync the github repository, so any existing files in the bucket that aren't in the github repository will be deleted!
- A service account with access to the bucket.
- Key in json format to this service account.

Steps:
- In the repo settings add a secret named "secrets" that contains your google credentials in json format
- Add a workflow to your repository, see example at https://github.com/aroelo/sync_to_gcs/blob/master/.github/workflows/sync-to-gcs.yml
- Fill in the right 'bucket_pattern'. This pattern will be used to get the right bucket from all buckets listed in your project.

E.g. the bucket_pattern could be 'github-sync' with corresponding bucket names:  
`github-sync-dev`  
`github-sync-prod`

Repository dispatch:  
The example workflow is also set-up to be used with repository dispatch events.
This requires a github token and that the github workflow is committed to the default (master) branch, see http://www.btellez.com/posts/triggering-github-actions-with-webhooks.html.  
Example url for repository dispatch:  
`curl -X POST https://api.github.com/repos/<owner>/<repo_of_interest>/dispatches -H 'Accept: application/vnd.github.everest-preview+json' -H 'Authorization: token $TOKEN' --data '{"event_type": "dev"}'`  
or    
`curl -X POST https://api.github.com/repos/<owner>/<repo_of_interest>/dispatches -H 'Accept: application/vnd.github.everest-preview+json' -H 'Authorization: token $TOKEN' --data '{"event_type": "prod"}'`

Unfortunately repository dispatch currently also triggers master branch to sync when event is 'dev'.

