# Updating and uploading data

# 1 - Updating

SQL allows us to update data on tables pretty easily, we simply need:
- `UPDATE`: name the table to update
- `SET`: select the columns to update, and the value to set it to
- `WHERE`: the conditions the updated rows must fulfill (this statement is mandatory)

> Note: a `WHERE 1=1` can be used if all rows should be updated.

Example:

```sql
UPDATE my_table
SET student_lastname = 'Hidalgo' 
WHERE student_lastname IS NULL;
```
- Query replacing all `NULL` values by a default lastname
