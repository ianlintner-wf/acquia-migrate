# acquia-migrate
Scripts to migrate one acquia cloud enviornment to another. Scripts allow for a repeatable transfer of database & files that may be required multiple times during a site migration for testing and then just prior to the final DNS updates to minimize down time or site content freeze.

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
- Run backup-files.sh & migrate-files.sh as needed during testing & final cut-over
- Run backup-sql.sh & migrate-sql.sh as needed during testing & final cut-over

## Script Listing

### backup-files.sh
**Run on existing server/site**

Backup a file directory useful for private files that may not be included or backup after initial import. The backup is stored in ~/export/files-export.tar.gz

```bash
./backup-files.sh pubsite prod sites/default/files-private
```

### backup-sql.sh
**Run on existing server/site**

Backup of sql database on demand copies the last backup to ~/export/sql-export.sql.gz

```bash
./backup-sql.sh pubsite prod www
```

### files-migrate.sh
**Run on new server/site**

Transfer via SCP & Import a files backup from another server created by backup-files.sh

```bash
./files-migrate.sh srv-1234.devcloud.hosting.acquia.com pubsite prod sites/default/files-private
```

### sql-migrate.sh
**Run on new server/site**

Import a sql backup from another server created by backup-sql.sh

```bash
./sql-migrate.sh srv-1234.devcloud.hosting.acquia.com pubsite dev
```

### site-import.sh
**Run on new server/site**

Perform initial site export/import via drush

```bash
./site-import.sh srv-1234.devcloud.hosting.acquia.com pubsite prod pubsite dev
```
