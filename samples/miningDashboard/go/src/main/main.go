package main  
      
import (  
	"fmt"  
	// "os"
	// "os/exec"
	// "strings"
	helper "../mining_helper"
	"../tools"
)

func main() {  
	//fmt.Println(miningHelper.shell_exec("cal"))
	user := tools.Get_user_name()
	fmt.Println(user)
	
	sqlite3_file := fmt.Sprintf("/home/%s/.config/trustnote-pow-supernode/trustnote.sqlite",user)

	fmt.Println(sqlite3_file)

	address := helper.Get_address(sqlite3_file)


	
	fmt.Println(address)
	

}
