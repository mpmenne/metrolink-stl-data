if [ -e "metrolink.db" ]; then
  echo "wiping the existing database"
  rm metrolink.db
fi
touch metrolink.db
sqlite3 metrolink.db < metrolink.sql
sqlite3 metrolink.db < import_raw.sql
