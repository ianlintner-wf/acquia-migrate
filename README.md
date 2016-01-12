# acquia-migrate
Scripts to migrate one acquia cloud enviornment to another

## Script Listing

### backup-files.sh
Backup a file directory useful for private files that may not be included or backup after initial import. The backup is stored in ~/export/files-export.tar.gz

```bash
./backup-files.sh pubsite prod sites/default/files-private
```

### backup-sql.sh
Backup of sql database on demand copies the last backup to ~/export/sql-export.sql.gz

```bash
./backup-sql.sh pubsite prod www
```
