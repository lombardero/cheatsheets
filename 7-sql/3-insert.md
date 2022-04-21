# Inserts in SQL

Inserting data into a table another of the main uses of SQL

# 1 - Insert and Select

`INSERT` can be used to add data generated from another `SELECT` statement. The syntax
to do that is:
```sql
INSERT INTO table_to_insert (these, are, the, column, names) -- all others will use the default value
SELECT the, values, added, into, the_column_names
FROM rest_of_the_query
```

See the example query below, which allows to add a grade of `10/10` for all registered students
named `Manuel`.

```sql
INSERT INTO grade_record (student_id, grade, class_registration_id)
SELECT student.id, '10/10', class_registration.id
FROM student
    LEFT JOIN class_registration
        ON class_registration.student_id = student.id
WHERE student.name = 'Manuel';
```
