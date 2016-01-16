# acquia-migrate
Scripts to migrate one acquia cloud enviornment to another. Scripts allow for a repeatable transfer of database & files that may be required multiple times during a site migration for testing and then just prior to the final DNS updates to minimize down time or site content freeze.

**This is under current development**

**Note you must have ssh key access to use these scripts. It is reccommended that you use ssh key forwarding ssh -A**

## Example Workflow
- Run site-import on new dev enviornment
- Add additional remote to existing repo (on your computer/laptop)
- Pull [new remote] dev into your local dev branch.
- Make necessary configuration changes to existing dev branch
- Push to [new remote]
- Deploy dev
- Test Server
- If using private files run backup-files.sh on existing prod server/site via ssh
- Copy Database from dev to stage
- Copy Database from dev to production
- Repeat git updates from above for stage & master
- Verify site is running.
- Run migrate-files.sh as needed during testing & final cut-over
- Run migrate-sql.sh as needed during testing & final cut-over
- Cut over DNS

# Script Listing

## Site Import

### site-import.sh
**Run on new server/site**

Perform initial site export/import via drush this should be the first script you run as it performs the initial site
import. Use the other migrate scripts as you go forward during the migration to make periodic updates.

* Runs drush archive-dump to an archive file in the home directory.
* scp the file from the original server to the new server.
* runs drush ah-site-archive-import to perform the final import

```bash
./site-import.sh srv-1234.devcloud.hosting.acquia.com pubsite prod pubsite prod
```

## Partial Migrations
These perform part of the migration process either copy/transfer/import files or sql. Use these as needed to 
keep the migrated site up to date or for the final update prior when cutting over DNS.

Note: The migration will try to insert the settings file if you already have the settings file setup this may cause an error.

### migrate-files.sh
**Run on existing server/site**

Note: can run for all files by specifying directory path or individually 

Runs the following scripts in order
- export-files to create a file archive
- transfer-files-backup to scp the files from existing server
- import extracts the tar backup and move the files to target directory

```bash
./migrate-files.sh srv-1234.devcloud.hosting.acquia.com pubsite prod sites/default/files-private pubsite dev sites/default/files-private
```
Set a date parameter to only get files after a date uses default tar date input formats
```bash
./migrate-files.sh srv-1234.devcloud.hosting.acquia.com pubsite prod sites/default/files-private pubsite dev sites/default/files-private '5 days ago'
```

### migrate-sql.sh
**Run on existing server/site**

NOTE: Currently you must run the backup process manually as the backup command in drush is async.
Also you must run for each database.

Runs the following scripts in order
- export-sql to grab the most recent on-demand backup and put in export directory
- transfer-sql-backup to scp the backup from existing server
- import runs the drush database import

##Utility Scripts
These scripts are can be run by themselves to repeat portions of the migration scripts


### export-files.sh
**Run on existing server/site**

Note: Run multiple times for sites & file directories or attempt to grab all files in sites 

Backup a file directory useful for private files that may not be included or backup after initial import. The backup is stored in ~/export/files-export.tar.gz

```bash
./export-files.sh pubsite prod sites/default/files-private
```

Set a date to only grab files after a date useful for periodic migrations with a large file base
```bash
./export-files.sh pubsite prod sites/default/files-private 20160101
```

### export-sql.sh
**Run on existing server/site**

Note: Run multiple for each database

Backup of sql database on demand copies the last backup to ~/export/sql-export.sql.gz

```bash
./export-sql.sh pubsite prod pubsitedb
```

or you can send it via ssh from the new server

```bash
ssh pubsite.prod@srv-1234.devcloud.hosting.acquia.com "bash -s" < ./export-sql.bash "pubsite" "prod" "www"
```

### transfer-files-backup.sh
**Run on new server/site**

Transfer the files backup from another server created by export-files.sh

```bash
./import-files.sh srv-1234.devcloud.hosting.acquia.com pubsite prod
```

### transfer-sql-backup.sh
**Run on new server/site**

Transfer the sql backup from another server created by export-sql.sh

```bash
./import-files.sh srv-1234.devcloud.hosting.acquia.com pubsite prod
```



### import-files.sh
**Run on new server/site**

Import a files backup from another server created by backup-files.sh

```bash
./import-files.sh pubsite prod sites/default/files-private
```

### import-sql.sh
**Run on new server/site**

Import a sql backup from another server created by export-sql.sh

```bash
./sql-migrate.sh pubsite dev pubsite
```
