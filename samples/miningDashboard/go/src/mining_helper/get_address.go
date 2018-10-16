package mining_helper
import (
    "database/sql"
    "fmt"
    _ "github.com/mattn/go-sqlite3"
)
func Get_address(sqlite3_file string) string{
    db, err := sql.Open("sqlite3", sqlite3_file)
	check_err(err)
    defer db.Close()
    rows, err := db.Query("select address from my_addresses")
    check_err(err)
    defer rows.Close()
	for rows.Next() {
		var address string
		err = rows.Scan(&address)
        check_err(err) 
		fmt.Println(address)
    }
	return "xxx"
}

func check_err(err error) {
    if err != nil {
        panic(err)
    }
}